Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319106AbSHMXuZ>; Tue, 13 Aug 2002 19:50:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319222AbSHMXuZ>; Tue, 13 Aug 2002 19:50:25 -0400
Received: from ivimey.org ([194.106.52.201]:10802 "EHLO gatemaster.ivimey.org")
	by vger.kernel.org with ESMTP id <S319106AbSHMXuY>;
	Tue, 13 Aug 2002 19:50:24 -0400
Date: Wed, 14 Aug 2002 00:52:16 +0100 (BST)
From: Ruth Ivimey-Cook <Ruth.Ivimey-Cook@ivimey.org>
X-X-Sender: ruthc@sharra.ivimey.org
To: linux-kernel@vger.kernel.org
Subject: RFC [PATCH] pdc202xx config.in rewording
Message-ID: <Pine.LNX.4.44.0208140050450.25777-100000@sharra.ivimey.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Folks,

Together with the configure.help patch, this one rewords the text in config.in
to be (I hope) easier to understand:

diff -U6 -r -x .*.flags -x *.o -x .depend linux-2.4.19/drivers/ide/Config.in 2.4.19-ri1/linux/drivers/ide/Config.in
--- linux-2.4.19/drivers/ide/Config.in	Sat Aug  3 01:39:44 2002
+++ 2.4.19-ri1/linux/drivers/ide/Config.in	Sat Aug 10 23:02:46 2002
@@ -80,15 +80,15 @@
 	       dep_mbool '    IT8172 IDE support' CONFIG_BLK_DEV_IT8172 $CONFIG_BLK_DEV_IDEDMA_PCI
 	       dep_mbool '      IT8172 IDE Tuning support' CONFIG_IT8172_TUNING $CONFIG_BLK_DEV_IT8172 $CONFIG_IDEDMA_PCI_AUTO
 	    fi
 	    dep_bool '    NS87415 chipset support (EXPERIMENTAL)' CONFIG_BLK_DEV_NS87415 $CONFIG_BLK_DEV_IDEDMA_PCI $CONFIG_EXPERIMENTAL
 	    dep_bool '    OPTi 82C621 chipset enhanced support (EXPERIMENTAL)' CONFIG_BLK_DEV_OPTI621 $CONFIG_EXPERIMENTAL
 #	    dep_mbool '   Pacific Digital A-DMA support (EXPERIMENTAL)' CONFIG_BLK_DEV_PDC_ADMA $CONFIG_BLK_DEV_ADMA $CONFIG_IDEDMA_PCI_WIP $CONFIG_EXPERIMENTAL
-	    dep_bool '    PROMISE PDC202{46|62|65|67|68|69|70} support' CONFIG_BLK_DEV_PDC202XX $CONFIG_BLK_DEV_IDEDMA_PCI
-	    dep_bool '      Special UDMA Feature' CONFIG_PDC202XX_BURST $CONFIG_BLK_DEV_PDC202XX
-	    dep_bool '      Special FastTrak Feature' CONFIG_PDC202XX_FORCE $CONFIG_BLK_DEV_PDC202XX
+	    dep_bool '    PROMISE PDC202{46|62|65|67|68|69|70|75|76} support' CONFIG_BLK_DEV_PDC202XX $CONFIG_BLK_DEV_IDEDMA_PCI
+	    dep_bool '      Force use of Burst-Mode UDMA' CONFIG_PDC202XX_BURST $CONFIG_BLK_DEV_PDC202XX
+	    dep_bool '      Do not use software RAID device (such as PDC20276) as plain IDE controller' CONFIG_PDC202XX_FORCE $CONFIG_BLK_DEV_PDC202XX
 	    dep_bool '    ServerWorks OSB4/CSB5 chipsets support' CONFIG_BLK_DEV_SVWKS $CONFIG_BLK_DEV_IDEDMA_PCI $CONFIG_X86
 	    dep_bool '    SiS5513 chipset support' CONFIG_BLK_DEV_SIS5513 $CONFIG_BLK_DEV_IDEDMA_PCI $CONFIG_X86
 	    dep_bool '    SLC90E66 chipset support' CONFIG_BLK_DEV_SLC90E66 $CONFIG_BLK_DEV_IDEDMA_PCI $CONFIG_X86
 	    dep_bool '    Tekram TRM290 chipset support (EXPERIMENTAL)' CONFIG_BLK_DEV_TRM290 $CONFIG_BLK_DEV_IDEDMA_PCI $CONFIG_EXPERIMENTAL
 	    dep_bool '    VIA82CXXX chipset support' CONFIG_BLK_DEV_VIA82CXXX $CONFIG_BLK_DEV_IDEDMA_PCI
 	    if [ "$CONFIG_PPC" = "y" -o "$CONFIG_ARM" = "y" ]; then

-- 
Ruth Ivimey-Cook
Software engineer and technical writer.

