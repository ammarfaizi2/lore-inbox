Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129410AbQKUVzn>; Tue, 21 Nov 2000 16:55:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129585AbQKUVze>; Tue, 21 Nov 2000 16:55:34 -0500
Received: from boss.staszic.waw.pl ([195.205.163.66]:15369 "EHLO
	boss.staszic.waw.pl") by vger.kernel.org with ESMTP
	id <S129667AbQKUVzU>; Tue, 21 Nov 2000 16:55:20 -0500
Date: Tue, 21 Nov 2000 22:25:15 +0100 (CET)
From: Bartlomiej Zolnierkiewicz <dake@staszic.waw.pl>
To: torvalds@transmeta.com
cc: andre@linux-ide.org, linux-kernel@vger.kernel.org
Subject: [uPATCH] fix IDE/ServerWorks OSB4 config option (test11)
Message-ID: <Pine.LNX.4.21.0011211522570.4622-100000@tricky>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi

In drivers/Config.in CONFIG_BLK_DEV_OSB4 depends on itself...

--
Bartlomiej Zolnierkiewicz
<bkz@linux-ide.org>

--- linux-240t11/drivers/ide/Config.in	Wed Nov 15 22:02:11 2000
+++ linux/drivers/ide/Config.in	Tue Nov 21 14:52:07 2000
@@ -68,7 +68,7 @@
 	    dep_bool '    OPTi 82C621 chipset enhanced support (EXPERIMENTAL)' CONFIG_BLK_DEV_OPTI621 $CONFIG_EXPERIMENTAL
 	    dep_bool '    PROMISE PDC20246/PDC20262/PDC20267 support' CONFIG_BLK_DEV_PDC202XX $CONFIG_BLK_DEV_IDEDMA_PCI
 	    dep_bool '      Special UDMA Feature' CONFIG_PDC202XX_BURST $CONFIG_BLK_DEV_PDC202XX
-	    dep_bool '    ServerWorks OSB4 chipset support' CONFIG_BLK_DEV_OSB4 $CONFIG_BLK_DEV_OSB4
+	    dep_bool '    ServerWorks OSB4 chipset support' CONFIG_BLK_DEV_OSB4 $CONFIG_BLK_DEV_IDEDMA_PCI $CONFIG_X86
 	    dep_bool '    SiS5513 chipset support' CONFIG_BLK_DEV_SIS5513 $CONFIG_BLK_DEV_IDEDMA_PCI $CONFIG_X86
 	    dep_bool '    SLC90E66 chipset support' CONFIG_BLK_DEV_SLC90E66 $CONFIG_BLK_DEV_IDEDMA_PCI $CONFIG_X86
 	    dep_bool '    Tekram TRM290 chipset support (EXPERIMENTAL)' CONFIG_BLK_DEV_TRM290 $CONFIG_BLK_DEV_IDEDMA_PCI


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
