Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S143758AbRA1S0G>; Sun, 28 Jan 2001 13:26:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S143779AbRA1SZ4>; Sun, 28 Jan 2001 13:25:56 -0500
Received: from web.sajt.cz ([212.71.160.9]:27398 "EHLO web.sajt.cz")
	by vger.kernel.org with ESMTP id <S143758AbRA1SZs>;
	Sun, 28 Jan 2001 13:25:48 -0500
Date: Sun, 28 Jan 2001 19:17:57 +0100 (CET)
From: Pavel Rabel <pavel@web.sajt.cz>
To: andre@linux-ide.org
cc: linux-kernel@vger.kernel.org
Subject: [PATCH] ide config order
Message-ID: <Pine.LNX.4.21.0101281916100.18615-100000@web.sajt.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Please reorder config to group DMA options together. In 2.4.0

Pavel Rabel


--- drivers/ide/Config.in.old	Tue Nov 28 22:22:49 2000
+++ drivers/ide/Config.in	Tue Nov 28 22:24:19 2000
@@ -42,8 +42,8 @@
 	 bool '  Generic PCI IDE chipset support' CONFIG_BLK_DEV_IDEPCI
 	 if [ "$CONFIG_BLK_DEV_IDEPCI" = "y" ]; then
 	    bool '    Sharing PCI IDE interrupts support' CONFIG_IDEPCI_SHARE_IRQ
-	    bool '    Generic PCI bus-master DMA support' CONFIG_BLK_DEV_IDEDMA_PCI
 	    bool '    Boot off-board chipsets first support' CONFIG_BLK_DEV_OFFBOARD
+	    bool '    Generic PCI bus-master DMA support' CONFIG_BLK_DEV_IDEDMA_PCI
 	    dep_bool '      Use PCI DMA by default when available' CONFIG_IDEDMA_PCI_AUTO $CONFIG_BLK_DEV_IDEDMA_PCI
 	    define_bool CONFIG_BLK_DEV_IDEDMA $CONFIG_BLK_DEV_IDEDMA_PCI
 	    dep_bool '      ATA Work(s) In Progress (EXPERIMENTAL)' CONFIG_IDEDMA_PCI_WIP $CONFIG_BLK_DEV_IDEDMA_PCI $CONFIG_EXPERIMENTAL


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
