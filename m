Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268150AbTAKTzq>; Sat, 11 Jan 2003 14:55:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268152AbTAKTzp>; Sat, 11 Jan 2003 14:55:45 -0500
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:42194 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id <S268150AbTAKTzo>; Sat, 11 Jan 2003 14:55:44 -0500
Date: Sat, 11 Jan 2003 21:04:26 +0100
From: Adrian Bunk <bunk@fs.tum.de>
To: Marcelo Tosatti <marcelo@conectiva.com.br>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: [2.4 patch] update help for hpt366.c
Message-ID: <20030111200426.GD21826@fs.tum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marcelo, hi Alan,

the trivial patch below updates the information about the chipsets 
supported by hpt366.c.

Please apply
Adrian

--- linux-2.4.20/drivers/ide/Config.in.old	2003-01-11 20:58:01.000000000 +0100
+++ linux-2.4.20/drivers/ide/Config.in	2003-01-11 20:59:20.000000000 +0100
@@ -56,7 +56,7 @@
 	    dep_tristate '    Cyrix CS5530 MediaGX chipset support' CONFIG_BLK_DEV_CS5530 $CONFIG_BLK_DEV_IDEDMA_PCI
   	    dep_tristate '    HPT34X chipset support' CONFIG_BLK_DEV_HPT34X $CONFIG_BLK_DEV_IDEDMA_PCI
 	    dep_mbool    '      HPT34X AUTODMA support (WIP)' CONFIG_HPT34X_AUTODMA $CONFIG_BLK_DEV_HPT34X $CONFIG_IDEDMA_PCI_WIP
-	    dep_tristate '    HPT366/368/370 chipset support' CONFIG_BLK_DEV_HPT366 $CONFIG_BLK_DEV_IDEDMA_PCI
+	    dep_tristate '    HPT36X/37X chipset support' CONFIG_BLK_DEV_HPT366 $CONFIG_BLK_DEV_IDEDMA_PCI
 	    dep_tristate '    Intel PIIXn chipsets support' CONFIG_BLK_DEV_PIIX $CONFIG_BLK_DEV_IDEDMA_PCI
 	    if [ "$CONFIG_MIPS_ITE8172" = "y" -o "$CONFIG_MIPS_IVR" = "y" ]; then
 	       dep_mbool '    IT8172 IDE support' CONFIG_BLK_DEV_IT8172 $CONFIG_BLK_DEV_IDEDMA_PCI
--- linux-2.4.20/Documentation/Configure.help.old	2003-01-11 20:59:56.000000000 +0100
+++ linux-2.4.20/Documentation/Configure.help	2003-01-11 21:00:54.000000000 +0100
@@ -1161,11 +1161,13 @@
 
   If unsure, say N.
 
-HPT366/368/370 chipset support
+HPT36X/37X chipset support
 CONFIG_BLK_DEV_HPT366
   HPT366 is an Ultra DMA chipset for ATA-66.
   HPT368 is an Ultra DMA chipset for ATA-66 RAID Based.
   HPT370 is an Ultra DMA chipset for ATA-100.
+  HPT372 is an Ultra DMA chipset for ATA-133.
+  HPT374 is an Ultra DMA chipset for ATA-133.
 
   This driver adds up to 4 more EIDE devices sharing a single
   interrupt.
