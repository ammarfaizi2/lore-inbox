Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318930AbSIDP3K>; Wed, 4 Sep 2002 11:29:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318937AbSIDP3K>; Wed, 4 Sep 2002 11:29:10 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:13317 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S318930AbSIDP3D>;
	Wed, 4 Sep 2002 11:29:03 -0400
Date: Wed, 4 Sep 2002 16:33:37 +0100
From: Matthew Wilcox <willy@debian.org>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Dave Jones <davej@suse.de>, linux-kernel@vger.kernel.org
Subject: [PATCH] move AGP PCI defines to pci_ids.h
Message-ID: <20020904163337.M28676@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Unify the PCI device ID constants used by AGP with the normal Linux ones.

diff -urpNX dontdiff linux-2.5.33/drivers/char/agp/agp.c linux-2.5.33-willy/drivers/char/agp/agp.c
--- linux-2.5.33/drivers/char/agp/agp.c	2002-07-27 12:09:13.000000000 -0600
+++ linux-2.5.33-willy/drivers/char/agp/agp.c	2002-07-30 01:43:31.000000000 -0600
@@ -751,7 +751,7 @@ static struct {
 
 #ifdef CONFIG_AGP_ALI
 	{
-		.device_id	= PCI_DEVICE_ID_AL_M1541_0,
+		.device_id	= PCI_DEVICE_ID_AL_M1541,
 		.vendor_id	= PCI_VENDOR_ID_AL,
 		.chipset	= ALI_M1541,
 		.vendor_name	= "Ali",
@@ -759,7 +759,7 @@ static struct {
 		.chipset_setup	= ali_generic_setup,
 	},
 	{
-		.device_id	= PCI_DEVICE_ID_AL_M1621_0,
+		.device_id	= PCI_DEVICE_ID_AL_M1621,
 		.vendor_id	= PCI_VENDOR_ID_AL,
 		.chipset	= ALI_M1621,
 		.vendor_name	= "Ali",
@@ -767,7 +767,7 @@ static struct {
 		.chipset_setup	= ali_generic_setup,
 	},
 	{
-		.device_id	= PCI_DEVICE_ID_AL_M1631_0,
+		.device_id	= PCI_DEVICE_ID_AL_M1631,
 		.vendor_id	= PCI_VENDOR_ID_AL,
 		.chipset	= ALI_M1631,
 		.vendor_name	= "Ali",
@@ -775,7 +775,7 @@ static struct {
 		.chipset_setup	= ali_generic_setup,
 	},
 	{
-		.device_id	= PCI_DEVICE_ID_AL_M1632_0,
+		.device_id	= PCI_DEVICE_ID_AL_M1632,
 		.vendor_id	= PCI_VENDOR_ID_AL,
 		.chipset	= ALI_M1632,
 		.vendor_name	= "Ali",
@@ -783,7 +783,7 @@ static struct {
 		.chipset_setup	= ali_generic_setup,
 	},
 	{
-		.device_id	= PCI_DEVICE_ID_AL_M1641_0,
+		.device_id	= PCI_DEVICE_ID_AL_M1641,
 		.vendor_id	= PCI_VENDOR_ID_AL,
 		.chipset	= ALI_M1641,
 		.vendor_name	= "Ali",
@@ -791,7 +791,7 @@ static struct {
 		.chipset_setup	= ali_generic_setup,
 	},
 	{
-		.device_id	= PCI_DEVICE_ID_AL_M1644_0,
+		.device_id	= PCI_DEVICE_ID_AL_M1644,
 		.vendor_id	= PCI_VENDOR_ID_AL,
 		.chipset	= ALI_M1644,
 		.vendor_name	= "Ali",
@@ -799,7 +799,7 @@ static struct {
 		.chipset_setup	= ali_generic_setup,
 	},
 	{
-		.device_id	= PCI_DEVICE_ID_AL_M1647_0,
+		.device_id	= PCI_DEVICE_ID_AL_M1647,
 		.vendor_id	= PCI_VENDOR_ID_AL,
 		.chipset	= ALI_M1647,
 		.vendor_name	= "Ali",
@@ -807,7 +807,7 @@ static struct {
 		.chipset_setup	= ali_generic_setup,
 	},
 	{
-		.device_id	= PCI_DEVICE_ID_AL_M1651_0,
+		.device_id	= PCI_DEVICE_ID_AL_M1651,
 		.vendor_id	= PCI_VENDOR_ID_AL,
 		.chipset	= ALI_M1651,
 		.vendor_name	= "Ali",
@@ -826,7 +826,7 @@ static struct {
 
 #ifdef CONFIG_AGP_AMD
 	{
-		.device_id	= PCI_DEVICE_ID_AMD_IRONGATE_0,
+		.device_id	= PCI_DEVICE_ID_AMD_FE_GATE_7006,
 		.vendor_id	= PCI_VENDOR_ID_AMD,
 		.chipset	= AMD_IRONGATE,
 		.vendor_name	= "AMD",
@@ -834,7 +834,7 @@ static struct {
 		.chipset_setup	= amd_irongate_setup,
 	},
 	{
-		.device_id	= PCI_DEVICE_ID_AMD_761_0,
+		.device_id	= PCI_DEVICE_ID_AMD_FE_GATE_700E,
 		.vendor_id	= PCI_VENDOR_ID_AMD,
 		.chipset	= AMD_761,
 		.vendor_name	= "AMD",
@@ -842,7 +842,7 @@ static struct {
 		.chipset_setup	= amd_irongate_setup,
 	},
 	{
-		.device_id	= PCI_DEVICE_ID_AMD_762_0,
+		.device_id	= PCI_DEVICE_ID_AMD_FE_GATE_700C,
 		.vendor_id	= PCI_VENDOR_ID_AMD,
 		.chipset	= AMD_762,
 		.vendor_name	= "AMD",
@@ -885,7 +885,7 @@ static struct {
 		.chipset_setup	= intel_generic_setup
 	},
 	{
-		.device_id	= PCI_DEVICE_ID_INTEL_815_0,
+		.device_id	= PCI_DEVICE_ID_INTEL_82815_MC,
 		.vendor_id	= PCI_VENDOR_ID_INTEL,
 		.chipset	= INTEL_I815,
 		.vendor_name	= "Intel",
@@ -893,7 +893,7 @@ static struct {
 		.chipset_setup	= intel_815_setup
 	},
 	{
-		.device_id	= PCI_DEVICE_ID_INTEL_820_0,
+		.device_id	= PCI_DEVICE_ID_INTEL_82820_HB,
 		.vendor_id	= PCI_VENDOR_ID_INTEL,
 		.chipset	= INTEL_I820,
 		.vendor_name	= "Intel",
@@ -901,7 +901,7 @@ static struct {
 		.chipset_setup	= intel_820_setup
 	},
 	{
-		.device_id	= PCI_DEVICE_ID_INTEL_820_UP_0,
+		.device_id	= PCI_DEVICE_ID_INTEL_82820_UP_HB,
 		.vendor_id	= PCI_VENDOR_ID_INTEL,
 		.chipset	= INTEL_I820,
 		.vendor_name	= "Intel",
@@ -909,7 +909,7 @@ static struct {
 		.chipset_setup	= intel_820_setup
 	},
 	{
-		.device_id	= PCI_DEVICE_ID_INTEL_830_M_0,
+		.device_id	= PCI_DEVICE_ID_INTEL_82830_HB,
 		.vendor_id	= PCI_VENDOR_ID_INTEL,
 		.chipset	= INTEL_I830_M,
 		.vendor_name	= "Intel",
@@ -917,7 +917,7 @@ static struct {
 		.chipset_setup	= intel_830mp_setup
 	},
 	{
-		.device_id	= PCI_DEVICE_ID_INTEL_845_G_0,
+		.device_id	= PCI_DEVICE_ID_INTEL_82845G_HB,
 		.vendor_id	= PCI_VENDOR_ID_INTEL,
 		.chipset	= INTEL_I845_G,
 		.vendor_name	= "Intel",
@@ -925,7 +925,7 @@ static struct {
 		.chipset_setup	= intel_830mp_setup
 	},
 	{
-		.device_id	= PCI_DEVICE_ID_INTEL_840_0,
+		.device_id	= PCI_DEVICE_ID_INTEL_82840_HB,
 		.vendor_id	= PCI_VENDOR_ID_INTEL,
 		.chipset	= INTEL_I840,
 		.vendor_name	= "Intel",
@@ -933,7 +933,7 @@ static struct {
 		.chipset_setup	= intel_840_setup
 	},
 	{
-		.device_id	= PCI_DEVICE_ID_INTEL_845_0,
+		.device_id	= PCI_DEVICE_ID_INTEL_82845_HB,
 		.vendor_id	= PCI_VENDOR_ID_INTEL,
 		.chipset	= INTEL_I845,
 		.vendor_name	= "Intel",
@@ -941,7 +941,7 @@ static struct {
 		.chipset_setup	= intel_845_setup
 	},
 	{
-		.device_id	= PCI_DEVICE_ID_INTEL_850_0,
+		.device_id	= PCI_DEVICE_ID_INTEL_82850_HB,
 		.vendor_id	= PCI_VENDOR_ID_INTEL,
 		.chipset	= INTEL_I850,
 		.vendor_name	= "Intel",
@@ -949,7 +949,7 @@ static struct {
 		.chipset_setup	= intel_850_setup
 	},
 	{
-		.device_id	= PCI_DEVICE_ID_INTEL_860_0,
+		.device_id	= PCI_DEVICE_ID_INTEL_82860_HB,
 		.vendor_id	= PCI_VENDOR_ID_INTEL,
 		.chipset	= INTEL_I860,
 		.vendor_name	= "Intel",
@@ -1092,7 +1092,7 @@ static struct {
 		.chipset_setup	= via_generic_setup
 	},
 	{
-		.device_id	= PCI_DEVICE_ID_VIA_82C691_0,
+		.device_id	= PCI_DEVICE_ID_VIA_82C691,
 		.vendor_id	= PCI_VENDOR_ID_VIA,
 		.chipset	= VIA_APOLLO_PRO,
 		.vendor_name	= "Via",
@@ -1166,7 +1166,7 @@ static int __init agp_lookup_host_bridge
 	       (agp_bridge_info[i].vendor_id == pdev->vendor)) {
 		if (pdev->device == agp_bridge_info[i].device_id) {
 #ifdef CONFIG_AGP_ALI
-			if (pdev->device == PCI_DEVICE_ID_AL_M1621_0) {
+			if (pdev->device == PCI_DEVICE_ID_AL_M1621) {
 				u8 hidden_1621_id;
 
 				pci_read_config_byte(pdev, 0xFB, &hidden_1621_id);
@@ -1237,9 +1237,9 @@ static int __init agp_find_supported_dev
 		struct pci_dev *i810_dev;
 
 		switch (dev->device) {
-		case PCI_DEVICE_ID_INTEL_810_0:
+		case PCI_DEVICE_ID_INTEL_82810_MC1:
 			i810_dev = pci_find_device(PCI_VENDOR_ID_INTEL,
-					       PCI_DEVICE_ID_INTEL_810_1,
+					       PCI_DEVICE_ID_INTEL_82810_IG1,
 						   NULL);
 			if (i810_dev == NULL) {
 				printk(KERN_ERR PFX "Detected an Intel i810,"
@@ -1252,9 +1252,9 @@ static int __init agp_find_supported_dev
 			agp_bridge.type = INTEL_I810;
 			return intel_i810_setup (i810_dev);
 
-		case PCI_DEVICE_ID_INTEL_810_DC100_0:
+		case PCI_DEVICE_ID_INTEL_82810_MC3:
 			i810_dev = pci_find_device(PCI_VENDOR_ID_INTEL,
-					 PCI_DEVICE_ID_INTEL_810_DC100_1,
+					 PCI_DEVICE_ID_INTEL_82810_IG3,
 						   NULL);
 			if (i810_dev == NULL) {
 				printk(KERN_ERR PFX "Detected an Intel i810 "
@@ -1267,9 +1267,9 @@ static int __init agp_find_supported_dev
 			agp_bridge.type = INTEL_I810;
 			return intel_i810_setup(i810_dev);
 
-		case PCI_DEVICE_ID_INTEL_810_E_0:
+		case PCI_DEVICE_ID_INTEL_82810E_MC:
 			i810_dev = pci_find_device(PCI_VENDOR_ID_INTEL,
-					     PCI_DEVICE_ID_INTEL_810_E_1,
+					     PCI_DEVICE_ID_INTEL_82810E_IG,
 						   NULL);
 			if (i810_dev == NULL) {
 				printk(KERN_ERR PFX "Detected an Intel i810 E"
@@ -1282,14 +1282,14 @@ static int __init agp_find_supported_dev
 			agp_bridge.type = INTEL_I810;
 			return intel_i810_setup(i810_dev);
 
-		 case PCI_DEVICE_ID_INTEL_815_0:
+		 case PCI_DEVICE_ID_INTEL_82815_MC:
 		   /* The i815 can operate either as an i810 style
 		    * integrated device, or as an AGP4X motherboard.
 		    *
 		    * This only addresses the first mode:
 		    */
 			i810_dev = pci_find_device(PCI_VENDOR_ID_INTEL,
-						   PCI_DEVICE_ID_INTEL_815_1,
+						PCI_DEVICE_ID_INTEL_82815_CGC,
 						   NULL);
 			if (i810_dev == NULL) {
 				printk(KERN_ERR PFX "agpgart: Detected an "
@@ -1303,12 +1303,12 @@ static int __init agp_find_supported_dev
 			agp_bridge.type = INTEL_I810;
 			return intel_i810_setup(i810_dev);
 
-		case PCI_DEVICE_ID_INTEL_845_G_0:
+		case PCI_DEVICE_ID_INTEL_82845G_HB:
 			i810_dev = pci_find_device(PCI_VENDOR_ID_INTEL,
-					PCI_DEVICE_ID_INTEL_845_G_1, NULL);
+					PCI_DEVICE_ID_INTEL_82845G_IG, NULL);
 			if(i810_dev && PCI_FUNC(i810_dev->devfn) != 0) {
 				i810_dev = pci_find_device(PCI_VENDOR_ID_INTEL,
-					PCI_DEVICE_ID_INTEL_845_G_1, i810_dev);
+					PCI_DEVICE_ID_INTEL_82845G_IG, i810_dev);
 			}
 
 			if (i810_dev == NULL) {
@@ -1325,13 +1325,13 @@ static int __init agp_find_supported_dev
 			agp_bridge.type = INTEL_I810;
 			return intel_i830_setup(i810_dev);
 		   
-		case PCI_DEVICE_ID_INTEL_830_M_0:
+		case PCI_DEVICE_ID_INTEL_82830_HB:
 			i810_dev = pci_find_device(PCI_VENDOR_ID_INTEL,
-						   PCI_DEVICE_ID_INTEL_830_M_1,
+						   PCI_DEVICE_ID_INTEL_82830_CGC,
 						   NULL);
 			if(i810_dev && PCI_FUNC(i810_dev->devfn) != 0) {
 				i810_dev = pci_find_device(PCI_VENDOR_ID_INTEL,
-							   PCI_DEVICE_ID_INTEL_830_M_1,
+							   PCI_DEVICE_ID_INTEL_82830_CGC,
 							   i810_dev);
 			}
 
diff -urpNX dontdiff linux-2.5.33/drivers/char/agp/agp.h linux-2.5.33-willy/drivers/char/agp/agp.h
--- linux-2.5.33/drivers/char/agp/agp.h	2002-07-27 12:09:06.000000000 -0600
+++ linux-2.5.33-willy/drivers/char/agp/agp.h	2002-07-30 01:49:33.000000000 -0600
@@ -215,118 +215,6 @@ struct agp_bridge_data {
 
 #define PGE_EMPTY(p)	(!(p) || (p) == (unsigned long) agp_bridge.scratch_page)
 
-#ifndef PCI_DEVICE_ID_VIA_82C691_0
-#define PCI_DEVICE_ID_VIA_82C691_0	0x0691
-#endif
-#ifndef PCI_DEVICE_ID_VIA_8371_0
-#define PCI_DEVICE_ID_VIA_8371_0	0x0391
-#endif
-#ifndef PCI_DEVICE_ID_VIA_8363_0
-#define PCI_DEVICE_ID_VIA_8363_0	0x0305
-#endif
-#ifndef PCI_DEVICE_ID_VIA_82C694X_0
-#define PCI_DEVICE_ID_VIA_82C694X_0	0x0605
-#endif
-#ifndef PCI_DEVICE_ID_INTEL_810_0
-#define PCI_DEVICE_ID_INTEL_810_0	0x7120
-#endif
-#ifndef PCI_DEVICE_ID_INTEL_845_G_0
-#define PCI_DEVICE_ID_INTEL_845_G_0	0x2560
-#endif
-#ifndef PCI_DEVICE_ID_INTEL_845_G_1
-#define PCI_DEVICE_ID_INTEL_845_G_1	0x2562
-#endif
-#ifndef PCI_DEVICE_ID_INTEL_830_M_0
-#define PCI_DEVICE_ID_INTEL_830_M_0	0x3575
-#endif
-#ifndef PCI_DEVICE_ID_INTEL_830_M_1
-#define PCI_DEVICE_ID_INTEL_830_M_1	0x3577
-#endif
-#ifndef PCI_DEVICE_ID_INTEL_820_0
-#define PCI_DEVICE_ID_INTEL_820_0	0x2500
-#endif
-#ifndef PCI_DEVICE_ID_INTEL_820_UP_0
-#define PCI_DEVICE_ID_INTEL_820_UP_0	0x2501
-#endif
-#ifndef PCI_DEVICE_ID_INTEL_840_0
-#define PCI_DEVICE_ID_INTEL_840_0	0x1a21
-#endif
-#ifndef PCI_DEVICE_ID_INTEL_845_0
-#define PCI_DEVICE_ID_INTEL_845_0	0x1a30
-#endif
-#ifndef PCI_DEVICE_ID_INTEL_850_0
-#define PCI_DEVICE_ID_INTEL_850_0	0x2530
-#endif
-#ifndef PCI_DEVICE_ID_INTEL_860_0
-#define PCI_DEVICE_ID_INTEL_860_0	0x2531
-#endif
-#ifndef PCI_DEVICE_ID_INTEL_810_DC100_0
-#define PCI_DEVICE_ID_INTEL_810_DC100_0	0x7122
-#endif
-#ifndef PCI_DEVICE_ID_INTEL_810_E_0
-#define PCI_DEVICE_ID_INTEL_810_E_0	0x7124
-#endif
-#ifndef PCI_DEVICE_ID_INTEL_82443GX_0
-#define PCI_DEVICE_ID_INTEL_82443GX_0	0x71a0
-#endif
-#ifndef PCI_DEVICE_ID_INTEL_810_1
-#define PCI_DEVICE_ID_INTEL_810_1	0x7121
-#endif
-#ifndef PCI_DEVICE_ID_INTEL_810_DC100_1
-#define PCI_DEVICE_ID_INTEL_810_DC100_1	0x7123
-#endif
-#ifndef PCI_DEVICE_ID_INTEL_810_E_1
-#define PCI_DEVICE_ID_INTEL_810_E_1	0x7125
-#endif
-#ifndef PCI_DEVICE_ID_INTEL_815_0
-#define PCI_DEVICE_ID_INTEL_815_0	0x1130
-#endif
-#ifndef PCI_DEVICE_ID_INTEL_815_1
-#define PCI_DEVICE_ID_INTEL_815_1	0x1132
-#endif
-#ifndef PCI_DEVICE_ID_INTEL_82443GX_1
-#define PCI_DEVICE_ID_INTEL_82443GX_1	0x71a1
-#endif
-#ifndef PCI_DEVICE_ID_INTEL_460GX
-#define PCI_DEVICE_ID_INTEL_460GX	0x84ea
-#endif
-#ifndef PCI_DEVICE_ID_AMD_IRONGATE_0
-#define PCI_DEVICE_ID_AMD_IRONGATE_0	0x7006
-#endif
-#ifndef PCI_DEVICE_ID_AMD_761_0
-#define PCI_DEVICE_ID_AMD_761_0		0x700e
-#endif
-#ifndef PCI_DEVICE_ID_AMD_762_0
-#define PCI_DEVICE_ID_AMD_762_0		0x700C
-#endif
-#ifndef PCI_VENDOR_ID_AL
-#define PCI_VENDOR_ID_AL		0x10b9
-#endif
-#ifndef PCI_DEVICE_ID_AL_M1541_0
-#define PCI_DEVICE_ID_AL_M1541_0	0x1541
-#endif
-#ifndef PCI_DEVICE_ID_AL_M1621_0
-#define PCI_DEVICE_ID_AL_M1621_0	0x1621
-#endif
-#ifndef PCI_DEVICE_ID_AL_M1631_0
-#define PCI_DEVICE_ID_AL_M1631_0	0x1631
-#endif
-#ifndef PCI_DEVICE_ID_AL_M1632_0
-#define PCI_DEVICE_ID_AL_M1632_0	0x1632
-#endif
-#ifndef PCI_DEVICE_ID_AL_M1641_0
-#define PCI_DEVICE_ID_AL_M1641_0	0x1641
-#endif
-#ifndef PCI_DEVICE_ID_AL_M1644_0
-#define PCI_DEVICE_ID_AL_M1644_0	0x1644
-#endif
-#ifndef PCI_DEVICE_ID_AL_M1647_0
-#define PCI_DEVICE_ID_AL_M1647_0	0x1647
-#endif
-#ifndef PCI_DEVICE_ID_AL_M1651_0
-#define PCI_DEVICE_ID_AL_M1651_0	0x1651
-#endif
-
 /* intel register */
 #define INTEL_APBASE	0x10
 #define INTEL_APSIZE	0xb4
diff -urpNX dontdiff linux-2.5.33/include/linux/pci_ids.h linux-2.5.33-willy/include/linux/pci_ids.h
--- linux-2.5.33/include/linux/pci_ids.h	2002-09-04 07:20:57.000000000 -0600
+++ linux-2.5.33-willy/include/linux/pci_ids.h	2002-09-04 08:21:46.000000000 -0600
@@ -820,11 +820,13 @@
 #define PCI_DEVICE_ID_AL_M1531		0x1531
 #define PCI_DEVICE_ID_AL_M1533		0x1533
 #define PCI_DEVICE_ID_AL_M1541		0x1541
-#define PCI_DEVICE_ID_AL_M1621          0x1621
-#define PCI_DEVICE_ID_AL_M1631          0x1631
-#define PCI_DEVICE_ID_AL_M1641          0x1641
-#define PCI_DEVICE_ID_AL_M1647          0x1647
-#define PCI_DEVICE_ID_AL_M1651          0x1651
+#define PCI_DEVICE_ID_AL_M1621		0x1621
+#define PCI_DEVICE_ID_AL_M1631		0x1631
+#define PCI_DEVICE_ID_AL_M1632		0x1632
+#define PCI_DEVICE_ID_AL_M1641		0x1641
+#define PCI_DEVICE_ID_AL_M1644		0x1644
+#define PCI_DEVICE_ID_AL_M1647		0x1647
+#define PCI_DEVICE_ID_AL_M1651		0x1651
 #define PCI_DEVICE_ID_AL_M1543		0x1543
 #define PCI_DEVICE_ID_AL_M3307		0x3307
 #define PCI_DEVICE_ID_AL_M4803		0x5215
@@ -961,7 +963,7 @@
 #define PCI_DEVICE_ID_VIA_82C597_0	0x0597
 #define PCI_DEVICE_ID_VIA_82C598_0	0x0598
 #define PCI_DEVICE_ID_VIA_8601_0	0x0601
-#define PCI_DEVICE_ID_VIA_8605_0	0x0605
+#define PCI_DEVICE_ID_VIA_82C694X_0	0x0605
 #define PCI_DEVICE_ID_VIA_82C680	0x0680
 #define PCI_DEVICE_ID_VIA_82C686	0x0686
 #define PCI_DEVICE_ID_VIA_82C691	0x0691
@@ -1637,6 +1639,9 @@
 #define PCI_DEVICE_ID_INTEL_I960	0x0960
 #define PCI_DEVICE_ID_INTEL_82562ET	0x1031
 #define PCI_DEVICE_ID_INTEL_82801CAM	0x1038
+#define PCI_DEVICE_ID_INTEL_82815_MC	0x1130
+#define PCI_DEVICE_ID_INTEL_82815_AB	0x1131
+#define PCI_DEVICE_ID_INTEL_82815_CGC	0x1132
 #define PCI_DEVICE_ID_INTEL_82559ER	0x1209
 #define PCI_DEVICE_ID_INTEL_82092AA_0	0x1221
 #define PCI_DEVICE_ID_INTEL_82092AA_1	0x1222
@@ -1653,6 +1658,8 @@
 #define PCI_DEVICE_ID_INTEL_82380FB	0x124b
 #define PCI_DEVICE_ID_INTEL_82439	0x1250
 #define PCI_DEVICE_ID_INTEL_80960_RP	0x1960
+#define PCI_DEVICE_ID_INTEL_82840_HB	0x1a21
+#define PCI_DEVICE_ID_INTEL_82845_HB	0x1a30
 #define PCI_DEVICE_ID_INTEL_82801AA_0	0x2410
 #define PCI_DEVICE_ID_INTEL_82801AA_1	0x2411
 #define PCI_DEVICE_ID_INTEL_82801AA_2	0x2412
@@ -1693,6 +1700,14 @@
 #define PCI_DEVICE_ID_INTEL_82801CA_12	0x248c
 #define PCI_DEVICE_ID_INTEL_82801DB_9	0x24cb
 #define PCI_DEVICE_ID_INTEL_82801DB_11	PCI_DEVICE_ID_INTEL_82801DB_9
+#define PCI_DEVICE_ID_INTEL_82820_HB	0x2500
+#define PCI_DEVICE_ID_INTEL_82820_UP_HB	0x2501
+#define PCI_DEVICE_ID_INTEL_82850_HB	0x2530
+#define PCI_DEVICE_ID_INTEL_82860_HB	0x2531
+#define PCI_DEVICE_ID_INTEL_82845G_HB	0x2560
+#define PCI_DEVICE_ID_INTEL_82845G_IG	0x2562
+#define PCI_DEVICE_ID_INTEL_82830_HB	0x3575
+#define PCI_DEVICE_ID_INTEL_82830_CGC	0x3577
 #define PCI_DEVICE_ID_INTEL_80310	0x530d
 #define PCI_DEVICE_ID_INTEL_82371SB_0	0x7000
 #define PCI_DEVICE_ID_INTEL_82371SB_1	0x7010
@@ -1707,6 +1722,8 @@
 #define PCI_DEVICE_ID_INTEL_82810_IG1	0x7121
 #define PCI_DEVICE_ID_INTEL_82810_MC3	0x7122
 #define PCI_DEVICE_ID_INTEL_82810_IG3	0x7123
+#define PCI_DEVICE_ID_INTEL_82810E_MC	0x7124
+#define PCI_DEVICE_ID_INTEL_82810E_IG	0x7125
 #define PCI_DEVICE_ID_INTEL_82443LX_0	0x7180
 #define PCI_DEVICE_ID_INTEL_82443LX_1	0x7181
 #define PCI_DEVICE_ID_INTEL_82443BX_0	0x7190
@@ -1716,6 +1733,8 @@
 #define PCI_DEVICE_ID_INTEL_82443MX_1	0x7199
 #define PCI_DEVICE_ID_INTEL_82443MX_2	0x719a
 #define PCI_DEVICE_ID_INTEL_82443MX_3	0x719b
+#define PCI_DEVICE_ID_INTEL_82443GX_0	0x71a0
+#define PCI_DEVICE_ID_INTEL_82443GX_1	0x71a1
 #define PCI_DEVICE_ID_INTEL_82372FB_0	0x7600
 #define PCI_DEVICE_ID_INTEL_82372FB_1	0x7601
 #define PCI_DEVICE_ID_INTEL_82372FB_2	0x7602
@@ -1723,6 +1742,7 @@
 #define PCI_DEVICE_ID_INTEL_82454GX	0x84c4
 #define PCI_DEVICE_ID_INTEL_82450GX	0x84c5
 #define PCI_DEVICE_ID_INTEL_82451NX	0x84ca
+#define PCI_DEVICE_ID_INTEL_84460GX	0x84ea
 
 #define PCI_VENDOR_ID_COMPUTONE		0x8e0e
 #define PCI_DEVICE_ID_COMPUTONE_IP2EX	0x0291

-- 
Revolutions do not require corporate support.
