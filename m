Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268179AbTAKWAN>; Sat, 11 Jan 2003 17:00:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268180AbTAKWAN>; Sat, 11 Jan 2003 17:00:13 -0500
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:10961 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id <S268179AbTAKWAJ>; Sat, 11 Jan 2003 17:00:09 -0500
Date: Sat, 11 Jan 2003 23:08:49 +0100
From: Adrian Bunk <bunk@fs.tum.de>
To: Andre Hedrick <andre@linux-ide.org>
Cc: Marcelo Tosatti <marcelo@conectiva.com.br>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: [2.4 patch] update help for hpt366.c
Message-ID: <20030111220849.GK21826@fs.tum.de>
References: <20030111200426.GD21826@fs.tum.de> <Pine.LNX.4.10.10301111335480.11839-100000@master.linux-ide.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.10.10301111335480.11839-100000@master.linux-ide.org>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 11, 2003 at 01:42:46PM -0800, Andre Hedrick wrote:

> Caution!
> 
> I and Andrew Morton have hpt374's which do not behave will under U133.
> It could be a device - controller combination erratium but not sure

This is an area where you have more knowledge than I do.

I do only know people who don't have DMA support because you don't 
select "HPT366/368/370 chipset support" when you have a HPT374.

What about the patch below?

> Cheers,

cu
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
--- linux-2.4.20/Documentation/Configure.help.old	2003-01-11 23:05:04.000000000 +0100
+++ linux-2.4.20/Documentation/Configure.help	2003-01-11 23:06:42.000000000 +0100
@@ -1161,11 +1161,14 @@
 
   If unsure, say N.
 
-HPT366/368/370 chipset support
+HPT36X/37X chipset support
 CONFIG_BLK_DEV_HPT366
-  HPT366 is an Ultra DMA chipset for ATA-66.
-  HPT368 is an Ultra DMA chipset for ATA-66 RAID Based.
-  HPT370 is an Ultra DMA chipset for ATA-100.
+  This driver includes support for the following chipsets:
+  - HPT366
+  - HPT368
+  - HPT370
+  - HPT372
+  - HPT374
 
   This driver adds up to 4 more EIDE devices sharing a single
   interrupt.
