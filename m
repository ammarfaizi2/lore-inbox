Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265063AbTB0ORs>; Thu, 27 Feb 2003 09:17:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265065AbTB0ORs>; Thu, 27 Feb 2003 09:17:48 -0500
Received: from covert.brown-ring.iadfw.net ([209.196.123.142]:62726 "EHLO
	covert.brown-ring.iadfw.net") by vger.kernel.org with ESMTP
	id <S265063AbTB0ORq>; Thu, 27 Feb 2003 09:17:46 -0500
Date: Thu, 27 Feb 2003 08:27:54 -0600
From: Art Haas <ahaas@airmail.net>
To: Torben Mathiasen <torben.mathiasen@hp.com>, linux-kernel@vger.kernel.org
Cc: Linus Torvalds <torvalds@transmeta.com>
Subject: [PATCH] Fix initializers on drivers/ide/pci/trident.h
Message-ID: <20030227142754.GC6002@debian>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

This file is missing the '=' in the initializers, and there was an
obsolete set of initiailzers in the file as well. The obsolete ones have
been converted, and the missing '=' added in this patch.

Art Haas

===== drivers/ide/pci/triflex.h 1.1 vs edited =====
--- 1.1/drivers/ide/pci/triflex.h	Sun Jan 12 12:11:46 2003
+++ edited/drivers/ide/pci/triflex.h	Thu Feb 27 08:21:50 2003
@@ -18,31 +18,26 @@
 
 static ide_pci_device_t triflex_devices[] __devinitdata = {
 	{
-		.vendor 	PCI_VENDOR_ID_COMPAQ,
-		.device		PCI_DEVICE_ID_COMPAQ_TRIFLEX_IDE,
-		.name		"TRIFLEX",
-		.init_chipset	init_chipset_triflex,
-		.init_iops	NULL,
-		.init_hwif	init_hwif_triflex,
-		.channels	2,
-		.autodma	AUTODMA,
-		.enablebits	{{0x80, 0x01, 0x01}, {0x80, 0x02, 0x02}},
-		.bootable	ON_BOARD,
-		.extra		0,
+		.vendor 	= PCI_VENDOR_ID_COMPAQ,
+		.device		= PCI_DEVICE_ID_COMPAQ_TRIFLEX_IDE,
+		.name		= "TRIFLEX",
+		.init_chipset	= init_chipset_triflex,
+		.init_iops	= NULL,
+		.init_hwif	= init_hwif_triflex,
+		.channels	= 2,
+		.autodma	= AUTODMA,
+		.enablebits	= {{0x80, 0x01, 0x01}, {0x80, 0x02, 0x02}},
+		.bootable	= ON_BOARD,
 	},{	
-		.vendor		0,
-		.device		0,
-		.channels	0,
-		.bootable	EOL,
+		.bootable	= EOL,
 	}
 };
 
 #ifdef CONFIG_PROC_FS
 static ide_pci_host_proc_t triflex_proc __initdata = {
-		name:		"triflex",
-		set:		1,
-		get_info: 	triflex_get_info,
-		parent: 	NULL,
+	.name		= "triflex",
+	.set		= 1,
+	.get_info 	= triflex_get_info,
 };
 #endif
 
-- 
They that can give up essential liberty to obtain a little temporary safety
deserve neither liberty nor safety.
 -- Benjamin Franklin, Historical Review of Pennsylvania, 1759
