Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267208AbSLKUHk>; Wed, 11 Dec 2002 15:07:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267213AbSLKUHk>; Wed, 11 Dec 2002 15:07:40 -0500
Received: from covert.brown-ring.iadfw.net ([209.196.123.142]:48653 "EHLO
	covert.brown-ring.iadfw.net") by vger.kernel.org with ESMTP
	id <S267208AbSLKUHh>; Wed, 11 Dec 2002 15:07:37 -0500
Date: Wed, 11 Dec 2002 14:15:21 -0600
From: Art Haas <ahaas@airmail.net>
To: linux-kernel@vger.kernel.org
Cc: Linus Torvalds <torvalds@transmeta.com>
Subject: [PATCH] C99 initializers for drivers/ide/pci
Message-ID: <20021211201521.GE28537@debian>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

I think these two patches are needed (unless I've inadvertently reverted
something and am now patching back to what should be). These patches
convert the two files to use C99 initializers. The patches are against
2.5.51.

Art Haas

--- linux-2.5.51/drivers/ide/pci/cs5520.h.old	2002-11-29 09:23:59.000000000 -0600
+++ linux-2.5.51/drivers/ide/pci/cs5520.h	2002-12-10 13:52:04.000000000 -0600
@@ -17,10 +17,10 @@
 
 static ide_pci_host_proc_t cs5520_procs[] __initdata = {
 	{
-		name:		"cs5520",
-		set:		1,
-		get_info:	cs5520_get_info,
-		parent:		NULL,
+		.name		= "cs5520",
+		.set		= 1,
+		.get_info	= cs5520_get_info,
+		.parent		= NULL,
 	},
 };
 #endif  /* defined(DISPLAY_CS5520_TIMINGS) && defined(CONFIG_PROC_FS) */
@@ -31,32 +31,32 @@
 
 static ide_pci_device_t cyrix_chipsets[] __devinitdata = {
 	{
-		vendor:		PCI_VENDOR_ID_CYRIX,
-		device:		PCI_DEVICE_ID_CYRIX_5510,
-		name:		"Cyrix 5510",
-		init_chipset:	init_chipset_cs5520,
-		init_setup_dma: cs5520_init_setup_dma,
-		init_iops:	NULL,
-		init_hwif:	init_hwif_cs5520,
-		isa_ports:	1,
-		channels:	2,
-		autodma:	AUTODMA,
-		bootable:	ON_BOARD,
-		extra:		0,
+		.vendor		= PCI_VENDOR_ID_CYRIX,
+		.device		= PCI_DEVICE_ID_CYRIX_5510,
+		.name		= "Cyrix 5510",
+		.init_chipset	= init_chipset_cs5520,
+		.init_setup_dma = cs5520_init_setup_dma,
+		.init_iops	= NULL,
+		.init_hwif	= init_hwif_cs5520,
+		.isa_ports	= 1,
+		.channels	= 2,
+		.autodma	= AUTODMA,
+		.bootable	= ON_BOARD,
+		.extra		= 0,
 	},
 	{
-		vendor:		PCI_VENDOR_ID_CYRIX,
-		device:		PCI_DEVICE_ID_CYRIX_5520,
-		name:		"Cyrix 5520",
-		init_chipset:	init_chipset_cs5520,
-		init_setup_dma: cs5520_init_setup_dma,
-		init_iops:	NULL,
-		init_hwif:	init_hwif_cs5520,
-		isa_ports:	1,
-		channels:	2,
-		autodma:	AUTODMA,
-		bootable:	ON_BOARD,
-		extra:		0,
+		.vendor		= PCI_VENDOR_ID_CYRIX,
+		.device		= PCI_DEVICE_ID_CYRIX_5520,
+		.name		= "Cyrix 5520",
+		.init_chipset	= init_chipset_cs5520,
+		.init_setup_dma = cs5520_init_setup_dma,
+		.init_iops	= NULL,
+		.init_hwif	= init_hwif_cs5520,
+		.isa_ports	= 1,
+		.channels	= 2,
+		.autodma	= AUTODMA,
+		.bootable	= ON_BOARD,
+		.extra		= 0,
 	}
 };
 
--- linux-2.5.51/drivers/ide/pci/sc1200.h.old	2002-11-29 09:24:00.000000000 -0600
+++ linux-2.5.51/drivers/ide/pci/sc1200.h	2002-12-10 13:52:04.000000000 -0600
@@ -17,10 +17,10 @@
 
 static ide_pci_host_proc_t sc1200_procs[] __initdata = {
 	{
-		name:		"sc1200",
-		set:		1,
-		get_info:	sc1200_get_info,
-		parent:		NULL,
+		.name		= "sc1200",
+		.set		= 1,
+		.get_info	= sc1200_get_info,
+		.parent		= NULL,
 	},
 };
 #endif /* DISPLAY_SC1200_TIMINGS && CONFIG_PROC_FS */
@@ -31,23 +31,23 @@
 
 static ide_pci_device_t sc1200_chipsets[] __devinitdata = {
 	{	/* 0 */
-		vendor:		PCI_VENDOR_ID_NS,
-		device:		PCI_DEVICE_ID_NS_SCx200_IDE,
-		name:		"SC1200",
-		init_chipset:	init_chipset_sc1200,
-		init_iops:	NULL,
-		init_hwif:	init_hwif_sc1200,
-		init_dma:	init_dma_sc1200,
-		channels:	2,
-		autodma:	AUTODMA,
-		enablebits:	{{0x00,0x00,0x00}, {0x00,0x00,0x00}},
-		bootable:	ON_BOARD,
-		extra:		0,
+		.vendor		= PCI_VENDOR_ID_NS,
+		.device		= PCI_DEVICE_ID_NS_SCx200_IDE,
+		.name		= "SC1200",
+		.init_chipset	= init_chipset_sc1200,
+		.init_iops	= NULL,
+		.init_hwif	= init_hwif_sc1200,
+		.init_dma	= init_dma_sc1200,
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
 
-- 
They that can give up essential liberty to obtain a little temporary safety
deserve neither liberty nor safety.
 -- Benjamin Franklin, Historical Review of Pennsylvania, 1759
