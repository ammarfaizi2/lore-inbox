Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265797AbSKKQSS>; Mon, 11 Nov 2002 11:18:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265798AbSKKQSS>; Mon, 11 Nov 2002 11:18:18 -0500
Received: from covert.black-ring.iadfw.net ([209.196.123.142]:6917 "EHLO
	covert.iadfw.net") by vger.kernel.org with ESMTP id <S265797AbSKKQRj>;
	Mon, 11 Nov 2002 11:17:39 -0500
Date: Mon, 11 Nov 2002 09:57:47 -0600
From: Art Haas <ahaas@airmail.net>
To: linux-kernel@vger.kernel.org
Cc: Linus Torvalds <torvalds@transmeta.com>
Subject: [PATCH] C99 designated initializers for drivers/ide/pci (1 of 2)
Message-ID: <20021111155747.GJ20969@debian>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

Here's the first of two patches that switch the header files in
drivers/ide/pci to use C99 designated initializers. The patch is
against 2.5.47.

This mail holds patches for drivers starting with the letters [a-n].

Art Haas

--- linux-2.5.47/drivers/ide/pci/adma100.h.old	2002-10-07 15:45:28.000000000 -0500
+++ linux-2.5.47/drivers/ide/pci/adma100.h	2002-11-11 07:22:06.000000000 -0600
@@ -12,24 +12,24 @@
 
 static ide_pci_device_t pdcadma_chipsets[] __devinitdata = {
 	{
-		vendor:	PCI_VENDOR_ID_PDC,
-		device:	PCI_DEVICE_ID_PDC_1841,
-		name:		"ADMA100",
-		init_setup:	init_setup_pdcadma,
-		init_chipset:	init_chipset_pdcadma,
-		init_iops:	NULL,
-		init_hwif:	init_hwif_pdcadma,
-		init_dma:	init_dma_pdcadma,
-		channels:	2,
-		autodma:	NODMA,
-		enablebits:	{{0x00,0x00,0x00}, {0x00,0x00,0x00}},
-		bootable:	OFF_BOARD,
-		extra:		0
+		.vendor		= PCI_VENDOR_ID_PDC,
+		.device		= PCI_DEVICE_ID_PDC_1841,
+		.name		= "ADMA100",
+		.init_setup	= init_setup_pdcadma,
+		.init_chipset	= init_chipset_pdcadma,
+		.init_iops	= NULL,
+		.init_hwif	= init_hwif_pdcadma,
+		.init_dma	= init_dma_pdcadma,
+		.channels	= 2,
+		.autodma	= NODMA,
+		.enablebits	= {{0x00,0x00,0x00}, {0x00,0x00,0x00}},
+		.bootable	= OFF_BOARD,
+		.extra		= 0
 	},{
-		vendor:		0,
-		device:		0,
-		channels:	0,
-		bootable:	EOL,
+		.vendor		= 0,
+		.device		= 0,
+		.channels	= 0,
+		.bootable	= EOL,
 	}
 }
 
--- linux-2.5.47/drivers/ide/pci/aec62xx.h.old	2002-10-07 15:45:28.000000000 -0500
+++ linux-2.5.47/drivers/ide/pci/aec62xx.h	2002-11-11 07:22:07.000000000 -0600
@@ -84,10 +84,10 @@
 
 static ide_pci_host_proc_t aec62xx_procs[] __initdata = {
 	{
-		name:		"aec62xx",
-		set:		1,
-		get_info:	aec62xx_get_info,
-		parent:		NULL,
+		.name		= "aec62xx",
+		.set		= 1,
+		.get_info	= aec62xx_get_info,
+		.parent		= NULL,
 	},
 };
 #endif /* DISPLAY_AEC62XX_TIMINGS && CONFIG_PROC_FS */
@@ -100,75 +100,75 @@
 
 static ide_pci_device_t aec62xx_chipsets[] __devinitdata = {
 	{	/* 0 */
-		vendor:		PCI_VENDOR_ID_ARTOP,
-		device:		PCI_DEVICE_ID_ARTOP_ATP850UF,
-		name:		"AEC6210",
-		init_setup:	init_setup_aec62xx,
-		init_chipset:	init_chipset_aec62xx,
-		init_iops:	NULL,
-		init_hwif:	init_hwif_aec62xx,
-		init_dma:	init_dma_aec62xx,
-		channels:	2,
-		autodma:	AUTODMA,
-		enablebits:	{{0x4a,0x02,0x02}, {0x4a,0x04,0x04}},
-		bootable:	OFF_BOARD,
-		extra:		0,
+		.vendor		= PCI_VENDOR_ID_ARTOP,
+		.device		= PCI_DEVICE_ID_ARTOP_ATP850UF,
+		.name		= "AEC6210",
+		.init_setup	= init_setup_aec62xx,
+		.init_chipset	= init_chipset_aec62xx,
+		.init_iops	= NULL,
+		.init_hwif	= init_hwif_aec62xx,
+		.init_dma	= init_dma_aec62xx,
+		.channels	= 2,
+		.autodma	= AUTODMA,
+		.enablebits	= {{0x4a,0x02,0x02}, {0x4a,0x04,0x04}},
+		.bootable	= OFF_BOARD,
+		.extra		= 0,
 	},{	/* 1 */
-		vendor:		PCI_VENDOR_ID_ARTOP,
-		device:		PCI_DEVICE_ID_ARTOP_ATP860,
-		name:		"AEC6260",
-		init_setup:	init_setup_aec62xx,
-		init_chipset:	init_chipset_aec62xx,
-		init_iops:	NULL,
-		init_hwif:	init_hwif_aec62xx,
-		init_dma:	init_dma_aec62xx,
-		channels:	2,
-		autodma:	NOAUTODMA,
-		enablebits:	{{0x00,0x00,0x00}, {0x00,0x00,0x00}},
-		bootable:	OFF_BOARD,
-		extra:		0,
+		.vendor		= PCI_VENDOR_ID_ARTOP,
+		.device		= PCI_DEVICE_ID_ARTOP_ATP860,
+		.name		= "AEC6260",
+		.init_setup	= init_setup_aec62xx,
+		.init_chipset	= init_chipset_aec62xx,
+		.init_iops	= NULL,
+		.init_hwif	= init_hwif_aec62xx,
+		.init_dma	= init_dma_aec62xx,
+		.channels	= 2,
+		.autodma	= NOAUTODMA,
+		.enablebits	= {{0x00,0x00,0x00}, {0x00,0x00,0x00}},
+		.bootable	= OFF_BOARD,
+		.extra		= 0,
 	},{	/* 2 */
-		vendor:		PCI_VENDOR_ID_ARTOP,
-		device:		PCI_DEVICE_ID_ARTOP_ATP860R,
-		name:		"AEC6260R",
-		init_setup:	init_setup_aec62xx,
-		init_chipset:	init_chipset_aec62xx,
-		init_iops:	NULL,
-		init_hwif:	init_hwif_aec62xx,
-		init_dma:	init_dma_aec62xx,
-		channels:	2,
-		autodma:	AUTODMA,
-		enablebits:	{{0x4a,0x02,0x02}, {0x4a,0x04,0x04}},
-		bootable:	NEVER_BOARD,
-		extra:		0,
+		.vendor		= PCI_VENDOR_ID_ARTOP,
+		.device		= PCI_DEVICE_ID_ARTOP_ATP860R,
+		.name		= "AEC6260R",
+		.init_setup	= init_setup_aec62xx,
+		.init_chipset	= init_chipset_aec62xx,
+		.init_iops	= NULL,
+		.init_hwif	= init_hwif_aec62xx,
+		.init_dma	= init_dma_aec62xx,
+		.channels	= 2,
+		.autodma	= AUTODMA,
+		.enablebits	= {{0x4a,0x02,0x02}, {0x4a,0x04,0x04}},
+		.bootable	= NEVER_BOARD,
+		.extra		= 0,
 	},{	/* 3 */
-		vendor:		PCI_VENDOR_ID_ARTOP,
-		device:		PCI_DEVICE_ID_ARTOP_ATP865,
-		name:		"AEC6X80",
-		init_setup:	init_setup_aec6x80,
-		init_chipset:	init_chipset_aec62xx,
-		init_iops:	NULL,
-		init_hwif:	init_hwif_aec62xx,
-		init_dma:	init_dma_aec62xx,
-		channels:	2,
-		autodma:	AUTODMA,
-		enablebits:	{{0x00,0x00,0x00}, {0x00,0x00,0x00}},
-		bootable:	OFF_BOARD,
-		extra:		0,
+		.vendor		= PCI_VENDOR_ID_ARTOP,
+		.device		= PCI_DEVICE_ID_ARTOP_ATP865,
+		.name		= "AEC6X80",
+		.init_setup	= init_setup_aec6x80,
+		.init_chipset	= init_chipset_aec62xx,
+		.init_iops	= NULL,
+		.init_hwif	= init_hwif_aec62xx,
+		.init_dma	= init_dma_aec62xx,
+		.channels	= 2,
+		.autodma	= AUTODMA,
+		.enablebits	= {{0x00,0x00,0x00}, {0x00,0x00,0x00}},
+		.bootable	= OFF_BOARD,
+		.extra		= 0,
 	},{	/* 4 */
-		vendor:		PCI_VENDOR_ID_ARTOP,
-		device:		PCI_DEVICE_ID_ARTOP_ATP865R,
-		name:		"AEC6X80R",
-		init_setup:	init_setup_aec6x80,
-		init_chipset:	init_chipset_aec62xx,
-		init_iops:	NULL,
-		init_hwif:	init_hwif_aec62xx,
-		init_dma:	init_dma_aec62xx,
-		channels:	2,
-		autodma:	AUTODMA,
-		enablebits:	{{0x4a,0x02,0x02}, {0x4a,0x04,0x04}},
-		bootable:	OFF_BOARD,
-		extra:		0,
+		.vendor		= PCI_VENDOR_ID_ARTOP,
+		.device		= PCI_DEVICE_ID_ARTOP_ATP865R,
+		.name		= "AEC6X80R",
+		.init_setup	= init_setup_aec6x80,
+		.init_chipset	= init_chipset_aec62xx,
+		.init_iops	= NULL,
+		.init_hwif	= init_hwif_aec62xx,
+		.init_dma	= init_dma_aec62xx,
+		.channels	= 2,
+		.autodma	= AUTODMA,
+		.enablebits	= {{0x4a,0x02,0x02}, {0x4a,0x04,0x04}},
+		.bootable	= OFF_BOARD,
+		.extra		= 0,
 	}
 };
 
--- linux-2.5.47/drivers/ide/pci/alim15x3.h.old	2002-10-07 15:45:28.000000000 -0500
+++ linux-2.5.47/drivers/ide/pci/alim15x3.h	2002-11-11 07:22:06.000000000 -0600
@@ -17,10 +17,10 @@
 
 static ide_pci_host_proc_t ali_procs[] __initdata = {
 	{
-		name:		"ali",
-		set:		1,
-		get_info:	ali_get_info,
-		parent:		NULL,
+		.name		= "ali",
+		.set		= 1,
+		.get_info	= ali_get_info,
+		.parent		= NULL,
 	},
 };
 #endif /* DISPLAY_ALI_TIMINGS && CONFIG_PROC_FS */
@@ -32,23 +32,23 @@
 
 static ide_pci_device_t ali15x3_chipsets[] __devinitdata = {
 	{	/* 0 */
-		vendor:		PCI_VENDOR_ID_AL,
-		device:		PCI_DEVICE_ID_AL_M5229,
-		name:		"ALI15X3",
-		init_chipset:	init_chipset_ali15x3,
-		init_iops:	NULL,
-		init_hwif:	init_hwif_ali15x3,
-		init_dma:	init_dma_ali15x3,
-		channels:	2,
-		autodma:	AUTODMA,
-		enablebits:	{{0x00,0x00,0x00}, {0x00,0x00,0x00}},
-		bootable:	ON_BOARD,
-		extra:		0
+		.vendor		= PCI_VENDOR_ID_AL,
+		.device		= PCI_DEVICE_ID_AL_M5229,
+		.name		= "ALI15X3",
+		.init_chipset	= init_chipset_ali15x3,
+		.init_iops	= NULL,
+		.init_hwif	= init_hwif_ali15x3,
+		.init_dma	= init_dma_ali15x3,
+		.channels	= 2,
+		.autodma	= AUTODMA,
+		.enablebits	= {{0x00,0x00,0x00}, {0x00,0x00,0x00}},
+		.bootable	= ON_BOARD,
+		.extra		= 0
 	},{
-		vendor:		0,
-		device:		0,
-		channels:	0,
-		bootable:	EOL,
+		.vendor		= 0,
+		.device		= 0,
+		.channels	= 0,
+		.bootable	= EOL,
 	}
 };
 
--- linux-2.5.47/drivers/ide/pci/amd74xx.h.old	2002-10-07 15:45:28.000000000 -0500
+++ linux-2.5.47/drivers/ide/pci/amd74xx.h	2002-11-11 07:22:07.000000000 -0600
@@ -17,10 +17,10 @@
 
 static ide_pci_host_proc_t amd74xx_procs[] __initdata = {
 	{
-		name:		"amd74xx",
-		set:		1,
-		get_info:	amd74xx_get_info,
-		parent:		NULL,
+		.name		= "amd74xx",
+		.set		= 1,
+		.get_info	= amd74xx_get_info,
+		.parent		= NULL,
 	},
 };
 #endif  /* defined(DISPLAY_VIPER_TIMINGS) && defined(CONFIG_PROC_FS) */
@@ -31,75 +31,75 @@
 
 static ide_pci_device_t amd74xx_chipsets[] __devinitdata = {
 	{	/* 0 */
-		vendor:		PCI_VENDOR_ID_AMD,
-		device:		PCI_DEVICE_ID_AMD_COBRA_7401,
-		name:		"AMD7401",
-		init_chipset:	init_chipset_amd74xx,
-		init_iops:	NULL,
-		init_hwif:	init_hwif_amd74xx,
-		init_dma:	init_dma_amd74xx,
-		channels:	2,
-		autodma:	AUTODMA,
-		enablebits:	{{0x40,0x01,0x01}, {0x40,0x02,0x02}},
-		bootable:	ON_BOARD,
-		extra:		0
+		.vendor		= PCI_VENDOR_ID_AMD,
+		.device		= PCI_DEVICE_ID_AMD_COBRA_7401,
+		.name		= "AMD7401",
+		.init_chipset	= init_chipset_amd74xx,
+		.init_iops	= NULL,
+		.init_hwif	= init_hwif_amd74xx,
+		.init_dma	= init_dma_amd74xx,
+		.channels	= 2,
+		.autodma	= AUTODMA,
+		.enablebits	= {{0x40,0x01,0x01}, {0x40,0x02,0x02}},
+		.bootable	= ON_BOARD,
+		.extra		= 0
 	},{	/* 1 */
-		vendor:		PCI_VENDOR_ID_AMD,
-		device:		PCI_DEVICE_ID_AMD_VIPER_7409,
-		name:		"AMD7409",
-		init_chipset:	init_chipset_amd74xx,
-		init_iops:	NULL,
-		init_hwif:	init_hwif_amd74xx,
-		init_dma:	init_dma_amd74xx,
-		channels:	2,
-		autodma:	AUTODMA,
-		enablebits:	{{0x40,0x01,0x01}, {0x40,0x02,0x02}},
-		bootable:	ON_BOARD,
-		extra:		0
+		.vendor		= PCI_VENDOR_ID_AMD,
+		.device		= PCI_DEVICE_ID_AMD_VIPER_7409,
+		.name		= "AMD7409",
+		.init_chipset	= init_chipset_amd74xx,
+		.init_iops	= NULL,
+		.init_hwif	= init_hwif_amd74xx,
+		.init_dma	= init_dma_amd74xx,
+		.channels	= 2,
+		.autodma	= AUTODMA,
+		.enablebits	= {{0x40,0x01,0x01}, {0x40,0x02,0x02}},
+		.bootable	= ON_BOARD,
+		.extra		= 0
 	},{	/* 2 */
-		vendor:		PCI_VENDOR_ID_AMD,
-		device:		PCI_DEVICE_ID_AMD_VIPER_7411,
-		name:		"AMD7411",
-		init_chipset:	init_chipset_amd74xx,
-		init_iops:	NULL,
-		init_hwif:	init_hwif_amd74xx,
-		init_dma:	init_dma_amd74xx,
-		channels:	2,
-		autodma:	AUTODMA,
-		enablebits:	{{0x40,0x01,0x01}, {0x40,0x02,0x02}},
-		bootable:	ON_BOARD,
-		extra:		0
+		.vendor		= PCI_VENDOR_ID_AMD,
+		.device		= PCI_DEVICE_ID_AMD_VIPER_7411,
+		.name		= "AMD7411",
+		.init_chipset	= init_chipset_amd74xx,
+		.init_iops	= NULL,
+		.init_hwif	= init_hwif_amd74xx,
+		.init_dma	= init_dma_amd74xx,
+		.channels	= 2,
+		.autodma	= AUTODMA,
+		.enablebits	= {{0x40,0x01,0x01}, {0x40,0x02,0x02}},
+		.bootable	= ON_BOARD,
+		.extra		= 0
 	},{	/* 3 */
-		vendor:		PCI_VENDOR_ID_AMD,
-		device:		PCI_DEVICE_ID_AMD_OPUS_7441,
-		name:		"AMD7441",
-		init_chipset:	init_chipset_amd74xx,
-		init_iops:	NULL,
-		init_hwif:	init_hwif_amd74xx,
-		init_dma:	init_dma_amd74xx,
-		channels:	2,
-		autodma:	AUTODMA,
-		enablebits:	{{0x40,0x01,0x01}, {0x40,0x02,0x02}},
-		bootable:	ON_BOARD,
-		extra:		0
+		.vendor		= PCI_VENDOR_ID_AMD,
+		.device		= PCI_DEVICE_ID_AMD_OPUS_7441,
+		.name		= "AMD7441",
+		.init_chipset	= init_chipset_amd74xx,
+		.init_iops	= NULL,
+		.init_hwif	= init_hwif_amd74xx,
+		.init_dma	= init_dma_amd74xx,
+		.channels	= 2,
+		.autodma	= AUTODMA,
+		.enablebits	= {{0x40,0x01,0x01}, {0x40,0x02,0x02}},
+		.bootable	= ON_BOARD,
+		.extra		= 0
 	},{	/* 4 */
-		vendor:		PCI_VENDOR_ID_AMD,
-		device:		PCI_DEVICE_ID_AMD_8111_IDE,
-		name:		"AMD8111",
-		init_chipset:	init_chipset_amd74xx,
-		init_iops:	NULL,
-		init_hwif:	init_hwif_amd74xx,
-		init_dma:	init_dma_amd74xx,
-		autodma:	AUTODMA,
-		channels:	2,
-		enablebits:	{{0x40,0x01,0x01}, {0x40,0x02,0x02}},
-		bootable:	ON_BOARD,
-		extra:		0
+		.vendor		= PCI_VENDOR_ID_AMD,
+		.device		= PCI_DEVICE_ID_AMD_8111_IDE,
+		.name		= "AMD8111",
+		.init_chipset	= init_chipset_amd74xx,
+		.init_iops	= NULL,
+		.init_hwif	= init_hwif_amd74xx,
+		.init_dma	= init_dma_amd74xx,
+		.autodma	= AUTODMA,
+		.channels	= 2,
+		.enablebits	= {{0x40,0x01,0x01}, {0x40,0x02,0x02}},
+		.bootable	= ON_BOARD,
+		.extra		= 0
 	},{
-		vendor:		0,
-		device:		0,
-		channels:	0,
-		bootable:	EOL,
+		.vendor		= 0,
+		.device		= 0,
+		.channels	= 0,
+		.bootable	= EOL,
 	}
 };
 
--- linux-2.5.47/drivers/ide/pci/cmd640.h.old	2002-09-16 09:33:59.000000000 -0500
+++ linux-2.5.47/drivers/ide/pci/cmd640.h	2002-11-11 07:22:07.000000000 -0600
@@ -9,23 +9,23 @@
 
 static ide_pci_device_t cmd640_chipsets[] __initdata = {
 	{
-		vendor:		PCI_VENDOR_ID_CMD,
-		device:		PCI_DEVICE_ID_CMD_640,
-		name:		"CMD640",
-		init_setup:	NULL,
-		init_chipset:	NULL,
-		init_iops:	NULL,
-		init_hwif:	IDE_IGNORE,
-		init_dma:	NULL,
-		channels:	2,
-		autodma:	NODMA,
-		enablebits:	{{0x00,0x00,0x00}, {0x00,0x00,0x00}},
-		bootable:	ON_BOARD,
-		extra:		0
+		.vendor		= PCI_VENDOR_ID_CMD,
+		.device		= PCI_DEVICE_ID_CMD_640,
+		.name		= "CMD640",
+		.init_setup	= NULL,
+		.init_chipset	= NULL,
+		.init_iops	= NULL,
+		.init_hwif	= IDE_IGNORE,
+		.init_dma	= NULL,
+		.channels	= 2,
+		.autodma	= NODMA,
+		.enablebits	= {{0x00,0x00,0x00}, {0x00,0x00,0x00}},
+		.bootable	= ON_BOARD,
+		.extra		= 0
 	},{
-		vendor:		0,
-		device:		0,
-		bootable:	EOL,
+		.vendor		= 0,
+		.device		= 0,
+		.bootable	= EOL,
 	}
 }
 
--- linux-2.5.47/drivers/ide/pci/cmd64x.h.old	2002-10-07 15:45:28.000000000 -0500
+++ linux-2.5.47/drivers/ide/pci/cmd64x.h	2002-11-11 07:22:07.000000000 -0600
@@ -71,10 +71,10 @@
 
 static ide_pci_host_proc_t cmd64x_procs[] __initdata = {
 	{
-		name:		"cmd64x",
-		set:		1,
-		get_info:	cmd64x_get_info,
-		parent:		NULL,
+		.name		= "cmd64x",
+		.set		= 1,
+		.get_info	= cmd64x_get_info,
+		.parent		= NULL,
 	},
 };
 #endif  /* defined(DISPLAY_CMD64X_TIMINGS) && defined(CONFIG_PROC_FS) */
@@ -85,62 +85,62 @@
 
 static ide_pci_device_t cmd64x_chipsets[] __devinitdata = {
 	{	/* 0 */
-		vendor:		PCI_VENDOR_ID_CMD,
-		device:		PCI_DEVICE_ID_CMD_643,
-		name:		"CMD643",
-		init_chipset:	init_chipset_cmd64x,
-		init_iops:	NULL,
-		init_hwif:	init_hwif_cmd64x,
-		init_dma:	init_dma_cmd64x,
-		channels:	2,
-		autodma:	AUTODMA,
-		enablebits:	{{0x00,0x00,0x00}, {0x00,0x00,0x00}},
-		bootable:	ON_BOARD,
-		extra:		0,
+		.vendor		= PCI_VENDOR_ID_CMD,
+		.device		= PCI_DEVICE_ID_CMD_643,
+		.name		= "CMD643",
+		.init_chipset	= init_chipset_cmd64x,
+		.init_iops	= NULL,
+		.init_hwif	= init_hwif_cmd64x,
+		.init_dma	= init_dma_cmd64x,
+		.channels	= 2,
+		.autodma	= AUTODMA,
+		.enablebits	= {{0x00,0x00,0x00}, {0x00,0x00,0x00}},
+		.bootable	= ON_BOARD,
+		.extra		= 0,
 	},{	/* 1 */
-		vendor:		PCI_VENDOR_ID_CMD,
-		device:		PCI_DEVICE_ID_CMD_646,
-		name:		"CMD646",
-		init_chipset:	init_chipset_cmd64x,
-		init_iops:	NULL,
-		init_hwif:	init_hwif_cmd64x,
-		init_dma:	init_dma_cmd64x,
-		channels:	2,
-		autodma:	AUTODMA,
-		enablebits:	{{0x00,0x00,0x00}, {0x51,0x80,0x80}},
-		bootable:	ON_BOARD,
-		extra:		0,
+		.vendor		= PCI_VENDOR_ID_CMD,
+		.device		= PCI_DEVICE_ID_CMD_646,
+		.name		= "CMD646",
+		.init_chipset	= init_chipset_cmd64x,
+		.init_iops	= NULL,
+		.init_hwif	= init_hwif_cmd64x,
+		.init_dma	= init_dma_cmd64x,
+		.channels	= 2,
+		.autodma	= AUTODMA,
+		.enablebits	= {{0x00,0x00,0x00}, {0x51,0x80,0x80}},
+		.bootable	= ON_BOARD,
+		.extra		= 0,
 	},{	/* 2 */
-		vendor:		PCI_VENDOR_ID_CMD,
-		device:	PCI_DEVICE_ID_CMD_648,
-		name:		"CMD648",
-		init_chipset:	init_chipset_cmd64x,
-		init_iops:	NULL,
-		init_hwif:	init_hwif_cmd64x,
-		init_dma:	init_dma_cmd64x,
-		channels:	2,
-		autodma:	AUTODMA,
-		enablebits:	{{0x00,0x00,0x00}, {0x00,0x00,0x00}},
-		bootable:	ON_BOARD,
-		extra:		0,
+		.vendor		= PCI_VENDOR_ID_CMD,
+		.device	= PCI_DEVICE_ID_CMD_648,
+		.name		= "CMD648",
+		.init_chipset	= init_chipset_cmd64x,
+		.init_iops	= NULL,
+		.init_hwif	= init_hwif_cmd64x,
+		.init_dma	= init_dma_cmd64x,
+		.channels	= 2,
+		.autodma	= AUTODMA,
+		.enablebits	= {{0x00,0x00,0x00}, {0x00,0x00,0x00}},
+		.bootable	= ON_BOARD,
+		.extra		= 0,
 	},{
-		vendor:		PCI_VENDOR_ID_CMD,
-		device:		PCI_DEVICE_ID_CMD_649,
-		name:		"CMD649",
-		init_chipset:	init_chipset_cmd64x,
-		init_iops:	NULL,
-		init_hwif:	init_hwif_cmd64x,
-		init_dma:	init_dma_cmd64x,
-		channels:	2,
-		autodma:	AUTODMA,
-		enablebits:	{{0x00,0x00,0x00}, {0x00,0x00,0x00}},
-		bootable:	ON_BOARD,
-		extra:		0,
+		.vendor		= PCI_VENDOR_ID_CMD,
+		.device		= PCI_DEVICE_ID_CMD_649,
+		.name		= "CMD649",
+		.init_chipset	= init_chipset_cmd64x,
+		.init_iops	= NULL,
+		.init_hwif	= init_hwif_cmd64x,
+		.init_dma	= init_dma_cmd64x,
+		.channels	= 2,
+		.autodma	= AUTODMA,
+		.enablebits	= {{0x00,0x00,0x00}, {0x00,0x00,0x00}},
+		.bootable	= ON_BOARD,
+		.extra		= 0,
 	},{
-		vendor:		0,
-		device:		0,
-		channels:	2,
-		bootable:	EOL,
+		.vendor		= 0,
+		.device		= 0,
+		.channels	= 2,
+		.bootable	= EOL,
 	}
 };
 
--- linux-2.5.47/drivers/ide/pci/cs5530.h.old	2002-10-07 15:45:28.000000000 -0500
+++ linux-2.5.47/drivers/ide/pci/cs5530.h	2002-11-11 07:22:07.000000000 -0600
@@ -17,10 +17,10 @@
 
 static ide_pci_host_proc_t cs5530_procs[] __initdata = {
 	{
-		name:		"cs5530",
-		set:		1,
-		get_info:	cs5530_get_info,
-		parent:		NULL,
+		.name		= "cs5530",
+		.set		= 1,
+		.get_info	= cs5530_get_info,
+		.parent		= NULL,
 	},
 };
 #endif /* DISPLAY_CS5530_TIMINGS && CONFIG_PROC_FS */
@@ -31,23 +31,23 @@
 
 static ide_pci_device_t cs5530_chipsets[] __devinitdata = {
 	{	/* 0 */
-		vendor:		PCI_VENDOR_ID_CYRIX,
-		device:		PCI_DEVICE_ID_CYRIX_5530_IDE,
-		name:		"CS5530",
-		init_chipset:	init_chipset_cs5530,
-		init_iops:	NULL,
-		init_hwif:	init_hwif_cs5530,
-		init_dma:	init_dma_cs5530,
-		channels:	2,
-		autodma:	AUTODMA,
-		enablebits:	{{0x00,0x00,0x00}, {0x00,0x00,0x00}},
-		bootable:	ON_BOARD,
-		extra:		0,
+		.vendor		= PCI_VENDOR_ID_CYRIX,
+		.device		= PCI_DEVICE_ID_CYRIX_5530_IDE,
+		.name		= "CS5530",
+		.init_chipset	= init_chipset_cs5530,
+		.init_iops	= NULL,
+		.init_hwif	= init_hwif_cs5530,
+		.init_dma	= init_dma_cs5530,
+		.channels	= 2,
+		.autodma	= AUTODMA,
+		.enablebits	= {{0x00,0x00,0x00}, {0x00,0x00,0x00}},
+		.bootable	= ON_BOARD,
+		.extra		= 0,
 	},{
-		vendor:		0,
-		device:		0,
-		channels:	0,
-		bootable:	EOL,
+		.vendor		= 0,
+		.device		= 0,
+		.channels	= 0,
+		.bootable	= EOL,
 	}
 };
 
--- linux-2.5.47/drivers/ide/pci/cy82c693.h.old	2002-10-07 15:45:28.000000000 -0500
+++ linux-2.5.47/drivers/ide/pci/cy82c693.h	2002-11-11 07:22:07.000000000 -0600
@@ -70,23 +70,23 @@
 
 static ide_pci_device_t cy82c693_chipsets[] __devinitdata = {
 	{	/* 0 */
-		vendor:		PCI_VENDOR_ID_CONTAQ,
-		device:		PCI_DEVICE_ID_CONTAQ_82C693,
-		name:		"CY82C693",
-		init_chipset:	init_chipset_cy82c693,
-		init_iops:	init_iops_cy82c693,
-		init_hwif:	init_hwif_cy82c693,
-		init_dma:	NULL,
-		channels:	1,
-		autodma:	AUTODMA,
-		enablebits:	{{0x00,0x00,0x00}, {0x00,0x00,0x00}},
-		bootable:	ON_BOARD,
-		extra:		0,
+		.vendor		= PCI_VENDOR_ID_CONTAQ,
+		.device		= PCI_DEVICE_ID_CONTAQ_82C693,
+		.name		= "CY82C693",
+		.init_chipset	= init_chipset_cy82c693,
+		.init_iops	= init_iops_cy82c693,
+		.init_hwif	= init_hwif_cy82c693,
+		.init_dma	= NULL,
+		.channels	= 1,
+		.autodma	= AUTODMA,
+		.enablebits	= {{0x00,0x00,0x00}, {0x00,0x00,0x00}},
+		.bootable	= ON_BOARD,
+		.extra		= 0,
 	},{
-		vendor:		0,
-		device:		0,
-		channels:	0,
-		bootable:	EOL,
+		.vendor		= 0,
+		.device		= 0,
+		.channels	= 0,
+		.bootable	= EOL,
 	}
 };
 
--- linux-2.5.47/drivers/ide/pci/generic.h.old	2002-10-07 15:45:28.000000000 -0500
+++ linux-2.5.47/drivers/ide/pci/generic.h	2002-11-11 07:22:07.000000000 -0600
@@ -11,149 +11,149 @@
 
 static ide_pci_device_t generic_chipsets[] __devinitdata = {
 	{	/* 0 */
-		vendor:		PCI_VENDOR_ID_NS,
-		device:		PCI_DEVICE_ID_NS_87410,
-		name:		"NS87410",
-		init_chipset:	init_chipset_generic,
-		init_iops:	NULL,
-		init_hwif:	init_hwif_generic,
-		init_dma:	init_dma_generic,
-		channels:	2,
-		autodma:	AUTODMA,
-		enablebits:	{{0x43,0x08,0x08}, {0x47,0x08,0x08}},
-		bootable:	ON_BOARD,
-		extra:		0,
+		.vendor		= PCI_VENDOR_ID_NS,
+		.device		= PCI_DEVICE_ID_NS_87410,
+		.name		= "NS87410",
+		.init_chipset	= init_chipset_generic,
+		.init_iops	= NULL,
+		.init_hwif	= init_hwif_generic,
+		.init_dma	= init_dma_generic,
+		.channels	= 2,
+		.autodma	= AUTODMA,
+		.enablebits	= {{0x43,0x08,0x08}, {0x47,0x08,0x08}},
+		.bootable	= ON_BOARD,
+		.extra		= 0,
         },{	/* 1 */
-		vendor:		PCI_VENDOR_ID_PCTECH,
-		device:		PCI_DEVICE_ID_PCTECH_SAMURAI_IDE,
-		name:		"SAMURAI",
-		init_chipset:	init_chipset_generic,
-		init_iops:	NULL,
-		init_hwif:	init_hwif_generic,
-		init_dma:	init_dma_generic,
-		channels:	2,
-		autodma:	AUTODMA,
-		enablebits:	{{0x00,0x00,0x00}, {0x00,0x00,0x00}},
-		bootable:	ON_BOARD,
-		extra:		0,
+		.vendor		= PCI_VENDOR_ID_PCTECH,
+		.device		= PCI_DEVICE_ID_PCTECH_SAMURAI_IDE,
+		.name		= "SAMURAI",
+		.init_chipset	= init_chipset_generic,
+		.init_iops	= NULL,
+		.init_hwif	= init_hwif_generic,
+		.init_dma	= init_dma_generic,
+		.channels	= 2,
+		.autodma	= AUTODMA,
+		.enablebits	= {{0x00,0x00,0x00}, {0x00,0x00,0x00}},
+		.bootable	= ON_BOARD,
+		.extra		= 0,
 	},{	/* 2 */
-		vendor:		PCI_VENDOR_ID_HOLTEK,
-		device:		PCI_DEVICE_ID_HOLTEK_6565,
-		name:		"HT6565",
-		init_chipset:	init_chipset_generic,
-		init_iops:	NULL,
-		init_hwif:	init_hwif_generic,
-		init_dma:	init_dma_generic,
-		channels:	2,
-		autodma:	AUTODMA,
-		enablebits:	{{0x00,0x00,0x00}, {0x00,0x00,0x00}},
-		bootable:	ON_BOARD,
-		extra:		0,
+		.vendor		= PCI_VENDOR_ID_HOLTEK,
+		.device		= PCI_DEVICE_ID_HOLTEK_6565,
+		.name		= "HT6565",
+		.init_chipset	= init_chipset_generic,
+		.init_iops	= NULL,
+		.init_hwif	= init_hwif_generic,
+		.init_dma	= init_dma_generic,
+		.channels	= 2,
+		.autodma	= AUTODMA,
+		.enablebits	= {{0x00,0x00,0x00}, {0x00,0x00,0x00}},
+		.bootable	= ON_BOARD,
+		.extra		= 0,
 	},{	/* 3 */
-		vendor:		PCI_VENDOR_ID_UMC,
-		device:		PCI_DEVICE_ID_UMC_UM8673F,
-		name:		"UM8673F",
-		init_chipset:	init_chipset_generic,
-		init_iops:	NULL,
-		init_hwif:	init_hwif_generic,
-		init_dma:	init_dma_generic,
-		channels:	2,
-		autodma:	NODMA,
-		enablebits:	{{0x00,0x00,0x00}, {0x00,0x00,0x00}},
-		bootable:	ON_BOARD,
-		extra:		0,
+		.vendor		= PCI_VENDOR_ID_UMC,
+		.device		= PCI_DEVICE_ID_UMC_UM8673F,
+		.name		= "UM8673F",
+		.init_chipset	= init_chipset_generic,
+		.init_iops	= NULL,
+		.init_hwif	= init_hwif_generic,
+		.init_dma	= init_dma_generic,
+		.channels	= 2,
+		.autodma	= NODMA,
+		.enablebits	= {{0x00,0x00,0x00}, {0x00,0x00,0x00}},
+		.bootable	= ON_BOARD,
+		.extra		= 0,
 	},{	/* 4 */
-		vendor:		PCI_VENDOR_ID_UMC,
-		device:		PCI_DEVICE_ID_UMC_UM8886A,
-		name:		"UM8886A",
-		init_chipset:	init_chipset_generic,
-		init_iops:	NULL,
-		init_hwif:	init_hwif_generic,
-		init_dma:	init_dma_generic,
-		channels:	2,
-		autodma:	NODMA,
-		enablebits:	{{0x00,0x00,0x00}, {0x00,0x00,0x00}},
-		bootable:	ON_BOARD,
-		extra:		0,
+		.vendor		= PCI_VENDOR_ID_UMC,
+		.device		= PCI_DEVICE_ID_UMC_UM8886A,
+		.name		= "UM8886A",
+		.init_chipset	= init_chipset_generic,
+		.init_iops	= NULL,
+		.init_hwif	= init_hwif_generic,
+		.init_dma	= init_dma_generic,
+		.channels	= 2,
+		.autodma	= NODMA,
+		.enablebits	= {{0x00,0x00,0x00}, {0x00,0x00,0x00}},
+		.bootable	= ON_BOARD,
+		.extra		= 0,
 	},{	/* 5 */
-		vendor:		PCI_VENDOR_ID_UMC,
-		device:		PCI_DEVICE_ID_UMC_UM8886BF,
-		name:		"UM8886BF",
-		init_chipset:	init_chipset_generic,
-		init_iops:	NULL,
-		init_hwif:	init_hwif_generic,
-		init_dma:	init_dma_generic,
-		channels:	2,
-		autodma:	NODMA,
-		enablebits:	{{0x00,0x00,0x00}, {0x00,0x00,0x00}},
-		bootable:	ON_BOARD,
-		extra:		0,
+		.vendor		= PCI_VENDOR_ID_UMC,
+		.device		= PCI_DEVICE_ID_UMC_UM8886BF,
+		.name		= "UM8886BF",
+		.init_chipset	= init_chipset_generic,
+		.init_iops	= NULL,
+		.init_hwif	= init_hwif_generic,
+		.init_dma	= init_dma_generic,
+		.channels	= 2,
+		.autodma	= NODMA,
+		.enablebits	= {{0x00,0x00,0x00}, {0x00,0x00,0x00}},
+		.bootable	= ON_BOARD,
+		.extra		= 0,
 	},{	/* 6 */
-		vendor:		PCI_VENDOR_ID_HINT,
-		device:		PCI_DEVICE_ID_HINT_VXPROII_IDE,
-		name:		"HINT_IDE",
-		init_chipset:	init_chipset_generic,
-		init_iops:	NULL,
-		init_hwif:	init_hwif_generic,
-		init_dma:	init_dma_generic,
-		channels:	2,
-		autodma:	AUTODMA,
-		enablebits:	{{0x00,0x00,0x00}, {0x00,0x00,0x00}},
-		bootable:	ON_BOARD,
-		extra:		0,
+		.vendor		= PCI_VENDOR_ID_HINT,
+		.device		= PCI_DEVICE_ID_HINT_VXPROII_IDE,
+		.name		= "HINT_IDE",
+		.init_chipset	= init_chipset_generic,
+		.init_iops	= NULL,
+		.init_hwif	= init_hwif_generic,
+		.init_dma	= init_dma_generic,
+		.channels	= 2,
+		.autodma	= AUTODMA,
+		.enablebits	= {{0x00,0x00,0x00}, {0x00,0x00,0x00}},
+		.bootable	= ON_BOARD,
+		.extra		= 0,
 	},{	/* 7 */
-		vendor:		PCI_VENDOR_ID_VIA,
-		device:		PCI_DEVICE_ID_VIA_82C561,
-		name:		"VIA_IDE",
-		init_chipset:	init_chipset_generic,
-		init_iops:	NULL,
-		init_hwif:	init_hwif_generic,
-		init_dma:	init_dma_generic,
-		channels:	2,
-		autodma:	NOAUTODMA,
-		enablebits:	{{0x00,0x00,0x00}, {0x00,0x00,0x00}},
-		bootable:	ON_BOARD,
-		extra:		0,
+		.vendor		= PCI_VENDOR_ID_VIA,
+		.device		= PCI_DEVICE_ID_VIA_82C561,
+		.name		= "VIA_IDE",
+		.init_chipset	= init_chipset_generic,
+		.init_iops	= NULL,
+		.init_hwif	= init_hwif_generic,
+		.init_dma	= init_dma_generic,
+		.channels	= 2,
+		.autodma	= NOAUTODMA,
+		.enablebits	= {{0x00,0x00,0x00}, {0x00,0x00,0x00}},
+		.bootable	= ON_BOARD,
+		.extra		= 0,
 	},{	/* 8 */
-		vendor:		PCI_VENDOR_ID_OPTI,
-		device:		PCI_DEVICE_ID_OPTI_82C558,
-		name:		"OPTI621V",
-		init_chipset:	init_chipset_generic,
-		init_iops:	NULL,
-		init_hwif:	init_hwif_generic,
-		init_dma:	init_dma_generic,
-		channels:	2,
-		autodma:	NOAUTODMA,
-		enablebits:	{{0x00,0x00,0x00}, {0x00,0x00,0x00}},
-		bootable:	ON_BOARD,
-		extra:		0,
+		.vendor		= PCI_VENDOR_ID_OPTI,
+		.device		= PCI_DEVICE_ID_OPTI_82C558,
+		.name		= "OPTI621V",
+		.init_chipset	= init_chipset_generic,
+		.init_iops	= NULL,
+		.init_hwif	= init_hwif_generic,
+		.init_dma	= init_dma_generic,
+		.channels	= 2,
+		.autodma	= NOAUTODMA,
+		.enablebits	= {{0x00,0x00,0x00}, {0x00,0x00,0x00}},
+		.bootable	= ON_BOARD,
+		.extra		= 0,
 	},{
-		vendor:		0,
-		device:		0,
-		channels:	0,
-		bootable:	EOL,
+		.vendor		= 0,
+		.device		= 0,
+		.channels	= 0,
+		.bootable	= EOL,
 	}
 };
 
 static ide_pci_device_t unknown_chipset[] __devinitdata = {
 	{	/* 0 */
-		vendor:		0,
-		device:		0,
-		name:		"PCI_IDE",
-		init_chipset:	init_chipset_generic,
-		init_iops:	NULL,
-		init_hwif:	init_hwif_generic,
-		init_dma:	init_dma_generic,
-		channels:	2,
-		autodma:	AUTODMA,
-		enablebits:	{{0x00,0x00,0x00}, {0x00,0x00,0x00}},
-		bootable:	ON_BOARD,
-		extra:		0,
+		.vendor		= 0,
+		.device		= 0,
+		.name		= "PCI_IDE",
+		.init_chipset	= init_chipset_generic,
+		.init_iops	= NULL,
+		.init_hwif	= init_hwif_generic,
+		.init_dma	= init_dma_generic,
+		.channels	= 2,
+		.autodma	= AUTODMA,
+		.enablebits	= {{0x00,0x00,0x00}, {0x00,0x00,0x00}},
+		.bootable	= ON_BOARD,
+		.extra		= 0,
 	},{
-		vendor:		0,
-		device:		0,
-		channels:	0,
-		bootable:	EOL,
+		.vendor		= 0,
+		.device		= 0,
+		.channels	= 0,
+		.bootable	= EOL,
 	}
 
 };
--- linux-2.5.47/drivers/ide/pci/hpt34x.h.old	2002-10-07 15:45:28.000000000 -0500
+++ linux-2.5.47/drivers/ide/pci/hpt34x.h	2002-11-11 07:22:07.000000000 -0600
@@ -23,10 +23,10 @@
 
 static ide_pci_host_proc_t hpt34x_procs[] __initdata = {
 	{
-		name:		"hpt34x",
-		set:		1,
-		get_info:	hpt34x_get_info,
-		parent:		NULL,
+		.name		= "hpt34x",
+		.set		= 1,
+		.get_info	= hpt34x_get_info,
+		.parent		= NULL,
 	},
 };
 #endif  /* defined(DISPLAY_HPT34X_TIMINGS) && defined(CONFIG_PROC_FS) */
@@ -37,23 +37,23 @@
 
 static ide_pci_device_t hpt34x_chipsets[] __devinitdata = {
 	{	/* 0 */
-		vendor:		PCI_VENDOR_ID_TTI,
-		device:		PCI_DEVICE_ID_TTI_HPT343,
-		name:		"HPT34X",
-		init_chipset:	init_chipset_hpt34x,
-		init_iops:	NULL,
-		init_hwif:	init_hwif_hpt34x,
-		init_dma:	init_dma_hpt34x,
-		channels:	2,
-		autodma:	NOAUTODMA,
-		enablebits:	{{0x00,0x00,0x00}, {0x00,0x00,0x00}},
-		bootable:	NEVER_BOARD,
-		extra:		16
+		.vendor		= PCI_VENDOR_ID_TTI,
+		.device		= PCI_DEVICE_ID_TTI_HPT343,
+		.name		= "HPT34X",
+		.init_chipset	= init_chipset_hpt34x,
+		.init_iops	= NULL,
+		.init_hwif	= init_hwif_hpt34x,
+		.init_dma	= init_dma_hpt34x,
+		.channels	= 2,
+		.autodma	= NOAUTODMA,
+		.enablebits	= {{0x00,0x00,0x00}, {0x00,0x00,0x00}},
+		.bootable	= NEVER_BOARD,
+		.extra		= 16
 	},{
-		vendor:		0,
-		device:		0,
-		channels:	0,
-		bootable:	EOL,
+		.vendor		= 0,
+		.device		= 0,
+		.channels	= 0,
+		.bootable	= EOL,
 	}
 };
 
--- linux-2.5.47/drivers/ide/pci/hpt366.h.old	2002-10-07 15:45:28.000000000 -0500
+++ linux-2.5.47/drivers/ide/pci/hpt366.h	2002-11-11 07:22:07.000000000 -0600
@@ -426,10 +426,10 @@
 
 static ide_pci_host_proc_t hpt366_procs[] __initdata = {
 	{
-		name:		"hpt366",
-		set:		1,
-		get_info:	hpt366_get_info,
-		parent:		NULL,
+		.name		= "hpt366",
+		.set		= 1,
+		.get_info	= hpt366_get_info,
+		.parent		= NULL,
 	},
 };
 #endif  /* defined(DISPLAY_HPT366_TIMINGS) && defined(CONFIG_PROC_FS) */
@@ -443,80 +443,80 @@
 
 static ide_pci_device_t hpt366_chipsets[] __devinitdata = {
 	{	/* 0 */
-		vendor:		PCI_VENDOR_ID_TTI,
-		device:		PCI_DEVICE_ID_TTI_HPT366,
-		name:		"HPT366",
-		init_setup:	init_setup_hpt366,
-		init_chipset:	init_chipset_hpt366,
-		init_iops:	NULL,
-		init_hwif:	init_hwif_hpt366,
-		init_dma:	init_dma_hpt366,
-		channels:	2,
-		autodma:	AUTODMA,
-		enablebits:	{{0x00,0x00,0x00}, {0x00,0x00,0x00}},
-		bootable:	OFF_BOARD,
-		extra:		240
+		.vendor		= PCI_VENDOR_ID_TTI,
+		.device		= PCI_DEVICE_ID_TTI_HPT366,
+		.name		= "HPT366",
+		.init_setup	= init_setup_hpt366,
+		.init_chipset	= init_chipset_hpt366,
+		.init_iops	= NULL,
+		.init_hwif	= init_hwif_hpt366,
+		.init_dma	= init_dma_hpt366,
+		.channels	= 2,
+		.autodma	= AUTODMA,
+		.enablebits	= {{0x00,0x00,0x00}, {0x00,0x00,0x00}},
+		.bootable	= OFF_BOARD,
+		.extra		= 240
 	},{	/* 1 */
-		vendor:		PCI_VENDOR_ID_TTI,
-		device:		PCI_DEVICE_ID_TTI_HPT372,
-		name:		"HPT372A",
-		init_setup:	init_setup_hpt37x,
-		init_chipset:	init_chipset_hpt366,
-		init_iops:	NULL,
-		init_hwif:	init_hwif_hpt366,
-		init_dma:	init_dma_hpt366,
-		channels:	2,
-		autodma:	AUTODMA,
-		enablebits:	{{0x00,0x00,0x00}, {0x00,0x00,0x00}},
-		bootable:	OFF_BOARD,
-		extra:		0
+		.vendor		= PCI_VENDOR_ID_TTI,
+		.device		= PCI_DEVICE_ID_TTI_HPT372,
+		.name		= "HPT372A",
+		.init_setup	= init_setup_hpt37x,
+		.init_chipset	= init_chipset_hpt366,
+		.init_iops	= NULL,
+		.init_hwif	= init_hwif_hpt366,
+		.init_dma	= init_dma_hpt366,
+		.channels	= 2,
+		.autodma	= AUTODMA,
+		.enablebits	= {{0x00,0x00,0x00}, {0x00,0x00,0x00}},
+		.bootable	= OFF_BOARD,
+		.extra		= 0
 	},{	/* 2 */
-		vendor:		PCI_VENDOR_ID_TTI,
-		device:		PCI_DEVICE_ID_TTI_HPT302,
-		name:		"HPT302",
-		init_setup:	init_setup_hpt37x,
-		init_chipset:	init_chipset_hpt366,
-		init_iops:	NULL,
-		init_hwif:	init_hwif_hpt366,
-		init_dma:	init_dma_hpt366,
-		channels:	2,
-		autodma:	AUTODMA,
-		enablebits:	{{0x00,0x00,0x00}, {0x00,0x00,0x00}},
-		bootable:	OFF_BOARD,
-		extra:		0
+		.vendor		= PCI_VENDOR_ID_TTI,
+		.device		= PCI_DEVICE_ID_TTI_HPT302,
+		.name		= "HPT302",
+		.init_setup	= init_setup_hpt37x,
+		.init_chipset	= init_chipset_hpt366,
+		.init_iops	= NULL,
+		.init_hwif	= init_hwif_hpt366,
+		.init_dma	= init_dma_hpt366,
+		.channels	= 2,
+		.autodma	= AUTODMA,
+		.enablebits	= {{0x00,0x00,0x00}, {0x00,0x00,0x00}},
+		.bootable	= OFF_BOARD,
+		.extra		= 0
 	},{	/* 3 */
-		vendor:		PCI_VENDOR_ID_TTI,
-		device:		PCI_DEVICE_ID_TTI_HPT371,
-		name:		"HPT371",
-		init_setup:	init_setup_hpt37x,
-		init_chipset:	init_chipset_hpt366,
-		init_iops:	NULL,
-		init_hwif:	init_hwif_hpt366,
-		init_dma:	init_dma_hpt366,
-		channels:	2,
-		autodma:	AUTODMA,
-		enablebits:	{{0x00,0x00,0x00}, {0x00,0x00,0x00}},
-		bootable:	OFF_BOARD,
-		extra:		0
+		.vendor		= PCI_VENDOR_ID_TTI,
+		.device		= PCI_DEVICE_ID_TTI_HPT371,
+		.name		= "HPT371",
+		.init_setup	= init_setup_hpt37x,
+		.init_chipset	= init_chipset_hpt366,
+		.init_iops	= NULL,
+		.init_hwif	= init_hwif_hpt366,
+		.init_dma	= init_dma_hpt366,
+		.channels	= 2,
+		.autodma	= AUTODMA,
+		.enablebits	= {{0x00,0x00,0x00}, {0x00,0x00,0x00}},
+		.bootable	= OFF_BOARD,
+		.extra		= 0
 	},{	/* 4 */
-		vendor:		PCI_VENDOR_ID_TTI,
-		device:		PCI_DEVICE_ID_TTI_HPT374,
-		name:		"HPT374",
-		init_setup:	init_setup_hpt374,
-		init_chipset:	init_chipset_hpt366,
-		init_iops:	NULL,
-		init_hwif:	init_hwif_hpt366,
-		init_dma:	init_dma_hpt366,
-		channels:	2,	/* 4 */
-		autodma:	AUTODMA,
-		enablebits:	{{0x00,0x00,0x00}, {0x00,0x00,0x00}},
-		bootable:	OFF_BOARD,
-		extra:		0
+		.vendor		= PCI_VENDOR_ID_TTI,
+		.device		= PCI_DEVICE_ID_TTI_HPT374,
+		.name		= "HPT374",
+		.init_setup	= init_setup_hpt374,
+		.init_chipset	= init_chipset_hpt366,
+		.init_iops	= NULL,
+		.init_hwif	= init_hwif_hpt366,
+		.init_dma	= init_dma_hpt366,
+		.channels	= 2,	/* 4 */
+		.autodma	= AUTODMA,
+		.enablebits	= {{0x00,0x00,0x00}, {0x00,0x00,0x00}},
+		.bootable	= OFF_BOARD,
+		.extra		= 0
 	},{
-		vendor:		0,
-		device:		0,
-		channels:	0,
-		bootable:	EOL,
+		.vendor		= 0,
+		.device		= 0,
+		.channels	= 0,
+		.bootable	= EOL,
 	}
 };
 
--- linux-2.5.47/drivers/ide/pci/it8172.h.old	2002-10-07 15:45:28.000000000 -0500
+++ linux-2.5.47/drivers/ide/pci/it8172.h	2002-11-11 07:22:07.000000000 -0600
@@ -21,24 +21,24 @@
 
 static ide_pci_device_t it8172_chipsets[] __devinitdata = {
 	{	/* 0 */
-		vendor:		PCI_VENDOR_ID_ITE,
-		device:		PCI_DEVICE_ID_ITE_IT8172G,
-		name:		"IT8172G",
-		init_setup:	init_setup_it8172,
-		init_chipset:	init_chipset_it8172,
-		init_iops:	NULL,
-		init_hwif:	init_hwif_it8172,
-                init_dma:	init_dma_it8172,
-		channels:	2,
-		autodma:	AUTODMA,
-		enablebits:	{{0x00,0x00,0x00}, {0x40,0x00,0x01}},
-		bootable:	ON_BOARD,
-		extra:		0,
+		.vendor		= PCI_VENDOR_ID_ITE,
+		.device		= PCI_DEVICE_ID_ITE_IT8172G,
+		.name		= "IT8172G",
+		.init_setup	= init_setup_it8172,
+		.init_chipset	= init_chipset_it8172,
+		.init_iops	= NULL,
+		.init_hwif	= init_hwif_it8172,
+                .init_dma	= init_dma_it8172,
+		.channels	= 2,
+		.autodma	= AUTODMA,
+		.enablebits	= {{0x00,0x00,0x00}, {0x40,0x00,0x01}},
+		.bootable	= ON_BOARD,
+		.extra		= 0,
 	},{
-		vendor:		0,
-		device:		0,
-		channels:	0,
-		bootable:	EOL,
+		.vendor		= 0,
+		.device		= 0,
+		.channels	= 0,
+		.bootable	= EOL,
 	}
 };
 
--- linux-2.5.47/drivers/ide/pci/ns87415.h.old	2002-10-07 15:45:28.000000000 -0500
+++ linux-2.5.47/drivers/ide/pci/ns87415.h	2002-11-11 07:22:07.000000000 -0600
@@ -10,23 +10,23 @@
 
 static ide_pci_device_t ns87415_chipsets[] __devinitdata = {
 	{	/* 0 */
-		vendor:		PCI_VENDOR_ID_NS,
-		device:		PCI_DEVICE_ID_NS_87415,
-		name:		"NS87415",
-		init_chipset:	NULL,
-		init_iops:	NULL,
-		init_hwif:	init_hwif_ns87415,
-                init_dma:	init_dma_ns87415,
-		channels:	2,
-		autodma:	AUTODMA,
-		enablebits:	{{0x00,0x00,0x00}, {0x00,0x00,0x00}},
-		bootable:	ON_BOARD,
-		extra:		0,
+		.vendor		= PCI_VENDOR_ID_NS,
+		.device		= PCI_DEVICE_ID_NS_87415,
+		.name		= "NS87415",
+		.init_chipset	= NULL,
+		.init_iops	= NULL,
+		.init_hwif	= init_hwif_ns87415,
+                .init_dma	= init_dma_ns87415,
+		.channels	= 2,
+		.autodma	= AUTODMA,
+		.enablebits	= {{0x00,0x00,0x00}, {0x00,0x00,0x00}},
+		.bootable	= ON_BOARD,
+		.extra		= 0,
 	},{
-		vendor:		0,
-		device:		0,
-		channels:	0,
-		bootable:	EOL,
+		.vendor		= 0,
+		.device		= 0,
+		.channels	= 0,
+		.bootable	= EOL,
 	}
 };
 
--- linux-2.5.47/drivers/ide/pci/nvidia.h.old	2002-10-07 15:45:28.000000000 -0500
+++ linux-2.5.47/drivers/ide/pci/nvidia.h	2002-11-11 07:22:07.000000000 -0600
@@ -17,10 +17,10 @@
 
 static ide_pci_host_proc_t nforce_procs[] __initdata = {
 	{
-		name:		"nforce",
-		set:		1,
-		get_info:	nforce_get_info,
-		parent:		NULL,
+		.name		= "nforce",
+		.set		= 1,
+		.get_info	= nforce_get_info,
+		.parent		= NULL,
 	},
 };
 #endif  /* defined(DISPLAY_NFORCE_TIMINGS) && defined(CONFIG_PROC_FS) */
@@ -31,18 +31,18 @@
 
 static ide_pci_device_t nvidia_chipsets[] __devinitdata = {
 	{
-		vendor:		PCI_VENDOR_ID_NVIDIA,
-		device:		PCI_DEVICE_ID_NVIDIA_NFORCE_IDE,
-		name:		"NFORCE",
-		init_chipset:	init_chipset_nforce,
-		init_iops:	NULL,
-		init_hwif:	init_hwif_nforce,
-		init_dma:	init_dma_nforce,
-		channels:	2,
-		autodma:	AUTODMA,
-		enablebits:	{{0x50,0x01,0x01}, {0x50,0x02,0x02}},
-		bootable:	ON_BOARD,
-		extra:		0,
+		.vendor		= PCI_VENDOR_ID_NVIDIA,
+		.device		= PCI_DEVICE_ID_NVIDIA_NFORCE_IDE,
+		.name		= "NFORCE",
+		.init_chipset	= init_chipset_nforce,
+		.init_iops	= NULL,
+		.init_hwif	= init_hwif_nforce,
+		.init_dma	= init_dma_nforce,
+		.channels	= 2,
+		.autodma	= AUTODMA,
+		.enablebits	= {{0x50,0x01,0x01}, {0x50,0x02,0x02}},
+		.bootable	= ON_BOARD,
+		.extra		= 0,
 	}
 };
 
-- 
They that can give up essential liberty to obtain a little temporary safety
deserve neither liberty nor safety.
 -- Benjamin Franklin, Historical Review of Pennsylvania, 1759
