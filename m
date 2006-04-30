Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751190AbWD3RWL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751190AbWD3RWL (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Apr 2006 13:22:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751194AbWD3RWL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Apr 2006 13:22:11 -0400
Received: from v813.rev.tld.pl ([195.149.226.213]:19624 "EHLO
	smtp.host4.kei.pl") by vger.kernel.org with ESMTP id S1751188AbWD3RWJ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Apr 2006 13:22:09 -0400
From: Marcin Juszkiewicz <openembedded@hrw.one.pl>
To: netdev@vger.kernel.org
Subject: [PATCH] Add some new card IDs to hostap_cs
Date: Sun, 30 Apr 2006 19:22:03 +0200
User-Agent: KMail/1.9.1
Cc: hostap@shmoo.com, Pavel Roskin <proski@gnu.org>,
       Jouni Malinen <jkmaline@cc.hut.fi>, linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200604301922.05472.openembedded@hrw.one.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I use two Zaurus palmtops - one run 2.4.18 kernel and second run 2.6.16.
Both are running under control of OpenZaurus distribution (I'm Release
Manager of it).

When I use pcmcia-cs then my Pretec WiFi card is handled by hostap
driver and everything is working fine. Recently I switched to
pcmciautils and after card insert orinoco modules are loaded. I prefer
to use hostap modules because they work the same under 2.4 and 2.6
kernels (with orinoco I have to use 0.13e ones because never ones does
not work under 2.4/arm).

Few weeks ago I sent smaller version to LKML, got response from Pavel 
Roskin (with his patch attached) and then I worked on converting our
(OpenEmbedded one) hostap_cs.conf to one patch which will add every
card which we had there during last years (definitions was collected
by users/developers of Familiar, OpenZaurus and OpenSimpad distributions).

This patch require 24_hostap_cs_id.diff [1] from Pavel Roskin.

Some hashes can be wrong but I want to get info what do you thing about
this patch.

PS I'm not subscribed to those mailinglists - please Cc: me on reply.

1. http://ewi546.ewi.utwente.nl/tmp/hrw/hostap/24-hostap_cs_id.diff

Signed-off-by: Marcin Juszkiewicz <openembedded@hrw.one.pl>

--- linux/drivers/net/wireless/hostap/hostap_cs.c.orig
+++ linux/drivers/net/wireless/hostap/hostap_cs.c
@@ -874,18 +874,25 @@
 static struct pcmcia_device_id hostap_cs_ids[] = {
 	PCMCIA_DEVICE_MANF_CARD(0x000b, 0x7100),
 	PCMCIA_DEVICE_MANF_CARD(0x000b, 0x7300),
+	PCMCIA_DEVICE_MANF_CARD(0x0089, 0x0001), /* "Intel PRO/Wireless 2011" */
 	PCMCIA_DEVICE_MANF_CARD(0x0089, 0x0002),
 	PCMCIA_DEVICE_MANF_CARD(0x0101, 0x0777),
 	PCMCIA_DEVICE_MANF_CARD(0x0126, 0x8000),
 	PCMCIA_DEVICE_MANF_CARD(0x0138, 0x0002),
+	PCMCIA_DEVICE_MANF_CARD(0x01eb, 0x080a), /* "Nortel Networks eMobility 802.11 Wireless Adapter" */
 	PCMCIA_DEVICE_MANF_CARD(0x01ff, 0x0008),
 	PCMCIA_DEVICE_MANF_CARD(0x0250, 0x0002),
+	PCMCIA_DEVICE_MANF_CARD(0x0261, 0x0002), /* "AirWay 802.11 Adapter (PCMCIA)" */
 	PCMCIA_DEVICE_MANF_CARD(0x026f, 0x030b),
 	PCMCIA_DEVICE_MANF_CARD(0x0274, 0x1612),
 	PCMCIA_DEVICE_MANF_CARD(0x0274, 0x1613),
+	PCMCIA_DEVICE_MANF_CARD(0x0274, 0x3301), /* "Linksys WCF11 11Mbps 802.11b WLAN Card" */
 	PCMCIA_DEVICE_MANF_CARD(0x028a, 0x0002),
+	PCMCIA_DEVICE_MANF_CARD(0x028a, 0x0673), /* "Linksys Wireless CompactFlash Card WCF12" */
 	PCMCIA_DEVICE_MANF_CARD(0x02aa, 0x0002),
+	PCMCIA_DEVICE_MANF_CARD(0x02ac, 0x0002), /* "SpeedStream SS1021 Wireless Adapter" */
 	PCMCIA_DEVICE_MANF_CARD(0x02d2, 0x0001),
+	PCMCIA_DEVICE_MANF_CARD(0x1668, 0x0101), /* "Actiontec 802CI2" */
 	PCMCIA_DEVICE_MANF_CARD(0x50c2, 0x0001),
 	PCMCIA_DEVICE_MANF_CARD(0x50c2, 0x7300),
 	PCMCIA_DEVICE_MANF_CARD(0x9005, 0x0021),
@@ -893,6 +900,7 @@
 	PCMCIA_DEVICE_MANF_CARD(0xc00f, 0x0000),
 	PCMCIA_DEVICE_MANF_CARD(0xc250, 0x0002),
 	PCMCIA_DEVICE_MANF_CARD(0xd601, 0x0002),
+	PCMCIA_DEVICE_MANF_CARD(0xd601, 0x0004), /* "Sitecom WL-007 WLAN CF Card" */
 	PCMCIA_DEVICE_MANF_CARD(0xd601, 0x0005),
 	PCMCIA_DEVICE_MANF_CARD(0xd601, 0x0010),
 	PCMCIA_DEVICE_MANF_CARD_PROD_ID1(0x0156, 0x0002, "INTERSIL",
@@ -969,6 +977,151 @@
 	PCMCIA_DEVICE_PROD_ID12(
 		"ZoomAir 11Mbps High", "Rate wireless Networking",
 		0x273fe3db, 0x32a1eaee),
+
+	/*card "Fulbond Airbond XI-300B"*/
+	PCMCIA_DEVICE_PROD_ID12( " ", "IEEE 802.11 Wireless LAN/PC Card",
+			0x5670ee60, 0x74e6b7c0),
+	/*   manfid 0xd601, 0x0002*/
+
+	/*card "3Com AirConnect"*/
+	PCMCIA_DEVICE_PROD_ID12("3Com", "3CRWE737A AirConnect Wireless LAN PC Card",
+			0x90952d33, 0xfa4f2ce9),
+
+	/*card "D-Link DWL-650"*/
+	PCMCIA_DEVICE_PROD_ID12( "D", "Link DWL-650 11Mbps WLAN Card",
+			0xdfad2f93, 0xaeaf66ea),
+
+	/*card "D-Link DRC-650"*/
+	PCMCIA_DEVICE_PROD_ID12( "D", "Link DRC-650 11Mbps WLAN Card",
+			0x124d5155, 0x62ff301f),
+
+	/*card "HyperLink Wireless PC Card 11Mbps"*/
+	PCMCIA_DEVICE_PROD_ID12( "HyperLink", "Wireless PC Card 11Mbps",
+			0xf2ab1a6b, 0x16a66dec),
+
+	/*card "MELCO WLI-PCM-L11"*/
+	PCMCIA_DEVICE_PROD_ID12( "MELCO", "WLI-PCM-L11",
+			0xc549cac9, 0xc2f6de9b),
+
+	/*card "MELCO WLI-PCM-L11G"*/
+	PCMCIA_DEVICE_PROD_ID12( "MELCO", "WLI-PCM-L11G",
+			0xfebebb55, 0x6db62357),
+
+	/*card "MELCO WLI-PCM-L11G"*/
+	PCMCIA_DEVICE_PROD_ID12( "BUFFALO", "WLI-PCM-L11G",
+			0x6cdab6ea, 0xc364d25d),
+
+	/*card "Buffalo WLI2-CF-S11"*/
+	PCMCIA_DEVICE_PROD_ID12( "BUFFALO", "WLI2-CF-S11",
+			0x798caeca, 0xe38746ab),
+
+	/*card "NCR WaveLAN/IEEE Adapter"*/
+	PCMCIA_DEVICE_PROD_ID12( "NCR", "WaveLAN/IEEE",
+			0x7b03a1a1, 0x1e9b31cf),
+
+	/*card "PLANEX GeoWave GW-CF110"*/
+	PCMCIA_DEVICE_PROD_ID12( "PLANEX", "GeoWave/GW-CF110",
+			0xfc599cd7, 0xbd486a2b),
+
+	/*card "PROXIM LAN PC CARD HARMONY 80211B"*/
+	PCMCIA_DEVICE_PROD_ID12( "PROXIM", "LAN PC CARD HARMONY 80211B",
+			0x73fc1d26, 0x87a9b674),
+
+	/*card "Proxim RangeLAN/DS"*/
+	PCMCIA_DEVICE_PROD_ID12( "PROXIM","RangeLAN-DS/LAN PC CARD",
+			0x2aacece5, 0xf3165e33),
+	/*  manfid 0x0126, 0x8000*/
+
+	/*card "SAMSUNG 11Mbps WLAN Card"*/
+	PCMCIA_DEVICE_PROD_ID12( "SAMSUNG", "11Mbps WLAN Card",
+			0xc621522d, 0x7db4e5f0),
+
+	/*card "SanDisk ConnectPlus w/ Memory"*/
+	PCMCIA_DEVICE_PROD_ID12( "SanDisk", "ConnectPlus",
+			0xeed76820, 0x57dcd73e),
+	/*   manfid 0xd601, 0x0101*/
+
+	/*card "U.S. Robotics IEEE 802.11b PC-CARD"*/
+	PCMCIA_DEVICE_PROD_ID123( "U.S. Robotics", "IEEE 802.11b PC-CARD", 
+			"Version 01.02",
+			0xc274c253, 0x81e83306, 0x753707e3),
+
+	/*card "Longshine LCR-8531 11Mbps WLAN PCMCIA CARD"*/
+	PCMCIA_DEVICE_PROD_ID123( "OEM", "PRISM2 IEEE 802.11 PC-Card", 
+			"Version 01.02",
+			0xc1242b52, 0xe65091b7, 0xb95beace),
+
+	/*card "Level-One WPC-0100"*/
+	PCMCIA_DEVICE_PROD_ID123( "Digital Data Communications", "WPC-0100",
+			"Version 00.00",
+			0x3c4f10c9, 0x963a48e5, 0x6b28acd),
+	/*   manfid 0x0156, 0x0002*/
+
+	/*card "Belkin 802.11b WLAN PCMCIA"*/
+	PCMCIA_DEVICE_PROD_ID123( "Belkin", 
+			"11Mbps Wireless Notebook Network Adapter", "Version 01.02",
+			0x86f06bf4, 0x7f1c625, 0xe3e8328),
+	/*   manfid 0x0156, 0x0002*/
+
+	/*card "Senao SL-2011CD/SL-2011CDPLUS"*/
+	PCMCIA_DEVICE_PROD_ID123( "INTERSIL", "HFA384x/IEEE", "Version 01.02",
+			0xaa245f03, 0xfc153421, 0xc1fb16f9),
+	/*   manfid 0x0156, 0x0002*/
+
+	/*card "Netgear MA401"*/
+	PCMCIA_DEVICE_PROD_ID123( "NETGEAR MA401 Wireless PC", "Card",
+			"Version 01.00",
+			0x2d28b025, 0x6df900aa, 0x1f2b0825),
+
+	/*card "Airvast WL100"*/
+	PCMCIA_DEVICE_PROD_ID123( "AIRVAST", "IEEE 802.11b Wireless PCMCIA Card",
+			"HFA3863",
+			0xdc579992, 0x9c73262e, 0xcc8c8afe),
+	/*   manfid 0x50c2, 0x0001*/
+
+	/*card "Allied Telesyn AT-WCL452"*/
+	PCMCIA_DEVICE_PROD_ID123( "Allied Telesyn",
+			"AT-WCL452 Wireless PCMCIA Radio", "Ver. 1.00",
+			0xc57766a0, 0xca5d9d30, 0xdce3940c),
+	/*   manfid 0xc00f, 0x000*/
+
+	/*card "ASUS WL-100 8011b WLAN PC Card"*/
+	PCMCIA_DEVICE_PROD_ID123("ASUS", "802_11b_PC_CARD_25", "Version 01.00",
+			0x45ae513c, 0x25e956b5, 0x4d4f9549),
+	/*   manfid 0x02aa, 0x0002*/
+
+	/*card "Wireless LAN Adapter Version 01.02"*/
+	PCMCIA_DEVICE_PROD_ID123( "Wireless", "LAN Adapter", "Version 01.02",
+			0x0cc3741d, 0x77846ac8, 0x280d341f),
+
+	/*card "D-Link DWL-650 Rev. P1"*/
+	PCMCIA_DEVICE_PROD_ID1234( "D-Link", "DWL-650 Wireless PC Card RevP",
+			"ISL37101P-10", "A3",
+			0x368662a9, 0x269d73b1, 0xb0136b54, 0xfac1bb25),
+
+	/*card "SonicWALL Long Range Wireless Card"*/
+	PCMCIA_DEVICE_PROD_ID1234( "SonicWALL", "Long Range Wireless Card",
+			"ISL37100P", "1.0",
+			0xfe59b73c, 0xdee96647, 0x2cc2096b, 0x3546bfc1),
+	/*   manfid 0x000b, 0x7100*/
+
+	/*card "Senao NL-2011CD PLUS Ext2 Mercury"*/
+	PCMCIA_DEVICE_PROD_ID1234( "WLAN", "11Mbps_PC-Card_3.0", "ISL37100P",
+			"Eval-RevA",
+			0x8d96f5be, 0xdb4801eb, 0x60ae1479, 0xb3cd1a59),
+	/*   manfid 0x000b, 0x7100*/
+
+	/*card "Microsoft Wireless Notebook Adapter MN-520 1.0.3"*/
+	PCMCIA_DEVICE_PROD_ID1234( "Microsoft", "Wireless Notebook Adapter MN-520",
+			"", "1.0.3",
+			0x51dc9ca9, 0x3684178d, 0x00000000 , 0x87ebda3b),
+	/*   manfid 0x02d2, 0x0001*/
+
+	/*card "NETGEAR MA401RA"*/
+	PCMCIA_DEVICE_PROD_ID1234( "NETGEAR MA401RA Wireless PC", "Card",
+			"ISL37300P", "Eval-RevA",
+			0x76d8b84, 0xb98efcc9, 0x6b5190fc, 0xe48c0c83),
+	/*   manfid 0x000b, 0x7300*/
 	PCMCIA_DEVICE_NULL
 };
 MODULE_DEVICE_TABLE(pcmcia, hostap_cs_ids);


-- 
JID: hrw-jabber.org
Palmtop: Sharp Zaurus C760
OpenEmbedded/OpenZaurus developer

           Q:      What's a light-year?
           A:      One-third less calories than a regular year.
