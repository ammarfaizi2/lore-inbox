Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265199AbUE0UVs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265199AbUE0UVs (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 May 2004 16:21:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265187AbUE0UVs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 May 2004 16:21:48 -0400
Received: from hqemgate02.nvidia.com ([216.228.112.145]:33540 "EHLO
	hqemgate02.nvidia.com") by vger.kernel.org with ESMTP
	id S265195AbUE0UVO convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 May 2004 16:21:14 -0400
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: [PATCH] add new nForce IDE/SATA device IDs
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Date: Thu, 27 May 2004 13:21:03 -0700
Message-ID: <C064BF1617D93B4B83714E38C4653A6E0AF48249@mail-sc-10.nvidia.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH] add new nForce IDE/SATA device IDs
Thread-Index: AcREIjL24UsD0IYVQbiwHNTMbkLXygAAuvCw
From: "Brian Lazara" <blazara@nvidia.com>
To: "Jeff Garzik" <jgarzik@pobox.com>, <linux-kernel@vger.kernel.org>
Cc: <linux-ide@vger.kernel.org>,
       "Bartlomiej Zolnierkiewicz" <B.Zolnierkiewicz@elka.pw.edu.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry about that. Patches added below as plain text:

> 3) Normally we want to add SATA support to libata not
> drivers/ide.  Do 
> the nVidia SATA chips support SATA SCRs or anything like 
> that?  Why not 
> use libata?

We do plan on moving our SATA support to libata.

Patches for 2.4.27-pre2 and 2.6.6 to add device IDs for new nForce IDE
and SATA controllers. Rename some of the existing controller names to
correctly match released product names. 

diff -uprN -X dontdiff linux-2.6.6/drivers/ide/pci/amd74xx.c
linux-2.6.6-nforce-ck804-ide/drivers/ide/pci/amd74xx.c
--- linux-2.6.6/drivers/ide/pci/amd74xx.c	2004-05-09
19:33:21.000000000 -0700
+++ linux-2.6.6-nforce-ck804-ide/drivers/ide/pci/amd74xx.c
2004-05-17 15:03:08.000000000 -0700
@@ -1,7 +1,8 @@
 /*
  * Version 2.13
  *
- * AMD 755/756/766/8111 and nVidia nForce/2/2s/3/3s IDE driver for
Linux.
+ * AMD 755/756/766/8111 and nVidia nForce/2/2s/3/3s/CK804/MCP04
+ * IDE driver for Linux.
  *
  * Copyright (c) 2000-2002 Vojtech Pavlik
  *
@@ -68,6 +69,12 @@ static struct amd_ide_chip {
 	{ PCI_DEVICE_ID_NVIDIA_NFORCE3S_IDE,	0x50, AMD_UDMA_133 },
 	{ PCI_DEVICE_ID_NVIDIA_NFORCE3S_SATA,	0x50, AMD_UDMA_133 },
 	{ PCI_DEVICE_ID_NVIDIA_NFORCE3S_SATA2,	0x50, AMD_UDMA_133 },
+	{ PCI_DEVICE_ID_NVIDIA_NFORCE_CK804_IDE,	0x50,
AMD_UDMA_133 },
+	{ PCI_DEVICE_ID_NVIDIA_NFORCE_CK804_SATA,	0x50,
AMD_UDMA_133 },
+	{ PCI_DEVICE_ID_NVIDIA_NFORCE_CK804_SATA2,	0x50,
AMD_UDMA_133 },
+	{ PCI_DEVICE_ID_NVIDIA_NFORCE_MCP04_IDE,	0x50,
AMD_UDMA_133 },
+	{ PCI_DEVICE_ID_NVIDIA_NFORCE_MCP04_SATA,	0x50,
AMD_UDMA_133 },
+	{ PCI_DEVICE_ID_NVIDIA_NFORCE_MCP04_SATA2,	0x50,
AMD_UDMA_133 },
 	{ 0 }
 };
 
@@ -465,6 +472,12 @@ static struct pci_device_id amd74xx_pci_
 	{ PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_NFORCE3S_IDE,
PCI_ANY_ID, PCI_ANY_ID, 0, 0, 10 },
 	{ PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_NFORCE3S_SATA,
PCI_ANY_ID, PCI_ANY_ID, 0, 0, 11 },
 	{ PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_NFORCE3S_SATA2,
PCI_ANY_ID, PCI_ANY_ID, 0, 0, 12 },
+	{ PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_NFORCE_CK804_IDE,
PCI_ANY_ID, PCI_ANY_ID, 0, 0, 13 },
+	{ PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_NFORCE_CK804_SATA,
PCI_ANY_ID, PCI_ANY_ID, 0, 0, 14 },
+	{ PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_NFORCE_CK804_SATA2,
PCI_ANY_ID, PCI_ANY_ID, 0, 0, 15 },
+	{ PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_NFORCE_MCP04_IDE,
PCI_ANY_ID, PCI_ANY_ID, 0, 0, 16 },
+	{ PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_NFORCE_MCP04_SATA,
PCI_ANY_ID, PCI_ANY_ID, 0, 0, 17 },
+	{ PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_NFORCE_MCP04_SATA2,

+PCI_ANY_ID, PCI_ANY_ID, 0, 0, 18 },
 	{ 0, },
 };
 MODULE_DEVICE_TABLE(pci, amd74xx_pci_tbl);
diff -uprN -X dontdiff linux-2.6.6/drivers/ide/pci/amd74xx.h
linux-2.6.6-nforce-ck804-ide/drivers/ide/pci/amd74xx.h
--- linux-2.6.6/drivers/ide/pci/amd74xx.h	2004-05-09
19:31:59.000000000 -0700
+++ linux-2.6.6-nforce-ck804-ide/drivers/ide/pci/amd74xx.h
2004-05-17 15:03:08.000000000 -0700
@@ -94,7 +94,7 @@ static ide_pci_device_t amd74xx_chipsets
 	{	/* 7 */
 		.vendor		= PCI_VENDOR_ID_NVIDIA,
 		.device		= PCI_DEVICE_ID_NVIDIA_NFORCE2S_IDE,
-		.name		= "NFORCE2S",
+		.name		= "NFORCE2-U400R",
 		.init_chipset	= init_chipset_amd74xx,
 		.init_hwif	= init_hwif_amd74xx,
 		.channels	= 2,
@@ -105,7 +105,7 @@ static ide_pci_device_t amd74xx_chipsets
 	{	/* 8 */
 		.vendor		= PCI_VENDOR_ID_NVIDIA,
 		.device		= PCI_DEVICE_ID_NVIDIA_NFORCE2S_SATA,
-		.name		= "NFORCE2S-SATA",
+		.name		= "NFORCE2-U400R-SATA",
 		.init_chipset	= init_chipset_amd74xx,
 		.init_hwif	= init_hwif_amd74xx,
 		.channels	= 2,
@@ -116,7 +116,7 @@ static ide_pci_device_t amd74xx_chipsets
 	{	/* 9 */
 		.vendor		= PCI_VENDOR_ID_NVIDIA,
 		.device		= PCI_DEVICE_ID_NVIDIA_NFORCE3_IDE,
-		.name		= "NFORCE3",
+		.name		= "NFORCE3-150",
 		.init_chipset	= init_chipset_amd74xx,
 		.init_hwif	= init_hwif_amd74xx,
 		.channels	= 2,
@@ -127,7 +127,7 @@ static ide_pci_device_t amd74xx_chipsets
 	{	/* 10 */
 		.vendor		= PCI_VENDOR_ID_NVIDIA,
 		.device		= PCI_DEVICE_ID_NVIDIA_NFORCE3S_IDE,
-		.name		= "NFORCE3S",
+		.name		= "NFORCE3-250",
 		.init_chipset	= init_chipset_amd74xx,
 		.init_hwif	= init_hwif_amd74xx,
 		.channels	= 2,
@@ -138,7 +138,7 @@ static ide_pci_device_t amd74xx_chipsets
 	{	/* 11 */
 		.vendor		= PCI_VENDOR_ID_NVIDIA,
 		.device		= PCI_DEVICE_ID_NVIDIA_NFORCE3S_SATA,
-		.name		= "NFORCE3S-SATA",
+		.name		= "NFORCE3-250-SATA",
 		.init_chipset	= init_chipset_amd74xx,
 		.init_hwif	= init_hwif_amd74xx,
 		.channels	= 2,
@@ -149,7 +149,73 @@ static ide_pci_device_t amd74xx_chipsets
 	{	/* 12 */
 		.vendor		= PCI_VENDOR_ID_NVIDIA,
 		.device		= PCI_DEVICE_ID_NVIDIA_NFORCE3S_SATA2,
-		.name		= "NFORCE3S-SATA2",
+		.name		= "NFORCE3-250-SATA2",
+		.init_chipset	= init_chipset_amd74xx,
+		.init_hwif	= init_hwif_amd74xx,
+		.channels	= 2,
+		.autodma	= AUTODMA,
+		.enablebits	= {{0x50,0x02,0x02}, {0x50,0x01,0x01}},
+		.bootable	= ON_BOARD,
+	},
+	{	/* 13 */
+		.vendor		= PCI_VENDOR_ID_NVIDIA,
+		.device		= PCI_DEVICE_ID_NVIDIA_NFORCE_CK804_IDE,
+		.name		= "NFORCE-CK804",
+		.init_chipset	= init_chipset_amd74xx,
+		.init_hwif	= init_hwif_amd74xx,
+		.channels	= 2,
+		.autodma	= AUTODMA,
+		.enablebits	= {{0x50,0x02,0x02}, {0x50,0x01,0x01}},
+		.bootable	= ON_BOARD,
+	},
+	{	/* 14 */
+		.vendor		= PCI_VENDOR_ID_NVIDIA,
+		.device		=
PCI_DEVICE_ID_NVIDIA_NFORCE_CK804_SATA,
+		.name		= "NFORCE-CK804-SATA",
+		.init_chipset	= init_chipset_amd74xx,
+		.init_hwif	= init_hwif_amd74xx,
+		.channels	= 2,
+		.autodma	= AUTODMA,
+		.enablebits	= {{0x50,0x02,0x02}, {0x50,0x01,0x01}},
+		.bootable	= ON_BOARD,
+	},
+	{	/* 15 */
+		.vendor		= PCI_VENDOR_ID_NVIDIA,
+		.device		=
PCI_DEVICE_ID_NVIDIA_NFORCE_CK804_SATA2,
+		.name		= "NFORCE-CK804-SATA2",
+		.init_chipset	= init_chipset_amd74xx,
+		.init_hwif	= init_hwif_amd74xx,
+		.channels	= 2,
+		.autodma	= AUTODMA,
+		.enablebits	= {{0x50,0x02,0x02}, {0x50,0x01,0x01}},
+		.bootable	= ON_BOARD,
+	},
+	{	/* 16 */
+		.vendor		= PCI_VENDOR_ID_NVIDIA,
+		.device		= PCI_DEVICE_ID_NVIDIA_NFORCE_MCP04_IDE,
+		.name		= "NFORCE-MCP04",
+		.init_chipset	= init_chipset_amd74xx,
+		.init_hwif	= init_hwif_amd74xx,
+		.channels	= 2,
+		.autodma	= AUTODMA,
+		.enablebits	= {{0x50,0x02,0x02}, {0x50,0x01,0x01}},
+		.bootable	= ON_BOARD,
+	},
+	{	/* 17 */
+		.vendor		= PCI_VENDOR_ID_NVIDIA,
+		.device		=
PCI_DEVICE_ID_NVIDIA_NFORCE_MCP04_SATA,
+		.name		= "NFORCE-MCP04-SATA",
+		.init_chipset	= init_chipset_amd74xx,
+		.init_hwif	= init_hwif_amd74xx,
+		.channels	= 2,
+		.autodma	= AUTODMA,
+		.enablebits	= {{0x50,0x02,0x02}, {0x50,0x01,0x01}},
+		.bootable	= ON_BOARD,
+	},
+	{	/* 18 */
+		.vendor		= PCI_VENDOR_ID_NVIDIA,
+		.device		=
PCI_DEVICE_ID_NVIDIA_NFORCE_MCP04_SATA2,
+		.name		= "NFORCE-MCP04-SATA2",
 		.init_chipset	= init_chipset_amd74xx,
 		.init_hwif	= init_hwif_amd74xx,
 		.channels	= 2,
diff -uprN -X dontdiff linux-2.6.6/include/linux/pci_ids.h
linux-2.6.6-nforce-ck804-ide/include/linux/pci_ids.h
--- linux-2.6.6/include/linux/pci_ids.h	2004-05-09 19:32:28.000000000
-0700
+++ linux-2.6.6-nforce-ck804-ide/include/linux/pci_ids.h
2004-05-17 15:03:08.000000000 -0700
@@ -1054,6 +1054,12 @@
 #define PCI_DEVICE_ID_NVIDIA_UTNT2		0x0029
 #define PCI_DEVICE_ID_NVIDIA_VTNT2		0x002C
 #define PCI_DEVICE_ID_NVIDIA_UVTNT2		0x002D
+#define PCI_DEVICE_ID_NVIDIA_NFORCE_MCP04_IDE	0x0035
+#define PCI_DEVICE_ID_NVIDIA_NFORCE_MCP04_SATA	0x0036
+#define PCI_DEVICE_ID_NVIDIA_NFORCE_MCP04_SATA2	0x003e
+#define PCI_DEVICE_ID_NVIDIA_NFORCE_CK804_IDE	0x0053
+#define PCI_DEVICE_ID_NVIDIA_NFORCE_CK804_SATA	0x0054
+#define PCI_DEVICE_ID_NVIDIA_NFORCE_CK804_SATA2	0x0055
 #define PCI_DEVICE_ID_NVIDIA_NFORCE2_IDE	0x0065
 #define PCI_DEVICE_ID_NVIDIA_NFORCE2S_IDE	0x0085
 #define PCI_DEVICE_ID_NVIDIA_NFORCE2S_SATA	0x008e


diff -uprN -X dontdiff linux-2.4.27-pre2/drivers/ide/pci/amd74xx.c
linux-2.4.27-pre2-nforce-ck804-ide/drivers/ide/pci/amd74xx.c
--- linux-2.4.27-pre2/drivers/ide/pci/amd74xx.c	2004-04-14
06:05:29.000000000 -0700
+++ linux-2.4.27-pre2-nforce-ck804-ide/drivers/ide/pci/amd74xx.c
2004-05-17 13:27:31.000000000 -0700
@@ -1,7 +1,8 @@
 /*
  * Version 2.13
  *
- * AMD 755/756/766/8111 and nVidia nForce/2/2s/3/3s IDE driver for
Linux.
+ * AMD 755/756/766/8111 and nVidia nForce/2/2s/3/3s/CK804/MCP04
+ * IDE driver for Linux.
  *
  * Copyright (c) 2000-2002 Vojtech Pavlik
  *
@@ -68,6 +69,12 @@ static struct amd_ide_chip {
 	{ PCI_DEVICE_ID_NVIDIA_NFORCE3S_IDE,	0x50, AMD_UDMA_133 },
 	{ PCI_DEVICE_ID_NVIDIA_NFORCE3S_SATA,	0x50, AMD_UDMA_133 },
 	{ PCI_DEVICE_ID_NVIDIA_NFORCE3S_SATA2,	0x50, AMD_UDMA_133 },
+	{ PCI_DEVICE_ID_NVIDIA_NFORCE_CK804_IDE,	0x50,
AMD_UDMA_133 },
+	{ PCI_DEVICE_ID_NVIDIA_NFORCE_CK804_SATA,	0x50,
AMD_UDMA_133 },
+	{ PCI_DEVICE_ID_NVIDIA_NFORCE_CK804_SATA2,	0x50,
AMD_UDMA_133 },
+	{ PCI_DEVICE_ID_NVIDIA_NFORCE_MCP04_IDE,	0x50,
AMD_UDMA_133 },
+	{ PCI_DEVICE_ID_NVIDIA_NFORCE_MCP04_SATA,	0x50,
AMD_UDMA_133 },
+	{ PCI_DEVICE_ID_NVIDIA_NFORCE_MCP04_SATA2,	0x50,
AMD_UDMA_133 },
 	{ 0 }
 };
 
@@ -464,6 +471,12 @@ static struct pci_device_id amd74xx_pci_
 	{ PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_NFORCE3S_IDE,
PCI_ANY_ID, PCI_ANY_ID, 0, 0, 10 },
 	{ PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_NFORCE3S_SATA,
PCI_ANY_ID, PCI_ANY_ID, 0, 0, 11 },
 	{ PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_NFORCE3S_SATA2,
PCI_ANY_ID, PCI_ANY_ID, 0, 0, 12 },
+	{ PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_NFORCE_CK804_IDE,
PCI_ANY_ID, PCI_ANY_ID, 0, 0, 13 },
+	{ PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_NFORCE_CK804_SATA,
PCI_ANY_ID, PCI_ANY_ID, 0, 0, 14 },
+	{ PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_NFORCE_CK804_SATA2,
PCI_ANY_ID, PCI_ANY_ID, 0, 0, 15 },
+	{ PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_NFORCE_MCP04_IDE,
PCI_ANY_ID, PCI_ANY_ID, 0, 0, 16 },
+	{ PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_NFORCE_MCP04_SATA,
PCI_ANY_ID, PCI_ANY_ID, 0, 0, 17 },
+	{ PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_NFORCE_MCP04_SATA2,

+PCI_ANY_ID, PCI_ANY_ID, 0, 0, 18 },
 	{ 0, },
 };
 
diff -uprN -X dontdiff linux-2.4.27-pre2/drivers/ide/pci/amd74xx.h
linux-2.4.27-pre2-nforce-ck804-ide/drivers/ide/pci/amd74xx.h
--- linux-2.4.27-pre2/drivers/ide/pci/amd74xx.h	2004-04-14
06:05:29.000000000 -0700
+++ linux-2.4.27-pre2-nforce-ck804-ide/drivers/ide/pci/amd74xx.h
2004-05-17 12:08:04.000000000 -0700
@@ -112,7 +112,7 @@ static ide_pci_device_t amd74xx_chipsets
 	{	/* 7 */
 		.vendor		= PCI_VENDOR_ID_NVIDIA,
 		.device		= PCI_DEVICE_ID_NVIDIA_NFORCE2S_IDE,
-		.name		= "NFORCE2S",
+		.name		= "NFORCE2-U400R",
 		.init_chipset	= init_chipset_amd74xx,
 		.init_hwif	= init_hwif_amd74xx,
 		.channels	= 2,
@@ -123,7 +123,7 @@ static ide_pci_device_t amd74xx_chipsets
 	{	/* 8 */
 		.vendor		= PCI_VENDOR_ID_NVIDIA,
 		.device		= PCI_DEVICE_ID_NVIDIA_NFORCE2S_SATA,
-		.name		= "NFORCE2S-SATA",
+		.name		= "NFORCE2-U400R-SATA",
 		.init_chipset	= init_chipset_amd74xx,
 		.init_hwif	= init_hwif_amd74xx,
 		.channels	= 2,
@@ -134,7 +134,7 @@ static ide_pci_device_t amd74xx_chipsets
 	{	/* 9 */
 		.vendor		= PCI_VENDOR_ID_NVIDIA,
 		.device		= PCI_DEVICE_ID_NVIDIA_NFORCE3_IDE,
-		.name		= "NFORCE3",
+		.name		= "NFORCE3-150",
 		.init_chipset	= init_chipset_amd74xx,
 		.init_hwif	= init_hwif_amd74xx,
 		.channels	= 2,
@@ -145,7 +145,7 @@ static ide_pci_device_t amd74xx_chipsets
 	{	/* 10 */
 		.vendor		= PCI_VENDOR_ID_NVIDIA,
 		.device		= PCI_DEVICE_ID_NVIDIA_NFORCE3S_IDE,
-		.name		= "NFORCE3S",
+		.name		= "NFORCE3-250",
 		.init_chipset	= init_chipset_amd74xx,
 		.init_hwif	= init_hwif_amd74xx,
 		.channels	= 2,
@@ -156,7 +156,7 @@ static ide_pci_device_t amd74xx_chipsets
 	{	/* 11 */
 		.vendor		= PCI_VENDOR_ID_NVIDIA,
 		.device		= PCI_DEVICE_ID_NVIDIA_NFORCE3S_SATA,
-		.name		= "NFORCE3S-SATA",
+		.name		= "NFORCE3-250-SATA",
 		.init_chipset	= init_chipset_amd74xx,
 		.init_hwif	= init_hwif_amd74xx,
 		.channels	= 2,
@@ -167,7 +167,73 @@ static ide_pci_device_t amd74xx_chipsets
 	{	/* 12 */
 		.vendor		= PCI_VENDOR_ID_NVIDIA,
 		.device		= PCI_DEVICE_ID_NVIDIA_NFORCE3S_SATA2,
-		.name		= "NFORCE3S-SATA2",
+		.name		= "NFORCE3-250-SATA2",
+		.init_chipset	= init_chipset_amd74xx,
+		.init_hwif	= init_hwif_amd74xx,
+		.channels	= 2,
+		.autodma	= AUTODMA,
+		.enablebits	= {{0x50,0x02,0x02}, {0x50,0x01,0x01}},
+		.bootable	= ON_BOARD,
+	},
+	{	/* 13 */
+		.vendor		= PCI_VENDOR_ID_NVIDIA,
+		.device		= PCI_DEVICE_ID_NVIDIA_NFORCE_CK804_IDE,
+		.name		= "NFORCE-CK804",
+		.init_chipset	= init_chipset_amd74xx,
+		.init_hwif	= init_hwif_amd74xx,
+		.channels	= 2,
+		.autodma	= AUTODMA,
+		.enablebits	= {{0x50,0x02,0x02}, {0x50,0x01,0x01}},
+		.bootable	= ON_BOARD,
+	},
+	{	/* 14 */
+		.vendor		= PCI_VENDOR_ID_NVIDIA,
+		.device		=
PCI_DEVICE_ID_NVIDIA_NFORCE_CK804_SATA,
+		.name		= "NFORCE-CK804-SATA",
+		.init_chipset	= init_chipset_amd74xx,
+		.init_hwif	= init_hwif_amd74xx,
+		.channels	= 2,
+		.autodma	= AUTODMA,
+		.enablebits	= {{0x50,0x02,0x02}, {0x50,0x01,0x01}},
+		.bootable	= ON_BOARD,
+	},
+	{	/* 15 */
+		.vendor		= PCI_VENDOR_ID_NVIDIA,
+		.device		=
PCI_DEVICE_ID_NVIDIA_NFORCE_CK804_SATA2,
+		.name		= "NFORCE-CK804-SATA2",
+		.init_chipset	= init_chipset_amd74xx,
+		.init_hwif	= init_hwif_amd74xx,
+		.channels	= 2,
+		.autodma	= AUTODMA,
+		.enablebits	= {{0x50,0x02,0x02}, {0x50,0x01,0x01}},
+		.bootable	= ON_BOARD,
+	},
+	{	/* 16 */
+		.vendor		= PCI_VENDOR_ID_NVIDIA,
+		.device		= PCI_DEVICE_ID_NVIDIA_NFORCE_MCP04_IDE,
+		.name		= "NFORCE-MCP04",
+		.init_chipset	= init_chipset_amd74xx,
+		.init_hwif	= init_hwif_amd74xx,
+		.channels	= 2,
+		.autodma	= AUTODMA,
+		.enablebits	= {{0x50,0x02,0x02}, {0x50,0x01,0x01}},
+		.bootable	= ON_BOARD,
+	},
+	{	/* 17 */
+		.vendor		= PCI_VENDOR_ID_NVIDIA,
+		.device		=
PCI_DEVICE_ID_NVIDIA_NFORCE_MCP04_SATA,
+		.name		= "NFORCE-MCP04-SATA",
+		.init_chipset	= init_chipset_amd74xx,
+		.init_hwif	= init_hwif_amd74xx,
+		.channels	= 2,
+		.autodma	= AUTODMA,
+		.enablebits	= {{0x50,0x02,0x02}, {0x50,0x01,0x01}},
+		.bootable	= ON_BOARD,
+	},
+	{	/* 18 */
+		.vendor		= PCI_VENDOR_ID_NVIDIA,
+		.device		=
PCI_DEVICE_ID_NVIDIA_NFORCE_MCP04_SATA2,
+		.name		= "NFORCE-MCP04-SATA2",
 		.init_chipset	= init_chipset_amd74xx,
 		.init_hwif	= init_hwif_amd74xx,
 		.channels	= 2,
diff -uprN -X dontdiff linux-2.4.27-pre2/include/linux/pci_ids.h
linux-2.4.27-pre2-nforce-ck804-ide/include/linux/pci_ids.h
--- linux-2.4.27-pre2/include/linux/pci_ids.h	2004-05-17
11:46:29.000000000 -0700
+++ linux-2.4.27-pre2-nforce-ck804-ide/include/linux/pci_ids.h
2004-05-17 12:04:30.000000000 -0700
@@ -977,6 +977,12 @@
 #define PCI_DEVICE_ID_NVIDIA_UTNT2		0x0029
 #define PCI_DEVICE_ID_NVIDIA_VTNT2		0x002C
 #define PCI_DEVICE_ID_NVIDIA_UVTNT2		0x002D
+#define PCI_DEVICE_ID_NVIDIA_NFORCE_MCP04_IDE	0x0035
+#define PCI_DEVICE_ID_NVIDIA_NFORCE_MCP04_SATA	0x0036
+#define PCI_DEVICE_ID_NVIDIA_NFORCE_MCP04_SATA2	0x003e
+#define PCI_DEVICE_ID_NVIDIA_NFORCE_CK804_IDE	0x0053
+#define PCI_DEVICE_ID_NVIDIA_NFORCE_CK804_SATA	0x0054
+#define PCI_DEVICE_ID_NVIDIA_NFORCE_CK804_SATA2	0x0055
 #define PCI_DEVICE_ID_NVIDIA_NFORCE2_IDE	0x0065
 #define PCI_DEVICE_ID_NVIDIA_NFORCE2S_IDE	0x0085
 #define PCI_DEVICE_ID_NVIDIA_NFORCE2S_SATA	0x008e



> -----Original Message-----
> From: Jeff Garzik [mailto:jgarzik@pobox.com]
> Sent: Thursday, May 27, 2004 12:38 PM
> To: Brian Lazara
> Cc: linux-kernel@vger.kernel.org; linux-ide@vger.kernel.org; 
> Bartlomiej Zolnierkiewicz
> Subject: Re: [PATCH] add new nForce IDE/SATA device IDs
> 
> 
> Brian Lazara wrote:
> > Patches to add device IDs for new nForce IDE and SATA controllers.
> > Rename some of the existing controller names to correctly match 
> > released product names.
> > 
> > Patches against 2.4.27-pre2 and 2.6.6
> 
> It is difficult to review patches that look like the following...
> please include the patches include, or attach them as plaintext.
> 
> Three other comments:
> 
> 1) please CC linux-ide@vger.kernel.org on all IDE/SATA-related patches
> 2) Please To: or CC: Bartlomiej (cc'd on this email) on all
> drivers/ide 
> patches, as he is the IDE maintainer.
> 3) Normally we want to add SATA support to libata not 
> drivers/ide.  Do 
> the nVidia SATA chips support SATA SCRs or anything like 
> that?  Why not 
> use libata?
> 
