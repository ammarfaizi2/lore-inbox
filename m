Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314411AbSEMUhJ>; Mon, 13 May 2002 16:37:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314417AbSEMUhI>; Mon, 13 May 2002 16:37:08 -0400
Received: from medelec.uia.ac.be ([143.169.17.1]:5899 "EHLO medelec.uia.ac.be")
	by vger.kernel.org with ESMTP id <S314411AbSEMUhG>;
	Mon, 13 May 2002 16:37:06 -0400
Date: Mon, 13 May 2002 22:36:59 +0200
From: Wim Van Sebroeck <wim@iguana.be>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] 2.5.15 - i8xx series chipsets patches
Message-ID: <20020513223659.A32315@medelec.uia.ac.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,

I am sending the following patch to Linus for inclusion in the kernel.
The patch mùakes the different PCI_DEVICE_ID_INTEL_82801* define more consistent with each other.

Greetings,
Wim.

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.538   -> 1.539  
#	drivers/char/i810-tco.c	1.10    -> 1.11   
#	  drivers/ide/piix.c	1.30    -> 1.31   
#	include/linux/pci_ids.h	1.44    -> 1.45   
#	drivers/net/eepro100.c	1.31    -> 1.32   
#	 arch/i386/pci/irq.c	1.25    -> 1.26   
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 02/05/13	wim@iguana.be	1.539
# [PATCH] 2.5.15 - i8xx series chipsets patches
# 
# Cleanup PCI_DEVICE_ID_INTEL_82801* defines so that they are consistent to the other 82801 defines.
# This to make sure that we have an uniformous naming for the PCI_DEVICE_ID_INTEL_82801* defines.
# 
# changes made are:
# replace PCI_DEVICE_ID_INTEL_82801BA_7  by PCI_DEVICE_ID_INTEL_82801BA_9
# replace PCI_DEVICE_ID_INTEL_82801BA_8  by PCI_DEVICE_ID_INTEL_82801BA_10
# replace PCI_DEVICE_ID_INTEL_82801BA_9  by PCI_DEVICE_ID_INTEL_82801BA_11
# replace PCI_DEVICE_ID_INTEL_82801BA_10 by PCI_DEVICE_ID_INTEL_82801BA_12
# replace PCI_DEVICE_ID_INTEL_82801E_9   by PCI_DEVICE_ID_INTEL_82801E_11
# replace PCI_DEVICE_ID_INTEL_82801DB_9  by PCI_DEVICE_ID_INTEL_82801DB_11
# 
# changes only made in include/linux/pci_ids.h (because they were not used somewhere else):
# replace PCI_DEVICE_ID_INTEL_82801BA_1  by PCI_DEVICE_ID_INTEL_82801BA_2
# replace PCI_DEVICE_ID_INTEL_82801BA_2  by PCI_DEVICE_ID_INTEL_82801BA_3
# replace PCI_DEVICE_ID_INTEL_82801BA_3  by PCI_DEVICE_ID_INTEL_82801BA_4
# replace PCI_DEVICE_ID_INTEL_82801BA_4  by PCI_DEVICE_ID_INTEL_82801BA_5
# replace PCI_DEVICE_ID_INTEL_82801BA_5  by PCI_DEVICE_ID_INTEL_82801BA_6
# replace PCI_DEVICE_ID_INTEL_82801BA_6  by PCI_DEVICE_ID_INTEL_82801BA_8
# replace PCI_DEVICE_ID_INTEL_82801BA_11 by PCI_DEVICE_ID_INTEL_82801BA_14
# --------------------------------------------
#
diff -Nru a/arch/i386/pci/irq.c b/arch/i386/pci/irq.c
--- a/arch/i386/pci/irq.c	Mon May 13 22:23:46 2002
+++ b/arch/i386/pci/irq.c	Mon May 13 22:23:46 2002
@@ -471,7 +471,7 @@
 	{ "PIIX", PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82801AA_0, pirq_piix_get, pirq_piix_set },
 	{ "PIIX", PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82801AB_0, pirq_piix_get, pirq_piix_set },
 	{ "PIIX", PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82801BA_0, pirq_piix_get, pirq_piix_set },
-	{ "PIIX", PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82801BA_10, pirq_piix_get, pirq_piix_set },
+	{ "PIIX", PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82801BA_12, pirq_piix_get, pirq_piix_set },
 	{ "PIIX", PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82801CA_0, pirq_piix_get, pirq_piix_set },
 	{ "PIIX", PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82801CA_12, pirq_piix_get, pirq_piix_set },
 
diff -Nru a/drivers/char/i810-tco.c b/drivers/char/i810-tco.c
--- a/drivers/char/i810-tco.c	Mon May 13 22:23:45 2002
+++ b/drivers/char/i810-tco.c	Mon May 13 22:23:45 2002
@@ -301,7 +301,7 @@
 	{ PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82801AA_0,	PCI_ANY_ID, PCI_ANY_ID, },
 	{ PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82801AB_0,	PCI_ANY_ID, PCI_ANY_ID, },
 	{ PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82801BA_0,	PCI_ANY_ID, PCI_ANY_ID, },
-	{ PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82801BA_10,	PCI_ANY_ID, PCI_ANY_ID, },
+	{ PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82801BA_12,	PCI_ANY_ID, PCI_ANY_ID, },
 	{ PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82801CA_0,	PCI_ANY_ID, PCI_ANY_ID, },
 	{ PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82801CA_12,	PCI_ANY_ID, PCI_ANY_ID, },
 	{ PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82801E_0,	PCI_ANY_ID, PCI_ANY_ID, },
diff -Nru a/drivers/ide/piix.c b/drivers/ide/piix.c
--- a/drivers/ide/piix.c	Mon May 13 22:23:45 2002
+++ b/drivers/ide/piix.c	Mon May 13 22:23:45 2002
@@ -85,12 +85,12 @@
 	unsigned short id;
 	unsigned char flags;
 } piix_ide_chips[] = {
-	{ PCI_DEVICE_ID_INTEL_82801DB_9,	PIIX_UDMA_133 | PIIX_PINGPONG },                    /* Intel 82801DB ICH4 */
+	{ PCI_DEVICE_ID_INTEL_82801DB_11,	PIIX_UDMA_133 | PIIX_PINGPONG },                    /* Intel 82801DB ICH4 */
 	{ PCI_DEVICE_ID_INTEL_82801CA_11,	PIIX_UDMA_100 | PIIX_PINGPONG },                    /* Intel 82801CA ICH3/ICH3-S */
 	{ PCI_DEVICE_ID_INTEL_82801CA_10,	PIIX_UDMA_100 | PIIX_PINGPONG },                    /* Intel 82801CAM ICH3-M */
-	{ PCI_DEVICE_ID_INTEL_82801E_9,		PIIX_UDMA_100 | PIIX_PINGPONG },                    /* Intel 82801E C-ICH */
-	{ PCI_DEVICE_ID_INTEL_82801BA_9,	PIIX_UDMA_100 | PIIX_PINGPONG },                    /* Intel 82801BA ICH2 */
-	{ PCI_DEVICE_ID_INTEL_82801BA_8,	PIIX_UDMA_100 | PIIX_PINGPONG },                    /* Intel 82801BAM ICH2-M */
+	{ PCI_DEVICE_ID_INTEL_82801E_11,	PIIX_UDMA_100 | PIIX_PINGPONG },                    /* Intel 82801E C-ICH */
+	{ PCI_DEVICE_ID_INTEL_82801BA_11,	PIIX_UDMA_100 | PIIX_PINGPONG },                    /* Intel 82801BA ICH2 */
+	{ PCI_DEVICE_ID_INTEL_82801BA_10,	PIIX_UDMA_100 | PIIX_PINGPONG },                    /* Intel 82801BAM ICH2-M */
 	{ PCI_DEVICE_ID_INTEL_82801AB_1,	PIIX_UDMA_33  | PIIX_PINGPONG },                    /* Intel 82801AB ICH0 */
 	{ PCI_DEVICE_ID_INTEL_82801AA_1,	PIIX_UDMA_66  | PIIX_PINGPONG },                    /* Intel 82801AA ICH */
 	{ PCI_DEVICE_ID_INTEL_82372FB_1,	PIIX_UDMA_66 },	                                    /* Intel 82372FB PIIX5 */
@@ -652,7 +652,7 @@
 	},
 	{
 		vendor: PCI_VENDOR_ID_INTEL,
-		device: PCI_DEVICE_ID_INTEL_82801BA_9,
+		device: PCI_DEVICE_ID_INTEL_82801BA_11,
 		init_chipset: piix_init_chipset,
 		ata66_check: piix_ata66_check,
 		init_channel: piix_init_channel,
@@ -662,7 +662,7 @@
 	},
 	{
 		vendor: PCI_VENDOR_ID_INTEL,
-		device: PCI_DEVICE_ID_INTEL_82801BA_8,
+		device: PCI_DEVICE_ID_INTEL_82801BA_10,
 		init_chipset: piix_init_chipset,
 		ata66_check: piix_ata66_check,
 		init_channel: piix_init_channel,
@@ -672,7 +672,7 @@
 	},
 	{
 		vendor: PCI_VENDOR_ID_INTEL,
-		device: PCI_DEVICE_ID_INTEL_82801E_9,
+		device: PCI_DEVICE_ID_INTEL_82801E_11,
 		init_chipset: piix_init_chipset,
 		ata66_check: piix_ata66_check,
 		init_channel: piix_init_channel,
@@ -702,7 +702,7 @@
 	},
 	{
 		vendor: PCI_VENDOR_ID_INTEL,
-		device: PCI_DEVICE_ID_INTEL_82801DB_9,
+		device: PCI_DEVICE_ID_INTEL_82801DB_11,
 		init_chipset: piix_init_chipset,
 		ata66_check: piix_ata66_check,
 		init_channel: piix_init_channel,
diff -Nru a/drivers/net/eepro100.c b/drivers/net/eepro100.c
--- a/drivers/net/eepro100.c	Mon May 13 22:23:45 2002
+++ b/drivers/net/eepro100.c	Mon May 13 22:23:45 2002
@@ -2274,7 +2274,7 @@
 		PCI_ANY_ID, PCI_ANY_ID, },
 	{ PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82559ER,
 		PCI_ANY_ID, PCI_ANY_ID, },
-	{ PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82801BA_7,
+	{ PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82801BA_9,
 		PCI_ANY_ID, PCI_ANY_ID, },
 	{ PCI_VENDOR_ID_INTEL, 0x1029, PCI_ANY_ID, PCI_ANY_ID, },
 	{ PCI_VENDOR_ID_INTEL, 0x1030, PCI_ANY_ID, PCI_ANY_ID, },
diff -Nru a/include/linux/pci_ids.h b/include/linux/pci_ids.h
--- a/include/linux/pci_ids.h	Mon May 13 22:23:45 2002
+++ b/include/linux/pci_ids.h	Mon May 13 22:23:45 2002
@@ -1650,19 +1650,19 @@
 #define PCI_DEVICE_ID_INTEL_82801AB_6	0x2426
 #define PCI_DEVICE_ID_INTEL_82801AB_8	0x2428
 #define PCI_DEVICE_ID_INTEL_82801BA_0	0x2440
-#define PCI_DEVICE_ID_INTEL_82801BA_1	0x2442
-#define PCI_DEVICE_ID_INTEL_82801BA_2	0x2443
-#define PCI_DEVICE_ID_INTEL_82801BA_3	0x2444
-#define PCI_DEVICE_ID_INTEL_82801BA_4	0x2445
-#define PCI_DEVICE_ID_INTEL_82801BA_5	0x2446
-#define PCI_DEVICE_ID_INTEL_82801BA_6	0x2448
-#define PCI_DEVICE_ID_INTEL_82801BA_7	0x2449
-#define PCI_DEVICE_ID_INTEL_82801BA_8	0x244a
-#define PCI_DEVICE_ID_INTEL_82801BA_9	0x244b
-#define PCI_DEVICE_ID_INTEL_82801BA_10	0x244c
-#define PCI_DEVICE_ID_INTEL_82801BA_11	0x244e
+#define PCI_DEVICE_ID_INTEL_82801BA_2	0x2442
+#define PCI_DEVICE_ID_INTEL_82801BA_3	0x2443
+#define PCI_DEVICE_ID_INTEL_82801BA_4	0x2444
+#define PCI_DEVICE_ID_INTEL_82801BA_5	0x2445
+#define PCI_DEVICE_ID_INTEL_82801BA_6	0x2446
+#define PCI_DEVICE_ID_INTEL_82801BA_8	0x2448
+#define PCI_DEVICE_ID_INTEL_82801BA_9	0x2449
+#define PCI_DEVICE_ID_INTEL_82801BA_10	0x244a
+#define PCI_DEVICE_ID_INTEL_82801BA_11	0x244b
+#define PCI_DEVICE_ID_INTEL_82801BA_12	0x244c
+#define PCI_DEVICE_ID_INTEL_82801BA_14	0x244e
 #define PCI_DEVICE_ID_INTEL_82801E_0	0x2450
-#define PCI_DEVICE_ID_INTEL_82801E_9	0x245b
+#define PCI_DEVICE_ID_INTEL_82801E_11	0x245b
 #define PCI_DEVICE_ID_INTEL_82801CA_0	0x2480
 #define PCI_DEVICE_ID_INTEL_82801CA_2	0x2482
 #define PCI_DEVICE_ID_INTEL_82801CA_3	0x2483
@@ -1673,7 +1673,7 @@
 #define PCI_DEVICE_ID_INTEL_82801CA_10	0x248a
 #define PCI_DEVICE_ID_INTEL_82801CA_11	0x248b
 #define PCI_DEVICE_ID_INTEL_82801CA_12	0x248c
-#define PCI_DEVICE_ID_INTEL_82801DB_9	0x24cb
+#define PCI_DEVICE_ID_INTEL_82801DB_11	0x24cb
 #define PCI_DEVICE_ID_INTEL_80310	0x530d
 #define PCI_DEVICE_ID_INTEL_82371SB_0	0x7000
 #define PCI_DEVICE_ID_INTEL_82371SB_1	0x7010
