Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315592AbSECIHd>; Fri, 3 May 2002 04:07:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315593AbSECIHc>; Fri, 3 May 2002 04:07:32 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.176.19]:59118 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id <S315592AbSECIH3>; Fri, 3 May 2002 04:07:29 -0400
Date: Fri, 3 May 2002 10:03:05 +0200 (CEST)
From: Adrian Bunk <bunk@fs.tum.de>
X-X-Sender: bunk@mimas.fachschaften.tu-muenchen.de
To: Andre Hedrick <andre@linux-ide.org>,
        Marcelo Tosatti <marcelo@conectiva.com.br>
cc: lkml <linux-kernel@vger.kernel.org>
Subject: [patch] give better information which chipsets hpt366.c is for
Message-ID: <Pine.NEB.4.44.0205030958190.2605-100000@mimas.fachschaften.tu-muenchen.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andre, hi Marcelo,

the patch below gives in the short description in "make *config" the
information that hpt366.c also supports the HPT368 and HPT370 chipsets.
This removes confusion for people using these chipsets who didn't select
this option because they don't have a HPT366.


--- drivers/ide/Config.in.old	Fri May  3 09:58:14 2002
+++ drivers/ide/Config.in	Fri May  3 10:00:17 2002
@@ -71,7 +71,7 @@
 	    dep_bool '    Cyrix CS5530 MediaGX chipset support' CONFIG_BLK_DEV_CS5530 $CONFIG_BLK_DEV_IDEDMA_PCI
   	    dep_bool '    HPT34X chipset support' CONFIG_BLK_DEV_HPT34X $CONFIG_BLK_DEV_IDEDMA_PCI
 	    dep_mbool '      HPT34X AUTODMA support (WIP)' CONFIG_HPT34X_AUTODMA $CONFIG_BLK_DEV_HPT34X $CONFIG_IDEDMA_PCI_WIP
-	    dep_bool '    HPT366 chipset support' CONFIG_BLK_DEV_HPT366 $CONFIG_BLK_DEV_IDEDMA_PCI
+	    dep_bool '    HPT366/368/370 chipset support' CONFIG_BLK_DEV_HPT366 $CONFIG_BLK_DEV_IDEDMA_PCI
 	    if [ "$CONFIG_X86" = "y" -o "$CONFIG_IA64" = "y" ]; then
 	       dep_mbool '    Intel PIIXn chipsets support' CONFIG_BLK_DEV_PIIX $CONFIG_BLK_DEV_IDEDMA_PCI
 	       dep_mbool '      PIIXn Tuning support' CONFIG_PIIX_TUNING $CONFIG_BLK_DEV_PIIX $CONFIG_IDEDMA_PCI_AUTO
--- Documentation/Configure.help~	Fri May  3 08:35:31 2002
+++ Documentation/Configure.help	Fri May  3 10:00:39 2002
@@ -1106,7 +1106,7 @@

   If unsure, say N.

-HPT366 chipset support
+HPT366/368/370 chipset support
 CONFIG_BLK_DEV_HPT366
   HPT366 is an Ultra DMA chipset for ATA-66.
   HPT368 is an Ultra DMA chipset for ATA-66 RAID Based.

cu
Adrian

-- 

You only think this is a free country. Like the US the UK spends a lot of
time explaining its a free country because its a police state.
								Alan Cox

