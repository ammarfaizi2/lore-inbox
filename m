Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315174AbSEDTEL>; Sat, 4 May 2002 15:04:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315175AbSEDTEK>; Sat, 4 May 2002 15:04:10 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.176.19]:34776 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id <S315174AbSEDTEJ>; Sat, 4 May 2002 15:04:09 -0400
Date: Sat, 4 May 2002 20:59:37 +0200 (CEST)
From: Adrian Bunk <bunk@fs.tum.de>
X-X-Sender: bunk@mimas.fachschaften.tu-muenchen.de
To: Andrew Morton <akpm@zip.com.au>
cc: Martin Dalecki <dalecki@evision-ventures.com>,
        Andre Hedrick <andre@linux-ide.org>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: [patch] hpt374 support
In-Reply-To: <3CD2FC45.14442FC5@zip.com.au>
Message-ID: <Pine.NEB.4.44.0205042054570.283-100000@mimas.fachschaften.tu-muenchen.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew,

could you add something like the following patch to make it better visible
to users which chipsets are supported (I'm not sure whether the two lines
I suggest in drivers/ide/Config.help are correct but I hope you understand
the idea)?


--- drivers/ide/Config.in.old	Sat May  4 20:52:27 2002
+++ drivers/ide/Config.in	Sat May  4 20:52:48 2002
@@ -63,7 +63,7 @@
 	 dep_bool '    Cyrix CS5530 MediaGX chipset support' CONFIG_BLK_DEV_CS5530 $CONFIG_BLK_DEV_IDEDMA_PCI
   	 dep_bool '    HPT34X chipset support' CONFIG_BLK_DEV_HPT34X $CONFIG_BLK_DEV_IDEDMA_PCI
 	 dep_mbool '      HPT34X AUTODMA support (EXPERMENTAL)' CONFIG_HPT34X_AUTODMA $CONFIG_BLK_DEV_HPT34X $CONFIG_EXPERIMENTAL
-	 dep_bool '    HPT366 chipset support' CONFIG_BLK_DEV_HPT366 $CONFIG_BLK_DEV_IDEDMA_PCI
+	 dep_bool '    HPT36X/37X chipset support' CONFIG_BLK_DEV_HPT366 $CONFIG_BLK_DEV_IDEDMA_PCI
 	 dep_bool '    Intel and Efar (SMsC) chipset support' CONFIG_BLK_DEV_PIIX $CONFIG_BLK_DEV_IDEDMA_PCI
 	 if [ "$CONFIG_BLK_DEV_PIIX" = "y" ]; then
 	    dep_bool '      Use UDMA133 even on ICH2, ICH3 and CICH chips (EXPERIMENTAL)' CONFIG_BLK_DEV_PIIX_TRY133 $CONFIG_EXPERIMENTAL
--- drivers/ide/Config.help.old	Sat May  4 20:53:18 2002
+++ drivers/ide/Config.help	Sat May  4 20:55:54 2002
@@ -388,6 +388,8 @@
   HPT366 is an Ultra DMA chipset for ATA-66.
   HPT368 is an Ultra DMA chipset for ATA-66 RAID Based.
   HPT370 is an Ultra DMA chipset for ATA-100.
+  HPT372 is an Ultra DMA chipset for ATA-100.
+  HPT374 is an Ultra DMA chipset for ATA-100.

   This driver adds up to 4 more EIDE devices sharing a single
   interrupt.

TIA
Adrian

-- 

You only think this is a free country. Like the US the UK spends a lot of
time explaining its a free country because its a police state.
								Alan Cox



