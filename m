Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278566AbRJ1Q1Z>; Sun, 28 Oct 2001 11:27:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278568AbRJ1Q1R>; Sun, 28 Oct 2001 11:27:17 -0500
Received: from medelec.uia.ac.be ([143.169.17.1]:47114 "EHLO medelec.uia.ac.be")
	by vger.kernel.org with ESMTP id <S278566AbRJ1Q1D>;
	Sun, 28 Oct 2001 11:27:03 -0500
Date: Sun, 28 Oct 2001 17:27:30 +0100
From: Wim Van Sebroeck <wim@iguana.be>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] linux-2.4.13 - i8xx series chipsets patches
Message-ID: <20011028172730.A25213@medelec.uia.ac.be>
In-Reply-To: <20011028153419.A24908@medelec.uia.ac.be> <E15xrf3-00084J-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <E15xrf3-00084J-00@the-village.bc.nu>; from alan@lxorguk.ukuu.org.uk on Sun, Oct 28, 2001 at 03:15:41PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alan,

> Can you send me this as two seperate patches then. Firstly a patch which
> just updates the naming because our existing naming is wrong (if its
> actually wrong rather than just differet)

include the patch with the updates to keep everything conform for the different 82801 chipsets.

Greetings,
Wim.


diff -u --recursive --new-file linux-2.4.13/drivers/acpi/ospm/processor/pr_osl.c linux-2.4.13-patch1/drivers/acpi/ospm/processor/pr_osl.c
--- linux-2.4.13/drivers/acpi/ospm/processor/pr_osl.c	Sun Sep 23 18:42:32 2001
+++ linux-2.4.13-patch1/drivers/acpi/ospm/processor/pr_osl.c	Sun Oct 28 17:03:15 2001
@@ -260,8 +260,8 @@
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
diff -u --recursive --new-file linux-2.4.13/drivers/char/i810-tco.c linux-2.4.13-patch1/drivers/char/i810-tco.c
--- linux-2.4.13/drivers/char/i810-tco.c	Fri Sep 14 00:21:32 2001
+++ linux-2.4.13-patch1/drivers/char/i810-tco.c	Sun Oct 28 17:03:15 2001
@@ -244,7 +244,7 @@
 	{ PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82801AA_0,	PCI_ANY_ID, PCI_ANY_ID, },
 	{ PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82801AB_0,	PCI_ANY_ID, PCI_ANY_ID, },
 	{ PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82801BA_0,	PCI_ANY_ID, PCI_ANY_ID, },
-	{ PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82801BA_10,	PCI_ANY_ID, PCI_ANY_ID, },
+	{ PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82801BA_12,	PCI_ANY_ID, PCI_ANY_ID, },
 	{ 0, },
 };
 MODULE_DEVICE_TABLE (pci, i810tco_pci_tbl);
diff -u --recursive --new-file linux-2.4.13/drivers/ide/ide-pci.c linux-2.4.13-patch1/drivers/ide/ide-pci.c
--- linux-2.4.13/drivers/ide/ide-pci.c	Sun Sep 30 21:26:05 2001
+++ linux-2.4.13-patch1/drivers/ide/ide-pci.c	Sun Oct 28 17:03:15 2001
@@ -35,8 +35,8 @@
 #define DEVID_PIIX4U	((ide_pci_devid_t){PCI_VENDOR_ID_INTEL,   PCI_DEVICE_ID_INTEL_82801AA_1})
 #define DEVID_PIIX4U2	((ide_pci_devid_t){PCI_VENDOR_ID_INTEL,   PCI_DEVICE_ID_INTEL_82372FB_1})
 #define DEVID_PIIX4NX	((ide_pci_devid_t){PCI_VENDOR_ID_INTEL,   PCI_DEVICE_ID_INTEL_82451NX})
-#define DEVID_PIIX4U3	((ide_pci_devid_t){PCI_VENDOR_ID_INTEL,   PCI_DEVICE_ID_INTEL_82801BA_9})
-#define DEVID_PIIX4U4	((ide_pci_devid_t){PCI_VENDOR_ID_INTEL,   PCI_DEVICE_ID_INTEL_82801BA_8})
+#define DEVID_PIIX4U3	((ide_pci_devid_t){PCI_VENDOR_ID_INTEL,   PCI_DEVICE_ID_INTEL_82801BA_11})
+#define DEVID_PIIX4U4	((ide_pci_devid_t){PCI_VENDOR_ID_INTEL,   PCI_DEVICE_ID_INTEL_82801BA_10})
 #define DEVID_VIA_IDE	((ide_pci_devid_t){PCI_VENDOR_ID_VIA,     PCI_DEVICE_ID_VIA_82C561})
 #define DEVID_MR_IDE	((ide_pci_devid_t){PCI_VENDOR_ID_VIA,     PCI_DEVICE_ID_VIA_82C576_1})
 #define DEVID_VP_IDE	((ide_pci_devid_t){PCI_VENDOR_ID_VIA,     PCI_DEVICE_ID_VIA_82C586_1})
diff -u --recursive --new-file linux-2.4.13/drivers/ide/piix.c linux-2.4.13-patch1/drivers/ide/piix.c
--- linux-2.4.13/drivers/ide/piix.c	Mon Aug 13 23:56:19 2001
+++ linux-2.4.13-patch1/drivers/ide/piix.c	Sun Oct 28 17:05:18 2001
@@ -89,8 +89,8 @@
 	u8  reg44 = 0, reg48 = 0, reg4a = 0, reg4b = 0, reg54 = 0, reg55 = 0;
 
 	switch(bmide_dev->device) {
-		case PCI_DEVICE_ID_INTEL_82801BA_8:
-		case PCI_DEVICE_ID_INTEL_82801BA_9:
+		case PCI_DEVICE_ID_INTEL_82801BA_10:
+		case PCI_DEVICE_ID_INTEL_82801BA_11:
 			p += sprintf(p, "\n                                Intel PIIX4 Ultra 100 Chipset.\n");
 			break;
 		case PCI_DEVICE_ID_INTEL_82372FB_1:
@@ -363,8 +363,8 @@
 	byte			speed;
 
 	byte udma_66		= eighty_ninty_three(drive);
-	int ultra100		= ((dev->device == PCI_DEVICE_ID_INTEL_82801BA_8) ||
-				   (dev->device == PCI_DEVICE_ID_INTEL_82801BA_9)) ? 1 : 0;
+	int ultra100		= ((dev->device == PCI_DEVICE_ID_INTEL_82801BA_10) ||
+				   (dev->device == PCI_DEVICE_ID_INTEL_82801BA_11)) ? 1 : 0;
 	int ultra66		= ((ultra100) ||
 				   (dev->device == PCI_DEVICE_ID_INTEL_82801AA_1) ||
 				   (dev->device == PCI_DEVICE_ID_INTEL_82372FB_1)) ? 1 : 0;
diff -u --recursive --new-file linux-2.4.13/drivers/net/eepro100.c linux-2.4.13-patch1/drivers/net/eepro100.c
--- linux-2.4.13/drivers/net/eepro100.c	Sun Sep 30 21:26:08 2001
+++ linux-2.4.13-patch1/drivers/net/eepro100.c	Sun Oct 28 17:03:15 2001
@@ -2230,7 +2230,7 @@
 		PCI_ANY_ID, PCI_ANY_ID, },
 	{ PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_ID1030,
 		PCI_ANY_ID, PCI_ANY_ID, },
-	{ PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82801BA_7,
+	{ PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82801BA_9,
 		PCI_ANY_ID, PCI_ANY_ID, },
 	{ 0,}
 };
diff -u --recursive --new-file linux-2.4.13/drivers/pci/pci.ids linux-2.4.13-patch1/drivers/pci/pci.ids
--- linux-2.4.13/drivers/pci/pci.ids	Fri Oct 19 17:32:28 2001
+++ linux-2.4.13-patch1/drivers/pci/pci.ids	Sun Oct 28 17:02:23 2001
@@ -4921,24 +4921,24 @@
 		11d4 0048  SoundMAX Integrated Digital Audio
 	2426  82801AB AC'97 Modem
 	2428  82801AB PCI Bridge
-	2440  82820 820 (Camino 2) Chipset ISA Bridge (ICH2)
-	2442  82820 820 (Camino 2) Chipset USB (Hub A)
-	2443  82820 820 (Camino 2) Chipset SMBus
-	2444  82820 820 (Camino 2) Chipset USB (Hub B)
-	2445  82820 820 (Camino 2) Chipset AC'97 Audio Controller
-	2446  82820 820 (Camino 2) Chipset AC'97 Modem Controller
-	2448  82820 820 (Camino 2) Chipset PCI (-M)
-	2449  82820 (ICH2) Chipset Ethernet Controller
-	244a  82820 820 (Camino 2) Chipset IDE U100 (-M)
-	244b  82820 820 (Camino 2) Chipset IDE U100
-	244c  82820 820 (Camino 2) Chipset ISA Bridge (ICH2-M)
-	244e  82820 820 (Camino 2) Chipset PCI
+	2440  82801BA ISA Bridge (LPC)
+	2442  82801BA/BAM USB (Hub #1)
+	2443  82801BA/BAM SMBus
+	2444  82801BA/BAM USB (Hub #2)
+	2445  82801BA/BAM AC'97 Audio
+	2446  82801BA/BAM AC'97 Modem
+	2448  82801BAM/CAM PCI Bridge
+	2449  82801BA/BAM/CA/CAM Ethernet Controller
+	244a  82801BAM IDE U100
+	244b  82801BA IDE U100
+	244c  82801BAM ISA Bridge (LPC)
+	244e  82801BA/CA PCI Bridge
 	2500  82820 820 (Camino) Chipset Host Bridge (MCH)
 		1043 801c  P3C-2000 system chipset
 	2501  82820 820 (Camino) Chipset Host Bridge (MCH)
 		1043 801c  P3C-2000 system chipset
 	250b  82820 820 (Camino) Chipset Host Bridge
-	250f  82820 820 (Camino) Chipset PCI to AGP Bridge
+	250f  82820 820 (Camino) Chipset AGP Bridge
 	2520  82805AA MTH Memory Translator Hub
 	2521  82804AA MRH-S Memory Repeater Hub for SDRAM
 	2530  82850 850 (Tehama) Chipset Host Bridge (MCH)
diff -u --recursive --new-file linux-2.4.13/include/linux/pci_ids.h linux-2.4.13-patch1/include/linux/pci_ids.h
--- linux-2.4.13/include/linux/pci_ids.h	Wed Oct 17 06:56:29 2001
+++ linux-2.4.13-patch1/include/linux/pci_ids.h	Sun Oct 28 17:03:15 2001
@@ -1559,15 +1559,6 @@
 #define PCI_DEVICE_ID_INTEL_82380FB	0x124b
 #define PCI_DEVICE_ID_INTEL_82439	0x1250
 #define PCI_DEVICE_ID_INTEL_80960_RP	0x1960
-#define PCI_DEVICE_ID_INTEL_82371SB_0	0x7000
-#define PCI_DEVICE_ID_INTEL_82371SB_1	0x7010
-#define PCI_DEVICE_ID_INTEL_82371SB_2	0x7020
-#define PCI_DEVICE_ID_INTEL_82437VX	0x7030
-#define PCI_DEVICE_ID_INTEL_82439TX	0x7100
-#define PCI_DEVICE_ID_INTEL_82371AB_0	0x7110
-#define PCI_DEVICE_ID_INTEL_82371AB	0x7111
-#define PCI_DEVICE_ID_INTEL_82371AB_2	0x7112
-#define PCI_DEVICE_ID_INTEL_82371AB_3	0x7113
 #define PCI_DEVICE_ID_INTEL_82801AA_0	0x2410
 #define PCI_DEVICE_ID_INTEL_82801AA_1	0x2411
 #define PCI_DEVICE_ID_INTEL_82801AA_2	0x2412
@@ -1583,17 +1574,17 @@
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
@@ -1605,6 +1596,15 @@
 #define PCI_DEVICE_ID_INTEL_82801CA_11	0x248b
 #define PCI_DEVICE_ID_INTEL_82801CA_12	0x248c
 #define PCI_DEVICE_ID_INTEL_80310	0x530d
+#define PCI_DEVICE_ID_INTEL_82371SB_0	0x7000
+#define PCI_DEVICE_ID_INTEL_82371SB_1	0x7010
+#define PCI_DEVICE_ID_INTEL_82371SB_2	0x7020
+#define PCI_DEVICE_ID_INTEL_82437VX	0x7030
+#define PCI_DEVICE_ID_INTEL_82439TX	0x7100
+#define PCI_DEVICE_ID_INTEL_82371AB_0	0x7110
+#define PCI_DEVICE_ID_INTEL_82371AB	0x7111
+#define PCI_DEVICE_ID_INTEL_82371AB_2	0x7112
+#define PCI_DEVICE_ID_INTEL_82371AB_3	0x7113
 #define PCI_DEVICE_ID_INTEL_82810_MC1	0x7120
 #define PCI_DEVICE_ID_INTEL_82810_IG1	0x7121
 #define PCI_DEVICE_ID_INTEL_82810_MC3	0x7122
