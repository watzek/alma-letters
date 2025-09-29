<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0"
xmlns:xsl="http://www.w3.org/1999/XSL/Transform">


<xsl:include href="header.xsl" />
<xsl:include href="senderReceiver.xsl" />
<xsl:include href="mailReason.xsl" />
<xsl:include href="footer.xsl" />
<xsl:include href="style.xsl" />
<xsl:include href="recordTitle.xsl" />
<xsl:template match="/">

<html>
	<!-- this section seems to determines the language of the email -->
	<xsl:if test="notification_data/languages/string">
		<xsl:attribute name="lang">
		<xsl:value-of select="notification_data/languages/string"/>
		</xsl:attribute>
	</xsl:if>

	<!--this section calls the style.xsl template from the components  -->
	<head>
		<title>
			<xsl:value-of select="notification_data/general_data/subject"/>
		</title>
		<xsl:call-template name="generalStyle" />
	</head>

	<body>
	<!--this phrase says if the user for printing name isn't empty, it should be printed -->
	<xsl:if test="notification_data/user_for_printing/name != ''" >
		<h1><strong><xsl:value-of select="notification_data/user_for_printing/name"/></strong></h1>
	</xsl:if>
	
	<!--this phrase says if the partner name isn't empty, break up the incoming request note so it can be used to populate the Requester's Name, and the Ship To/Pickup At sections -->
	<xsl:if test="notification_data/incoming_request/partner_name != ''" >
		<xsl:variable name="noteline" select="notification_data/incoming_request/note"/>
		<xsl:variable name="notepart1" select="substring-after($noteline, '||')"/>
		<xsl:variable name="fullname" select="substring-before($notepart1, '||')"/>
		<xsl:variable name="notepart2" select="substring-after($notepart1, '||')"/>
		<xsl:variable name="libraryname" select="substring-after($notepart2, '||')"/>
		<tr><td><h1><strong><xsl:value-of select="$fullname"/></strong></h1></td></tr>
	
	<!--this sections populates the Ship To line on the slips, either by using the partner name or the libraryname for each of our Alliance libraries -->		
		<xsl:choose>
			<xsl:when test="notification_data/incoming_request/partner_name='CC'">
				<tr><td><h2><strong>Ship To: CLARK - Clark Coll</strong></h2></td></tr>
			</xsl:when>
			<xsl:when test="notification_data/incoming_request/partner_name='CCC'">
				<tr><td><h2><strong>Ship To: CLCKM - Clackamas CC</strong></h2></td></tr>
			</xsl:when>	
			<xsl:when test="contains(notification_data/incoming_request/partner_name, 'Chemeketa') or notification_data/incoming_request/partner_name='CHEMEK'">
				<tr><td><h2><strong>Ship To: CHEMEK - Chemeketa CC</strong></h2></td></tr>
			</xsl:when>				
			<xsl:when test="notification_data/incoming_request/partner_name='COCC'">
				<tr><td><h2><strong>Ship To: COCC - Central Oregon CC</strong></h2></td></tr>
			</xsl:when>	
			<xsl:when test="contains(notification_data/incoming_request/partner_name, 'Central Washington') or notification_data/incoming_request/partner_name='CWU'">
				<tr><td><h2><strong>Ship To: CWU - Central WA U</strong></h2></td></tr>
			</xsl:when>	
			<xsl:when test="notification_data/incoming_request/partner_name='EOU'">
				<tr><td><h2><strong>Ship To: EOU - Eastern OR U</strong></h2></td></tr>
			</xsl:when>	
			<xsl:when test="contains(notification_data/incoming_request/partner_name, 'Evergreen State') or notification_data/incoming_request/partner_name='EVSC'">
				<tr><td><h2><strong>Ship To: TESC - The Evergreen State C</strong></h2></td></tr>
			</xsl:when>				
			<xsl:when test="notification_data/incoming_request/partner_name='EWU JFK'">
				<tr><td><h2><strong>Ship To: EWU - Eastern WA U</strong></h2></td></tr>
			</xsl:when>	
			<xsl:when test="notification_data/incoming_request/partner_name='GFOX_MLRC'">
				<tr><td><h2><strong>Ship To: GFOX - George Fox U</strong></h2></td></tr>
			</xsl:when>	
			<xsl:when test="notification_data/incoming_request/partner_name='GONZ'">
				<tr><td><h2><strong>Ship To: GONZ - Gonzaga U</strong></h2></td></tr>
			</xsl:when>	
			<xsl:when test="notification_data/incoming_request/partner_name='LANECC'">
				<tr><td><h2><strong>Ship To: LANE - Lane CC</strong></h2></td></tr>
			</xsl:when>		
			<xsl:when test="notification_data/incoming_request/partner_name='LCC'">
				<tr><td><h2><strong>Ship To: LEWIS - Lewis &amp; Clark Coll</strong></h2></td></tr>
			</xsl:when>	
			<xsl:when test="$libraryname='McMinnville' or $libraryname='OCE via Mail'">
				<tr><td><h2><strong>Ship To: LINF-MAC - Linfield U McM</strong></h2></td></tr>
			</xsl:when>	
			<xsl:when test="$libraryname='Portland' and contains(notification_data/incoming_request/partner_name, 'LINF')">
				<tr><td><h2><strong>Ship To: LINF-PDX - Linfield U Portland</strong></h2></td></tr>
			</xsl:when>		
			<xsl:when test="notification_data/incoming_request/partner_name='MHCC'">
				<tr><td><h2><strong>Ship To: MHCC - Mt. Hood CC</strong></h2></td></tr>
			</xsl:when>		
			<xsl:when test="contains(notification_data/incoming_request/partner_name, 'Oregon Health') or notification_data/incoming_request/partner_name='OHSU'">
				<tr><td><h2><strong>Ship To: OHSU - Oregon Health &amp; Sci U</strong></h2></td></tr>
			</xsl:when>				
			<xsl:when test="$libraryname='Klamath Falls Library'">
				<tr><td><h2><strong>Ship To: OIT-KFLS - Oregon Tech KFalls</strong></h2></td></tr>
			</xsl:when>	
			<xsl:when test="$libraryname='Portland-Metro Library'">
				<tr><td><h2><strong>Ship To: OIT-PM - Oregon Tech Portland</strong></h2></td></tr>
			</xsl:when>
            <xsl:when test="$libraryname='Personal Delivery'and contains(notification_data/incoming_request/partner_name, 'OSU')">
                <tr><td><h2><strong>Ship To: OSU-COR - Oregon State University Corvallis</strong></h2></td></tr>
            </xsl:when>
            <xsl:when test="$libraryname=' Valley Library-Corvallis' or notification_data/incoming_request/partner_name='OSU'">
                <tr><td><h2><strong>Ship To: OSU-COR - Oregon State U Cor</strong></h2></td></tr>
            </xsl:when>
            <xsl:when test="$libraryname='OSU-Cascades Library-Bend' or notification_data/incoming_request/partner_name='OSU_BEND'">
                <tr><td><h2><strong>Ship To: OSU-BEND - Oregon State U Casc</strong></h2></td></tr>
            </xsl:when>
            <xsl:when test="$libraryname='Guin Library-Newport' or notification_data/incoming_request/partner_name='OSU_NEWPORT'">
                <tr><td><h2><strong>Ship To: OSU-NEWP - Oregon State U Newp</strong></h2></td></tr>
            </xsl:when> 
			<xsl:when test="contains(notification_data/incoming_request/partner_name, 'Rock Creek') or notification_data/incoming_request/partner_name='PCC'">
				<tr><td><h2><strong>Ship To: PCC - Portland CC</strong></h2></td></tr>
			</xsl:when>				
			<xsl:when test="contains(notification_data/incoming_request/partner_name, 'PSU')">
				<tr><td><h2><strong>Ship To: PSU - Portland State U</strong></h2></td></tr>
			</xsl:when>	
			<xsl:when test="$libraryname='Eugene' or $libraryname='Forest Grove' or $libraryname='Woodburn'">
				<tr><td><h2><strong>Ship To: PU-FG - Pacific U Forest Grove</strong></h2></td></tr>
			</xsl:when>	
			<xsl:when test="$libraryname='Hillsboro'">
				<tr><td><h2><strong>Ship To: PU-HILS - Pacific U Hillsboro</strong></h2></td></tr>
			</xsl:when>	
			<xsl:when test="contains (notification_data/incoming_request/partner_name, 'Reed') or notification_data/incoming_request/partner_name='REED'">
				<tr><td><h2><strong>Ship To: REED - Reed Coll</strong></h2></td></tr>
			</xsl:when>		
			<xsl:when test="notification_data/incoming_request/partner_name='SEAU_LEMIEUX' or notification_data/incoming_request/partner_name='SEAU_LAW'">
				<tr><td><h2><strong>Ship To: SEAU - Seattle U</strong></h2></td></tr>
			</xsl:when>	
			<xsl:when test="$libraryname='Hannon Library' or contains(notification_data/incoming_request/partner_name, 'Southern Oregon')">
				<tr><td><h2><strong>Ship To: SOU - Southern OR U</strong></h2></td></tr>
			</xsl:when>
			<xsl:when test="$libraryname='Medford - RCC'">
				<tr><td><h2><strong>Ship To: RCC - Rogue CC/SOU</strong></h2></td></tr>
			</xsl:when>	
			<xsl:when test="notification_data/incoming_request/partner_name='SPU'">
				<tr><td><h2><strong>Ship To: SPU - Seattle Pacific U</strong></h2></td></tr>
			</xsl:when>	
			<xsl:when test="notification_data/incoming_request/partner_name='STMU'">
				<tr><td><h2><strong>Ship To: STMU - Saint Martin's U</strong></h2></td></tr>
			</xsl:when>	
			<xsl:when test="contains(notification_data/incoming_request/partner_name, 'UI ') or contains(notification_data/incoming_request/partner_name, 'UID')">
				<tr><td><h2><strong>Ship To: UI - U Idaho</strong></h2></td></tr>
			</xsl:when>
			<xsl:when test="notification_data/incoming_request/partner_name='UO' and contains($libraryname, 'Delivery')">
				<tr><td><h2><strong>Ship To: UO-EUG - University of Oregon Eugene</strong></h2></td></tr>
			</xsl:when>	
			<xsl:when test="$libraryname='Design Library' or $libraryname='John E. Jaqua Law Library' or $libraryname='Knight Library' or $libraryname='Mathematics Library' or $libraryname='Price Science Commons and Research Library'">
				<tr><td><h2><strong>Ship To: UO-EUG - U Oregon Eugene</strong></h2></td></tr>
			</xsl:when>
			<xsl:when test="contains(notification_data/incoming_request/partner_name, 'Knight Library')">
				<tr><td><h2><strong>Ship To: UO-EUG - U Oregon Eugene</strong></h2></td></tr>
			</xsl:when>				
			<xsl:when test="$libraryname='UO Portland Library'">
				<tr><td><h2><strong>Ship To: UO-PDX - U Oregon Portland</strong></h2></td></tr>
			</xsl:when>
			<xsl:when test="notification_data/incoming_request/partner_name='UPORT'">
				<tr><td><h2><strong>Ship To: UPORT - U Portland</strong></h2></td></tr>
			</xsl:when>	
			<xsl:when test="notification_data/incoming_request/partner_name='UPUGS'">
				<tr><td><h2><strong>Ship To: UPUGS - U Puget Sound</strong></h2></td></tr>
			</xsl:when>	
			<xsl:when test="notification_data/incoming_request/partner_name='UW'">
				<tr><td><h2><strong>Ship To: UW - U Washington</strong></h2></td></tr>
			</xsl:when>	
			<xsl:when test="$libraryname='PML' or $libraryname='Billings' or $libraryname='Missoula'">
				<tr><td><h2><strong>Ship To: WALLA - Walla Walla U</strong></h2></td></tr>
			</xsl:when>	
			<xsl:when test="$libraryname='Portland' and contains(notification_data/incoming_request/partner_name, 'WALLA')">
				<tr><td><h2><strong>Ship To: WPU - Warner Pacific U / 
						<br/>(Participating) Walla Walla University - School of Nursing</strong></h2></td></tr>
			</xsl:when>	
			<xsl:when test="notification_data/incoming_request/partner_name='WHITC'">
				<tr><td><h2><strong>Ship To: WHITC - Whitman Coll</strong></h2></td></tr>
			</xsl:when>	
			<xsl:when test="notification_data/incoming_request/partner_name='WOU' or contains(notification_data/incoming_request/partner_name, 'Western Oregon')">
				<tr><td><h2><strong>Ship To: WOU - Western OR U</strong></h2></td></tr>
			</xsl:when>	
			<xsl:when test="notification_data/incoming_request/partner_name='WPC'">
				<tr><td><h2><strong>Ship To: WPU - Warner Pacific U</strong></h2></td></tr>
			</xsl:when>	
			<xsl:when test="contains($libraryname, 'Pullman') or $libraryname='WSU Global Campus Delivery' or $libraryname='WSU Extension Office Delivery' or $libraryname='Owen Science and Engineering Library' or $libraryname='Kemble Stout Music Listening Library' or $libraryname='Holland and Terrell Libraries' or $libraryname='Everett Campus Delivery'">
				<tr><td><h2><strong>Ship To: WSU-PUL - Wash State U Pullman</strong></h2></td></tr>
			</xsl:when>	
			<xsl:when test="contains(notification_data/incoming_request/partner_name, 'Holland')">
				<tr><td><h2><strong>Ship To: WSU-PUL - Wash State U Pullman</strong></h2></td></tr>
			</xsl:when>	
			<xsl:when test="$libraryname='WSU Health Sciences Library' or $libraryname='Nursing@Yakima Summit Location'">
				<tr><td><h2><strong>Ship To: WSU-SPOK - Wash State U Spokane</strong></h2></td></tr>
			</xsl:when>	
			<xsl:when test="contains(notification_data/incoming_request/partner_name, 'WSU Health')">
				<tr><td><h2><strong>Ship To: WSU-SPOK - Wash State U Spokane</strong></h2></td></tr>
			</xsl:when>			
			<xsl:when test="$libraryname='Tri-Cities Library' or $libraryname='Tri-Cities Office Delivery'">
				<tr><td><h2><strong>Ship To: WSU-TRI - Wash State U TriCities</strong></h2></td></tr>
			</xsl:when>	
			<xsl:when test="contains(notification_data/incoming_request/partner_name, 'Tri-Cities')">
				<tr><td><h2><strong>Ship To: WSU-TRI - Wash State U TriCities</strong></h2></td></tr>
			</xsl:when>
			<xsl:when test="$libraryname='Vancouver Library' or $libraryname='Vancouver Office Delivery'">
				<tr><td><h2><strong>Ship To: WSU-VAN - Wash State U Van</strong></h2></td></tr>
			</xsl:when>
			<xsl:when test="contains(notification_data/incoming_request/partner_name, 'Vancouver')">
				<tr><td><h2><strong>Ship To: WSU-VAN - Wash State U Van</strong></h2></td></tr>
			</xsl:when>				
			<xsl:when test="$libraryname='MOH' or $libraryname='WU LAW'">
				<tr><td><h2><strong>Ship To: WILL - Willamette U</strong></h2></td></tr>
			</xsl:when>	
			<xsl:when test="$libraryname='PNCA'">
				<tr><td><h2><strong>Ship To: PNCA - PNW Coll of Art/WILL</strong></h2></td></tr>
			</xsl:when>	
			<xsl:when test="notification_data/incoming_request/partner_name='WW'">
				<tr><td><h2><strong>Ship To: WWORTH - Whitworth U</strong></h2></td></tr>
			</xsl:when>	
			<xsl:when test="notification_data/incoming_request/partner_name='WWU'">
				<tr><td><h2><strong>Ship To: WWU - Western WA U</strong></h2></td></tr>
			</xsl:when>	
			<!--this phrase says if none of the above tests are triggered, print the partner code from the XML in the Ship To: line -->
			<xsl:otherwise>
				<tr><td><h2><strong>Ship To: <xsl:value-of select="notification_data/incoming_request/partner_name"/></strong></h2></td></tr>
			</xsl:otherwise>
		</xsl:choose>	
		<tr>
		<!--this phrase says if the request note isn't empty, print the library name in the Pickup Location: line -->
		<xsl:if test="notification_data/incoming_request/note != ''" >
		<td><h2><strong>Pickup Location : <xsl:value-of select="$libraryname"/></strong></h2></td>
		</xsl:if>
		</tr>

    </xsl:if>

	<!--this section pulls in the header template from the components - it supplies the logo, the name of the slip, and in most cases, the date -->
	<xsl:call-template name="head" /> <!-- header.xsl -->

	<div class="messageArea">
		<div class="messageBody">
			 <table role='presentation'  cellspacing="0" cellpadding="5" border="0">

				<!-- this section lets the page know whether it's an item or holdings request -->
				<xsl:if  test="notification_data/request/selected_inventory_type='ITEM'" >
					<tr><td><strong>@@note_item_specified_request@@.</strong></td></tr>
				</xsl:if>

				<!-- I have not seen this section in use and am curious about it's value and inclusion -->						
				<xsl:if  test="notification_data/request/manual_description != ''" >
					<tr><td><strong>@@please_note@@: </strong>@@manual_description_note@@ - <xsl:value-of select="notification_data/request/manual_description"/></td></tr>
				</xsl:if>
				
				<!-- this section provides the shelving information for the page to find the item -->
				<tr><td><h3><strong>@@location@@: </strong><xsl:value-of select="notification_data/phys_item_display/location_name"/></h3></td></tr>
				<xsl:if test="notification_data/phys_item_display/call_number != ''">
					<tr><td style="border: 2px solid black;"><h2>@@call_number@@: <xsl:value-of select="notification_data/phys_item_display/call_number"/></h2></td></tr>
				</xsl:if>
				<xsl:if  test="notification_data/request/selected_inventory_type='ITEM'" >
					<tr><td><h3><strong>@@item_barcode@@: </strong><xsl:value-of select="notification_data/phys_item_display/available_items/available_item/barcode" /></h3></td></tr>
				</xsl:if>
				
				<!-- this section will display the External ID as a scannable image if this is not a local request -->		
				<xsl:if  test="notification_data/incoming_request/external_request_id != ''" >
					<tr><td><strong>@@external_id@@: </strong><img src="cid:externalId.png" alt="External Request ID" height="90"/></td></tr>
				</xsl:if>
				
				<!-- this section displays information about the item, an the first line calls the recordtitle template which allows the title and author to display more neatly -->				
				<tr><td><strong>Title:  </strong><xsl:call-template name="recordTitle" /></td></tr>

				<xsl:if test="notification_data/phys_item_display/isbn != ''">
					<tr><td><strong>@@isbn@@: </strong><xsl:value-of select="notification_data/phys_item_display/isbn"/></td></tr>
				</xsl:if>
				<xsl:if test="notification_data/phys_item_display/issn != ''">
					<tr><td><strong>@@issn@@: </strong><xsl:value-of select="notification_data/phys_item_display/issn"/></td></tr>
				</xsl:if>
				<xsl:if test="notification_data/phys_item_display/edition != ''">
					<tr><td><strong>@@edition@@: </strong><xsl:value-of select="notification_data/phys_item_display/edition"/></td></tr>
				</xsl:if>
	   			<!-- this section will display the volumes requested if they were indicated in the request -->
    			<xsl:variable name="request_metadata_string" select="notification_data/incoming_request/request_metadata"/>
    			<xsl:variable name="mv_volume_string" select="substring-after($request_metadata_string, 'dc:volume&gt;')"/>
    			<xsl:variable name="mv_volume" select="substring-before($mv_volume_string, '&lt;/dc:volume')"/>
    			<xsl:if test="$mv_volume != ''" >
       				<tr><td><strong>Volume: </strong> <xsl:value-of select="$mv_volume"/></td></tr>
     			</xsl:if> 							
				<xsl:if test="notification_data/phys_item_display/imprint != ''">
					<tr><td><strong>@@imprint@@: </strong><xsl:value-of select="notification_data/phys_item_display/imprint"/></td></tr>
				</xsl:if>
				<xsl:if test="notification_data/phys_item_display/accession_number != ''">
					<tr><td><h3><strong>@@accession_number@@: </strong><xsl:value-of select="notification_data/phys_item_display/accession_number"/></h3></td></tr>
				</xsl:if>
                 
				<!-- this section is also differentiating an item or holdings request, but I have not seen this section in use  -->						
				<xsl:if  test="notification_data/phys_item_display/shelving_location/string" >
					<xsl:if  test="notification_data/request/selected_inventory_type='ITEM'" >
						<tr><td><strong>@@shelving_location_for_item@@: </strong>
						<xsl:for-each select="notification_data/phys_item_display/shelving_location/string">
							<xsl:value-of select="."/>
								 &#160;
						 </xsl:for-each></td></tr>
					</xsl:if>
					<xsl:if  test="notification_data/request/selected_inventory_type='HOLDING'" >
						<tr><td><strong>@@shelving_locations_for_holding@@: </strong>
						<xsl:for-each select="notification_data/phys_item_display/shelving_location/string">
							<xsl:value-of select="."/>
								&#160;
						 </xsl:for-each></td></tr>
					</xsl:if>
					<xsl:if  test="notification_data/request/selected_inventory_type='VIRTUAL_HOLDING'" >
						<tr><td><strong>@@shelving_locations_for_holding@@: </strong>
						<xsl:for-each select="notification_data/phys_item_display/shelving_location/string">
							<xsl:value-of select="."/>
								&#160;
						</xsl:for-each></td></tr>
					</xsl:if>
				</xsl:if>
						
				<xsl:if  test="notification_data/phys_item_display/display_alt_call_numbers/string" >
					<xsl:if  test="notification_data/request/selected_inventory_type='ITEM'" >
						<tr><td><strong>@@alt_call_number@@: </strong>
						<xsl:for-each select="notification_data/phys_item_display/display_alt_call_numbers/string">
							<xsl:value-of select="."/>
								 &#160;
						</xsl:for-each></td></tr>
					</xsl:if>
					<xsl:if  test="notification_data/request/selected_inventory_type='HOLDING'" >
						<tr><td><strong>@@alt_call_number@@: </strong>
						<xsl:for-each select="notification_data/phys_item_display/display_alt_call_numbers/string">
							<xsl:value-of select="."/>
								&#160;
						 </xsl:for-each></td></tr>
					</xsl:if>
					<xsl:if  test="notification_data/request/selected_inventory_type='VIRTUAL_HOLDING'" >
						<tr><td><strong>@@alt_call_number@@: </strong>
						<xsl:for-each select="notification_data/phys_item_display/display_alt_call_numbers/string">
							<xsl:value-of select="."/>
								&#160;
						</xsl:for-each></td></tr>
					</xsl:if>
				</xsl:if>

				<!-- this section displays information about the item  -->
				<tr><td><strong>@@move_to_library@@: </strong><xsl:value-of select="notification_data/destination"/></td></tr>
				<tr><td><strong>@@request_type@@: </strong><xsl:value-of select="notification_data/request_type"/></td></tr>
				<xsl:if test="notification_data/request/chapter_article_title != ''">
					<tr><td><strong>@@enum_h@@:  </strong><xsl:value-of select="notification_data/request/chapter_article_title"/>, pp. <xsl:value-of select="notification_data/request/pages"/></td></tr>
				</xsl:if>
				<xsl:if test="notification_data/request/system_notes != ''">
					<tr><td><strong>@@system_notes@@:</strong><xsl:value-of select="notification_data/request/system_notes"/></td></tr>
				</xsl:if>
				<xsl:if test="notification_data/request/note != ''" >
					<tr><td><strong>@@request_note@@:</strong> <xsl:value-of select="notification_data/request/note"/></td></tr>
				</xsl:if>

			</table>
		</div>
	</div>
	
	<!-- this calls the footer template that includes the library name and any other information used on the bottom strip  -->
	<xsl:call-template name="lastFooter" /> <!-- footer.xsl -->

	</body>
</html>


</xsl:template>
</xsl:stylesheet>