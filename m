Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315451AbSGGLhF>; Sun, 7 Jul 2002 07:37:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315611AbSGGLhE>; Sun, 7 Jul 2002 07:37:04 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.176.19]:38639 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id <S315451AbSGGLhD>; Sun, 7 Jul 2002 07:37:03 -0400
Date: Sun, 7 Jul 2002 13:39:37 +0200 (CEST)
From: Adrian Bunk <bunk@fs.tum.de>
X-X-Sender: bunk@mimas.fachschaften.tu-muenchen.de
To: Marcelo Tosatti <marcelo@conectiva.com.br>
cc: Andre Hedrick <andre@linux-ide.org>, <linux-kernel@vger.kernel.org>
Subject: [2.4 patch] document that cmd64x.c supports the CMD649 and CMD680
 chipsets
Message-ID: <Pine.NEB.4.44.0207071334520.14608-100000@mimas.fachschaften.tu-muenchen.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marcelo,

the patch below documents that cmd64x.c supports the CMD649 and CMD680
chipsets. Since it's a pure documentation update it should be acceptable
for -rc2.


--- Documentation/Configure.help.old	Sun Jul  7 13:26:45 2002
+++ Documentation/Configure.help	Sun Jul  7 13:31:35 2002
@@ -1067,10 +1067,10 @@
   This effect can be also invoked by calling "idex=ata66"
   If unsure, say N.

-CMD64X chipset support
+CMD64X and CMD680 chipset support
 CONFIG_BLK_DEV_CMD64X
   Say Y here if you have an IDE controller which uses any of these
-  chipsets: CMD643, CMD646, or CMD648.
+  chipsets: CMD643, CMD646, CMD648, CMD649 or CMD680.

 CY82C693 chipset support
 CONFIG_BLK_DEV_CY82C693
--- drivers/ide/Config.in.old	Sun Jul  7 13:32:19 2002
+++ drivers/ide/Config.in	Sun Jul  7 13:32:46 2002
@@ -65,7 +65,7 @@
 	    dep_mbool '      ALI M15x3 WDC support (DANGEROUS)' CONFIG_WDC_ALI15X3 $CONFIG_BLK_DEV_ALI15X3
 	    dep_bool '    AMD Viper support' CONFIG_BLK_DEV_AMD74XX $CONFIG_BLK_DEV_IDEDMA_PCI
 	    dep_mbool '      AMD Viper ATA-66 Override (WIP)' CONFIG_AMD74XX_OVERRIDE $CONFIG_BLK_DEV_AMD74XX $CONFIG_IDEDMA_PCI_WIP
-	    dep_bool '    CMD64X chipset support' CONFIG_BLK_DEV_CMD64X $CONFIG_BLK_DEV_IDEDMA_PCI
+	    dep_bool '    CMD64X and CMD680 chipset support' CONFIG_BLK_DEV_CMD64X $CONFIG_BLK_DEV_IDEDMA_PCI
 	    dep_bool '    CMD680 chipset tuning support' CONFIG_BLK_DEV_CMD680 $CONFIG_BLK_DEV_CMD64X
 	    dep_bool '    CY82C693 chipset support' CONFIG_BLK_DEV_CY82C693 $CONFIG_BLK_DEV_IDEDMA_PCI
 	    dep_bool '    Cyrix CS5530 MediaGX chipset support' CONFIG_BLK_DEV_CS5530 $CONFIG_BLK_DEV_IDEDMA_PCI

cu
Adrian

-- 

You only think this is a free country. Like the US the UK spends a lot of
time explaining its a free country because its a police state.
								Alan Cox

