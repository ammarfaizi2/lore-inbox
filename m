Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281727AbRKQMAP>; Sat, 17 Nov 2001 07:00:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281731AbRKQMAF>; Sat, 17 Nov 2001 07:00:05 -0500
Received: from medelec.uia.ac.be ([143.169.17.1]:50951 "EHLO medelec.uia.ac.be")
	by vger.kernel.org with ESMTP id <S281730AbRKQL76>;
	Sat, 17 Nov 2001 06:59:58 -0500
Date: Sat, 17 Nov 2001 12:59:48 +0100
From: Wim Van Sebroeck <wim@iguana.be>
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] linux-2.4.15-pre5 - i8xx series chipsets patches (patch3)
Message-ID: <20011117125948.C18560@medelec.uia.ac.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

and my last patch against linux-2.4.15-pre5 (actually it is diffed against my two previous patches).
This patch is just to change the PCI_DEVICE_ID's for the intel 82801BA ID's; since they have been done differently then the ID's for the 82801AA; 82801AB and 82801CA ID's.

Greetings,
Wim.


diff -u --recursive --new-file linux-2.4.15-pre5-patch2/drivers/acpi/ospm/processor/pr_osl.c linux-2.4.15-pre5-patch3/drivers/acpi/ospm/processor/pr_osl.c
--- linux-2.4.15-pre5-patch2/drivers/acpi/ospm/processor/pr_osl.c	Sat Nov 17 12:17:09 2001
+++ linux-2.4.15-pre5-patch3/drivers/acpi/ospm/processor/pr_osl.c	Sat Nov 17 12:21:50 2001
@@ -260,8 +260,8 @@
 		switch (dev->device) {
 		case PCI_DEVICE_ID_INTEL_82801CA_11:	/* PIIX4U6 */
 		case PCI_DEVICE_ID_INTEL_82801CA_10:	/* PIIX4U5 */
-		case PCI_DEVICE_ID_INTEL_82801BA_8:	/* PIIX4U4 */
-		case PCI_DEVICE_ID_INTEL_82801BA_9:	/* PIIX4U3 */
+		case PCI_DEVICE_ID_INTEL_82801BA_10:	/* PIIX4U4 */
+		case PCI_DEVICE_ID_INTEL_82801BA_11:	/* PIIX4U3 */
 		case PCI_DEVICE_ID_INTEL_82451NX:	/* PIIX4NX */
 		case PCI_DEVICE_ID_INTEL_82372FB_1:	/* PIIX4U2 */
 		case PCI_DEVICE_ID_INTEL_82801AA_1:	/* PIIX4U */
diff -u --recursive --new-file linux-2.4.15-pre5-patch2/drivers/char/i810-tco.c linux-2.4.15-pre5-patch3/drivers/char/i810-tco.c
--- linux-2.4.15-pre5-patch2/drivers/char/i810-tco.c	Sat Nov 17 12:11:13 2001
+++ linux-2.4.15-pre5-patch3/drivers/char/i810-tco.c	Sat Nov 17 12:22:38 2001
@@ -239,7 +239,7 @@
 	{ PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82801AA_0,	PCI_ANY_ID, PCI_ANY_ID, },
 	{ PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82801AB_0,	PCI_ANY_ID, PCI_ANY_ID, },
 	{ PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82801BA_0,	PCI_ANY_ID, PCI_ANY_ID, },
-	{ PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82801BA_10,	PCI_ANY_ID, PCI_ANY_ID, },
+	{ PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82801BA_12,	PCI_ANY_ID, PCI_ANY_ID, },
 	{ PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82801CA_0,	PCI_ANY_ID, PCI_ANY_ID, },
 	{ PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82801CA_12,	PCI_ANY_ID, PCI_ANY_ID, },
 	{ 0, },
diff -u --recursive --new-file linux-2.4.15-pre5-patch2/drivers/char/i810_rng.c linux-2.4.15-pre5-patch3/drivers/char/i810_rng.c
--- linux-2.4.15-pre5-patch2/drivers/char/i810_rng.c	Sat Nov 17 12:14:39 2001
+++ linux-2.4.15-pre5-patch3/drivers/char/i810_rng.c	Sat Nov 17 12:22:13 2001
@@ -334,7 +334,7 @@
 static struct pci_device_id rng_pci_tbl[] __initdata = {
 	{ PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82801AA_8, PCI_ANY_ID, PCI_ANY_ID, },
 	{ PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82801AB_8, PCI_ANY_ID, PCI_ANY_ID, },
-	{ PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82801BA_6, PCI_ANY_ID, PCI_ANY_ID, },
+	{ PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82801BA_8, PCI_ANY_ID, PCI_ANY_ID, },
 	{ PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82801BA_14, PCI_ANY_ID, PCI_ANY_ID, },
 	{ 0, },
 };
diff -u --recursive --new-file linux-2.4.15-pre5-patch2/drivers/ide/ide-pci.c linux-2.4.15-pre5-patch3/drivers/ide/ide-pci.c
--- linux-2.4.15-pre5-patch2/drivers/ide/ide-pci.c	Sat Nov 17 12:18:38 2001
+++ linux-2.4.15-pre5-patch3/drivers/ide/ide-pci.c	Sat Nov 17 12:23:14 2001
@@ -35,8 +35,8 @@
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
diff -u --recursive --new-file linux-2.4.15-pre5-patch2/drivers/ide/piix.c linux-2.4.15-pre5-patch3/drivers/ide/piix.c
--- linux-2.4.15-pre5-patch2/drivers/ide/piix.c	Sat Nov 17 12:19:57 2001
+++ linux-2.4.15-pre5-patch3/drivers/ide/piix.c	Sat Nov 17 12:24:05 2001
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
diff -u --recursive --new-file linux-2.4.15-pre5-patch2/drivers/net/eepro100.c linux-2.4.15-pre5-patch3/drivers/net/eepro100.c
--- linux-2.4.15-pre5-patch2/drivers/net/eepro100.c	Fri Nov 16 23:23:14 2001
+++ linux-2.4.15-pre5-patch3/drivers/net/eepro100.c	Sat Nov 17 12:24:52 2001
@@ -2271,7 +2271,7 @@
 		PCI_ANY_ID, PCI_ANY_ID, },
 	{ PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_ID1030,
 		PCI_ANY_ID, PCI_ANY_ID, },
-	{ PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82801BA_7,
+	{ PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82801BA_9,
 		PCI_ANY_ID, PCI_ANY_ID, },
 	{ 0,}
 };
diff -u --recursive --new-file linux-2.4.15-pre5-patch2/include/linux/pci_ids.h linux-2.4.15-pre5-patch3/include/linux/pci_ids.h
--- linux-2.4.15-pre5-patch2/include/linux/pci_ids.h	Sat Nov 17 12:02:43 2001
+++ linux-2.4.15-pre5-patch3/include/linux/pci_ids.h	Sat Nov 17 12:27:23 2001
@@ -1597,17 +1597,17 @@
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
