Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313477AbSEDOjF>; Sat, 4 May 2002 10:39:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313702AbSEDOjE>; Sat, 4 May 2002 10:39:04 -0400
Received: from medelec.uia.ac.be ([143.169.17.1]:46354 "EHLO medelec.uia.ac.be")
	by vger.kernel.org with ESMTP id <S313477AbSEDOi7>;
	Sat, 4 May 2002 10:38:59 -0400
Date: Sat, 4 May 2002 16:38:57 +0200
From: Wim Van Sebroeck <wim@iguana.be>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] 2.4.19-pre8 - i8xx series chipsets patches (patch 3)
Message-ID: <20020504163857.A11124@medelec.uia.ac.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,

I am sending the following patch to Marcelo for inclusion in the kernel.

Greetings,
Wim.


# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.407   -> 1.408  
#	drivers/char/i810-tco.c	1.10    -> 1.11   
#	  drivers/ide/piix.c	1.10    -> 1.11   
#	include/linux/pci_ids.h	1.39    -> 1.40   
#	drivers/acpi/ospm/processor/pr_osl.c	1.6     -> 1.7    
#	drivers/net/eepro100.c	1.28    -> 1.29   
#	drivers/ide/ide-pci.c	1.16    -> 1.17   
#	arch/i386/kernel/pci-irq.c	1.14    -> 1.15   
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 02/05/04	wim@iguana.be	1.408
# [PATCH] 2.4.19-pre8 i8xx series chipsets patches (patch 3)
# 
# Cleanup PCI_DEVICE_ID_INTEL_82801BA defines so that they are consistent to the other 82801 defines.
# This to make sure that we have an uniformous naming for the PCI_DEVICE_ID_INTEL_82801* defines.
# 
# changes made are:
# replace PCI_DEVICE_ID_INTEL_82801BA_7  by PCI_DEVICE_ID_INTEL_82801BA_9
# replace PCI_DEVICE_ID_INTEL_82801BA_8  by PCI_DEVICE_ID_INTEL_82801BA_10
# replace PCI_DEVICE_ID_INTEL_82801BA_9  by PCI_DEVICE_ID_INTEL_82801BA_11
# replace PCI_DEVICE_ID_INTEL_82801BA_10 by PCI_DEVICE_ID_INTEL_82801BA_12
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
diff -Nru a/arch/i386/kernel/pci-irq.c b/arch/i386/kernel/pci-irq.c
--- a/arch/i386/kernel/pci-irq.c	Sat May  4 16:12:58 2002
+++ b/arch/i386/kernel/pci-irq.c	Sat May  4 16:12:58 2002
@@ -464,7 +464,7 @@
 	{ "PIIX", PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82801AA_0, pirq_piix_get, pirq_piix_set },
 	{ "PIIX", PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82801AB_0, pirq_piix_get, pirq_piix_set },
 	{ "PIIX", PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82801BA_0, pirq_piix_get, pirq_piix_set },
-	{ "PIIX", PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82801BA_10, pirq_piix_get, pirq_piix_set },
+	{ "PIIX", PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82801BA_12, pirq_piix_get, pirq_piix_set },
 	{ "PIIX", PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82801CA_0, pirq_piix_get, pirq_piix_set },
 	{ "PIIX", PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82801CA_12, pirq_piix_get, pirq_piix_set },
 
diff -Nru a/drivers/acpi/ospm/processor/pr_osl.c b/drivers/acpi/ospm/processor/pr_osl.c
--- a/drivers/acpi/ospm/processor/pr_osl.c	Sat May  4 16:12:58 2002
+++ b/drivers/acpi/ospm/processor/pr_osl.c	Sat May  4 16:12:58 2002
@@ -259,8 +259,8 @@
 	while ((dev = pci_find_subsys(PCI_VENDOR_ID_INTEL, PCI_ANY_ID, 
 		PCI_ANY_ID, PCI_ANY_ID, dev))) {
 		switch (dev->device) {
-		case PCI_DEVICE_ID_INTEL_82801BA_8:	/* PIIX4U4 */
-		case PCI_DEVICE_ID_INTEL_82801BA_9:	/* PIIX4U3 */
+		case PCI_DEVICE_ID_INTEL_82801BA_10:	/* PIIX4U4 */
+		case PCI_DEVICE_ID_INTEL_82801BA_11:	/* PIIX4U3 */
 		case PCI_DEVICE_ID_INTEL_82451NX:	/* PIIX4NX */
 		case PCI_DEVICE_ID_INTEL_82372FB_1:	/* PIIX4U2 */
 		case PCI_DEVICE_ID_INTEL_82801AA_1:	/* PIIX4U */
diff -Nru a/drivers/char/i810-tco.c b/drivers/char/i810-tco.c
--- a/drivers/char/i810-tco.c	Sat May  4 16:12:57 2002
+++ b/drivers/char/i810-tco.c	Sat May  4 16:12:57 2002
@@ -282,7 +282,7 @@
 	{ PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82801AA_0,	PCI_ANY_ID, PCI_ANY_ID, },
 	{ PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82801AB_0,	PCI_ANY_ID, PCI_ANY_ID, },
 	{ PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82801BA_0,	PCI_ANY_ID, PCI_ANY_ID, },
-	{ PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82801BA_10,	PCI_ANY_ID, PCI_ANY_ID, },
+	{ PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82801BA_12,	PCI_ANY_ID, PCI_ANY_ID, },
 	{ PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82801CA_0,	PCI_ANY_ID, PCI_ANY_ID, },
 	{ PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82801CA_12,	PCI_ANY_ID, PCI_ANY_ID, },
 	{ 0, },
diff -Nru a/drivers/ide/ide-pci.c b/drivers/ide/ide-pci.c
--- a/drivers/ide/ide-pci.c	Sat May  4 16:12:58 2002
+++ b/drivers/ide/ide-pci.c	Sat May  4 16:12:58 2002
@@ -42,8 +42,8 @@
 #define DEVID_PIIX4U	((ide_pci_devid_t){PCI_VENDOR_ID_INTEL,   PCI_DEVICE_ID_INTEL_82801AA_1})
 #define DEVID_PIIX4U2	((ide_pci_devid_t){PCI_VENDOR_ID_INTEL,   PCI_DEVICE_ID_INTEL_82372FB_1})
 #define DEVID_PIIX4NX	((ide_pci_devid_t){PCI_VENDOR_ID_INTEL,   PCI_DEVICE_ID_INTEL_82451NX})
-#define DEVID_PIIX4U3	((ide_pci_devid_t){PCI_VENDOR_ID_INTEL,   PCI_DEVICE_ID_INTEL_82801BA_9})
-#define DEVID_PIIX4U4	((ide_pci_devid_t){PCI_VENDOR_ID_INTEL,   PCI_DEVICE_ID_INTEL_82801BA_8})
+#define DEVID_PIIX4U3	((ide_pci_devid_t){PCI_VENDOR_ID_INTEL,   PCI_DEVICE_ID_INTEL_82801BA_11})
+#define DEVID_PIIX4U4	((ide_pci_devid_t){PCI_VENDOR_ID_INTEL,   PCI_DEVICE_ID_INTEL_82801BA_10})
 #define DEVID_PIIX4U5	((ide_pci_devid_t){PCI_VENDOR_ID_INTEL,   PCI_DEVICE_ID_INTEL_82801CA_10})
 #define DEVID_PIIX4U6	((ide_pci_devid_t){PCI_VENDOR_ID_INTEL,   PCI_DEVICE_ID_INTEL_82801CA_11})
 #define DEVID_VIA_IDE	((ide_pci_devid_t){PCI_VENDOR_ID_VIA,     PCI_DEVICE_ID_VIA_82C561})
diff -Nru a/drivers/ide/piix.c b/drivers/ide/piix.c
--- a/drivers/ide/piix.c	Sat May  4 16:12:57 2002
+++ b/drivers/ide/piix.c	Sat May  4 16:12:57 2002
@@ -89,8 +89,8 @@
 	u8  reg44 = 0, reg48 = 0, reg4a = 0, reg4b = 0, reg54 = 0, reg55 = 0;
 
 	switch(bmide_dev->device) {
-		case PCI_DEVICE_ID_INTEL_82801BA_8:
-		case PCI_DEVICE_ID_INTEL_82801BA_9:
+		case PCI_DEVICE_ID_INTEL_82801BA_10:
+		case PCI_DEVICE_ID_INTEL_82801BA_11:
 	        case PCI_DEVICE_ID_INTEL_82801CA_10:
 	        case PCI_DEVICE_ID_INTEL_82801CA_11:
 			p += sprintf(p, "\n                                Intel PIIX4 Ultra 100 Chipset.\n");
@@ -365,8 +365,8 @@
 	byte			speed;
 
 	byte udma_66		= eighty_ninty_three(drive);
-	int ultra100		= ((dev->device == PCI_DEVICE_ID_INTEL_82801BA_8) ||
-				   (dev->device == PCI_DEVICE_ID_INTEL_82801BA_9) ||
+	int ultra100		= ((dev->device == PCI_DEVICE_ID_INTEL_82801BA_10) ||
+				   (dev->device == PCI_DEVICE_ID_INTEL_82801BA_11) ||
 				   (dev->device == PCI_DEVICE_ID_INTEL_82801CA_10) ||
 				   (dev->device == PCI_DEVICE_ID_INTEL_82801CA_11)) ? 1 : 0;
 	int ultra66		= ((ultra100) ||
diff -Nru a/drivers/net/eepro100.c b/drivers/net/eepro100.c
--- a/drivers/net/eepro100.c	Sat May  4 16:12:58 2002
+++ b/drivers/net/eepro100.c	Sat May  4 16:12:58 2002
@@ -2276,7 +2276,7 @@
 		PCI_ANY_ID, PCI_ANY_ID, },
 	{ PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82559ER,
 		PCI_ANY_ID, PCI_ANY_ID, },
-	{ PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82801BA_7,
+	{ PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82801BA_9,
 		PCI_ANY_ID, PCI_ANY_ID, },
 	{ PCI_VENDOR_ID_INTEL, 0x1029, PCI_ANY_ID, PCI_ANY_ID, },
 	{ PCI_VENDOR_ID_INTEL, 0x1030, PCI_ANY_ID, PCI_ANY_ID, },
diff -Nru a/include/linux/pci_ids.h b/include/linux/pci_ids.h
--- a/include/linux/pci_ids.h	Sat May  4 16:12:57 2002
+++ b/include/linux/pci_ids.h	Sat May  4 16:12:58 2002
@@ -1644,17 +1644,17 @@
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
 #define PCI_DEVICE_ID_INTEL_82801CA_0	0x2480
 #define PCI_DEVICE_ID_INTEL_82801CA_2	0x2482
 #define PCI_DEVICE_ID_INTEL_82801CA_3	0x2483
