Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261525AbVCOENc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261525AbVCOENc (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Mar 2005 23:13:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262231AbVCOENc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Mar 2005 23:13:32 -0500
Received: from gate.crashing.org ([63.228.1.57]:3998 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S261525AbVCOEMa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Mar 2005 23:12:30 -0500
Subject: [PATCH] ppc32: Update PowerMac models table
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Date: Tue, 15 Mar 2005 15:10:44 +1100
Message-Id: <1110859844.29137.18.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi !

This patch updates the table of PowerMac models, adding the Mac mini, a
few missing ones in older slots too, and sorts it in a more logical way.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

Index: linux-work/arch/ppc/platforms/pmac_feature.c
===================================================================
--- linux-work.orig/arch/ppc/platforms/pmac_feature.c	2005-03-15 11:56:42.000000000 +1100
+++ linux-work/arch/ppc/platforms/pmac_feature.c	2005-03-15 13:55:37.000000000 +1100
@@ -2022,10 +2022,11 @@
 #endif /* CONFIG_POWER4 */
 
 static struct pmac_mb_def pmac_mb_defs[] __pmacdata = {
-	/* Warning: ordering is important as some models may claim
-	 * beeing compatible with several types
-	 */
 #ifndef CONFIG_POWER4
+	/*
+	 * Desktops
+	 */
+
 	{	"AAPL,8500",			"PowerMac 8500/8600",
 		PMAC_TYPE_PSURGE,		NULL,
 		0
@@ -2058,14 +2059,6 @@
 		PMAC_TYPE_GAZELLE,		NULL,
 		0
 	},
-	{	"AAPL,3400/2400",		"PowerBook 3400",
-		PMAC_TYPE_HOOPER,		ohare_features,
-		PMAC_MB_CAN_SLEEP | PMAC_MB_MOBILE
-	},
-	{	"AAPL,3500",			"PowerBook 3500",
-		PMAC_TYPE_KANGA,		ohare_features,
-		PMAC_MB_CAN_SLEEP | PMAC_MB_MOBILE
-	},
 	{	"AAPL,Gossamer",		"PowerMac G3 (Gossamer)",
 		PMAC_TYPE_GOSSAMER,		heathrow_desktop_features,
 		0
@@ -2074,42 +2067,6 @@
 		PMAC_TYPE_SILK,			heathrow_desktop_features,
 		0
 	},
-	{	"AAPL,PowerBook1998",		"PowerBook Wallstreet",
-		PMAC_TYPE_WALLSTREET,		heathrow_laptop_features,
-		PMAC_MB_CAN_SLEEP | PMAC_MB_MOBILE
-	},
-	{	"PowerBook1,1",			"PowerBook 101 (Lombard)",
-		PMAC_TYPE_101_PBOOK,		paddington_features,
-		PMAC_MB_MAY_SLEEP | PMAC_MB_MOBILE
-	},
-	{	"iMac,1",			"iMac (first generation)",
-		PMAC_TYPE_ORIG_IMAC,		paddington_features,
-		0
-	},
-	{	"PowerMac4,1",			"iMac \"Flower Power\"",
-		PMAC_TYPE_PANGEA_IMAC,		pangea_features,
-		PMAC_MB_MAY_SLEEP
-	},
-	{	"PowerBook4,3",			"iBook 2 rev. 2",
-		PMAC_TYPE_IBOOK2,		pangea_features,
-		PMAC_MB_MAY_SLEEP | PMAC_MB_HAS_FW_POWER | PMAC_MB_MOBILE
-	},
-	{	"PowerBook4,2",			"iBook 2",
-		PMAC_TYPE_IBOOK2,		pangea_features,
-		PMAC_MB_MAY_SLEEP | PMAC_MB_HAS_FW_POWER | PMAC_MB_MOBILE
-	},
-	{	"PowerBook4,1",			"iBook 2",
-		PMAC_TYPE_IBOOK2,		pangea_features,
-		PMAC_MB_MAY_SLEEP | PMAC_MB_HAS_FW_POWER | PMAC_MB_MOBILE
-	},
-	{	"PowerMac4,4",			"eMac",
-		PMAC_TYPE_EMAC,			core99_features,
-		PMAC_MB_MAY_SLEEP
-	},
-	{	"PowerMac4,2",			"Flat panel iMac",
-		PMAC_TYPE_FLAT_PANEL_IMAC,	pangea_features,
-		PMAC_MB_CAN_SLEEP
-	},
 	{	"PowerMac1,1",			"Blue&White G3",
 		PMAC_TYPE_YOSEMITE,		paddington_features,
 		0
@@ -2118,9 +2075,13 @@
 		PMAC_TYPE_YIKES,		paddington_features,
 		0
 	},
-	{	"PowerBook2,1",			"iBook (first generation)",
-		PMAC_TYPE_ORIG_IBOOK,		core99_features,
-		PMAC_MB_CAN_SLEEP | PMAC_MB_OLD_CORE99 | PMAC_MB_MOBILE
+	{	"PowerMac2,1",			"iMac FireWire",
+		PMAC_TYPE_FW_IMAC,		core99_features,
+		PMAC_MB_MAY_SLEEP | PMAC_MB_OLD_CORE99
+	},
+	{	"PowerMac2,2",			"iMac FireWire",
+		PMAC_TYPE_FW_IMAC,		core99_features,
+		PMAC_MB_MAY_SLEEP | PMAC_MB_OLD_CORE99
 	},
 	{	"PowerMac3,1",			"PowerMac G4 AGP Graphics",
 		PMAC_TYPE_SAWTOOTH,		core99_features,
@@ -2134,30 +2095,96 @@
 		PMAC_TYPE_SAWTOOTH,		core99_features,
 		PMAC_MB_MAY_SLEEP | PMAC_MB_OLD_CORE99
 	},
-	{	"PowerMac2,1",			"iMac FireWire",
-		PMAC_TYPE_FW_IMAC,		core99_features,
-		PMAC_MB_MAY_SLEEP | PMAC_MB_OLD_CORE99
+	{	"PowerMac3,4",			"PowerMac G4 Silver",
+		PMAC_TYPE_QUICKSILVER,		core99_features,
+		PMAC_MB_MAY_SLEEP
 	},
-	{	"PowerMac2,2",			"iMac FireWire",
-		PMAC_TYPE_FW_IMAC,		core99_features,
-		PMAC_MB_MAY_SLEEP | PMAC_MB_OLD_CORE99
+	{	"PowerMac3,5",			"PowerMac G4 Silver",
+		PMAC_TYPE_QUICKSILVER,		core99_features,
+		PMAC_MB_MAY_SLEEP
 	},
-	{	"PowerBook2,2",			"iBook FireWire",
-		PMAC_TYPE_FW_IBOOK,		core99_features,
-		PMAC_MB_MAY_SLEEP | PMAC_MB_HAS_FW_POWER |
-		PMAC_MB_OLD_CORE99 | PMAC_MB_MOBILE
+	{	"PowerMac3,6",			"PowerMac G4 Windtunnel",
+		PMAC_TYPE_WINDTUNNEL,		core99_features,
+		PMAC_MB_MAY_SLEEP,
+	},
+	{	"PowerMac4,1",			"iMac \"Flower Power\"",
+		PMAC_TYPE_PANGEA_IMAC,		pangea_features,
+		PMAC_MB_MAY_SLEEP
+	},
+	{	"PowerMac4,2",			"Flat panel iMac",
+		PMAC_TYPE_FLAT_PANEL_IMAC,	pangea_features,
+		PMAC_MB_CAN_SLEEP
+	},
+	{	"PowerMac4,4",			"eMac",
+		PMAC_TYPE_EMAC,			core99_features,
+		PMAC_MB_MAY_SLEEP
 	},
 	{	"PowerMac5,1",			"PowerMac G4 Cube",
 		PMAC_TYPE_CUBE,			core99_features,
 		PMAC_MB_MAY_SLEEP | PMAC_MB_OLD_CORE99
 	},
-	{	"PowerMac3,4",			"PowerMac G4 Silver",
-		PMAC_TYPE_QUICKSILVER,		core99_features,
-		PMAC_MB_MAY_SLEEP
+	{	"PowerMac6,1",			"Flat panel iMac",
+		PMAC_TYPE_UNKNOWN_INTREPID,	intrepid_features,
+		PMAC_MB_MAY_SLEEP,
 	},
-	{	"PowerMac3,5",			"PowerMac G4 Silver",
-		PMAC_TYPE_QUICKSILVER,		core99_features,
-		PMAC_MB_MAY_SLEEP
+	{	"PowerMac6,3",			"Flat panel iMac",
+		PMAC_TYPE_UNKNOWN_INTREPID,	intrepid_features,
+		PMAC_MB_MAY_SLEEP,
+	},
+	{	"PowerMac6,4",			"eMac",
+		PMAC_TYPE_UNKNOWN_INTREPID,	intrepid_features,
+		PMAC_MB_MAY_SLEEP,
+	},
+	{	"PowerMac10,1",			"Mac mini",
+		PMAC_TYPE_UNKNOWN_INTREPID,	intrepid_features,
+		PMAC_MB_MAY_SLEEP | PMAC_MB_HAS_FW_POWER,
+	},
+	{	"iMac,1",			"iMac (first generation)",
+		PMAC_TYPE_ORIG_IMAC,		paddington_features,
+		0
+	},
+
+	/*
+	 * Xserve's
+	 */
+
+	{	"RackMac1,1",			"XServe",
+		PMAC_TYPE_RACKMAC,		rackmac_features,
+		0,
+	},
+	{	"RackMac1,2",			"XServe rev. 2",
+		PMAC_TYPE_RACKMAC,		rackmac_features,
+		0,
+	},
+
+	/*
+	 * Laptops
+	 */
+
+	{	"AAPL,3400/2400",		"PowerBook 3400",
+		PMAC_TYPE_HOOPER,		ohare_features,
+		PMAC_MB_CAN_SLEEP | PMAC_MB_MOBILE
+	},
+	{	"AAPL,3500",			"PowerBook 3500",
+		PMAC_TYPE_KANGA,		ohare_features,
+		PMAC_MB_CAN_SLEEP | PMAC_MB_MOBILE
+	},
+	{	"AAPL,PowerBook1998",		"PowerBook Wallstreet",
+		PMAC_TYPE_WALLSTREET,		heathrow_laptop_features,
+		PMAC_MB_CAN_SLEEP | PMAC_MB_MOBILE
+	},
+	{	"PowerBook1,1",			"PowerBook 101 (Lombard)",
+		PMAC_TYPE_101_PBOOK,		paddington_features,
+		PMAC_MB_MAY_SLEEP | PMAC_MB_MOBILE
+	},
+	{	"PowerBook2,1",			"iBook (first generation)",
+		PMAC_TYPE_ORIG_IBOOK,		core99_features,
+		PMAC_MB_CAN_SLEEP | PMAC_MB_OLD_CORE99 | PMAC_MB_MOBILE
+	},
+	{	"PowerBook2,2",			"iBook FireWire",
+		PMAC_TYPE_FW_IBOOK,		core99_features,
+		PMAC_MB_MAY_SLEEP | PMAC_MB_HAS_FW_POWER |
+		PMAC_MB_OLD_CORE99 | PMAC_MB_MOBILE
 	},
 	{	"PowerBook3,1",			"PowerBook Pismo",
 		PMAC_TYPE_PISMO,		core99_features,
@@ -2180,17 +2207,17 @@
 		PMAC_TYPE_TITANIUM4,		core99_features,
 		PMAC_MB_MAY_SLEEP | PMAC_MB_HAS_FW_POWER | PMAC_MB_MOBILE
 	},
-	{	"RackMac1,1",			"XServe",
-		PMAC_TYPE_RACKMAC,		rackmac_features,
-		0,
+	{	"PowerBook4,1",			"iBook 2",
+		PMAC_TYPE_IBOOK2,		pangea_features,
+		PMAC_MB_MAY_SLEEP | PMAC_MB_HAS_FW_POWER | PMAC_MB_MOBILE
 	},
-	{	"RackMac1,2",			"XServe rev. 2",
-		PMAC_TYPE_RACKMAC,		rackmac_features,
-		0,
+	{	"PowerBook4,2",			"iBook 2",
+		PMAC_TYPE_IBOOK2,		pangea_features,
+		PMAC_MB_MAY_SLEEP | PMAC_MB_HAS_FW_POWER | PMAC_MB_MOBILE
 	},
-	{	"PowerMac3,6",			"PowerMac G4 Windtunnel",
-		PMAC_TYPE_WINDTUNNEL,		core99_features,
-		PMAC_MB_MAY_SLEEP,
+	{	"PowerBook4,3",			"iBook 2 rev. 2",
+		PMAC_TYPE_IBOOK2,		pangea_features,
+		PMAC_MB_MAY_SLEEP | PMAC_MB_HAS_FW_POWER | PMAC_MB_MOBILE
 	},
 	{	"PowerBook5,1",			"PowerBook G4 17\"",
 		PMAC_TYPE_UNKNOWN_INTREPID,	intrepid_features,
@@ -2212,6 +2239,14 @@
 		PMAC_TYPE_UNKNOWN_INTREPID,	intrepid_features,
 		PMAC_MB_MAY_SLEEP | PMAC_MB_HAS_FW_POWER | PMAC_MB_MOBILE,
 	},
+	{	"PowerBook5,6",			"PowerBook G4 15\"",
+		PMAC_TYPE_UNKNOWN_INTREPID,	intrepid_features,
+		PMAC_MB_MAY_SLEEP | PMAC_MB_HAS_FW_POWER | PMAC_MB_MOBILE,
+	},
+	{	"PowerBook5,7",			"PowerBook G4 17\"",
+		PMAC_TYPE_UNKNOWN_INTREPID,	intrepid_features,
+		PMAC_MB_MAY_SLEEP | PMAC_MB_HAS_FW_POWER | PMAC_MB_MOBILE,
+	},
 	{	"PowerBook6,1",			"PowerBook G4 12\"",
 		PMAC_TYPE_UNKNOWN_INTREPID,	intrepid_features,
 		PMAC_MB_MAY_SLEEP | PMAC_MB_HAS_FW_POWER | PMAC_MB_MOBILE,
@@ -2232,6 +2267,10 @@
 		PMAC_TYPE_UNKNOWN_INTREPID,	intrepid_features,
 		PMAC_MB_MAY_SLEEP | PMAC_MB_HAS_FW_POWER | PMAC_MB_MOBILE,
 	},
+	{	"PowerBook6,8",			"PowerBook G4 12\"",
+		PMAC_TYPE_UNKNOWN_INTREPID,	intrepid_features,
+		PMAC_MB_MAY_SLEEP | PMAC_MB_HAS_FW_POWER | PMAC_MB_MOBILE,
+	},
 #else /* CONFIG_POWER4 */
 	{	"PowerMac7,2",			"PowerMac G5",
 		PMAC_TYPE_POWERMAC_G5,		g5_features,


