Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129667AbQKUVzm>; Tue, 21 Nov 2000 16:55:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129410AbQKUVzd>; Tue, 21 Nov 2000 16:55:33 -0500
Received: from boss.staszic.waw.pl ([195.205.163.66]:15625 "EHLO
	boss.staszic.waw.pl") by vger.kernel.org with ESMTP
	id <S129868AbQKUVzV>; Tue, 21 Nov 2000 16:55:21 -0500
Date: Tue, 21 Nov 2000 22:25:29 +0100 (CET)
From: Bartlomiej Zolnierkiewicz <dake@staszic.waw.pl>
To: torvalds@transmeta.com
cc: andre@linux-ide.org, linux-kernel@vger.kernel.org
Subject: [PATCH] fix help info about OSB4 and VIA82CXXX IDE chipsets (test11)
Message-ID: <Pine.LNX.4.21.0011211549080.5487-100000@tricky>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi

- OSB4 isn't marked (EXPERIMENTAL) in drivers/ide/Config.in so it
  shouldn't be marked so in Configure.help.
- PDC202XX driver also supports PDC20265.
- new VIA82CXXX driver removed kernel command line option (FIFO
  setting) and CONFIG_VIA82CXX_TUNING

--
Bartlomiej Zolnierkiewicz
<bkz@linux-ide.org>


--- linux-240t11/drivers/ide/Configure.help	Sun Nov 19 00:22:49 2000
+++ linux/drivers/ide/Configure.help	Tue Nov 21 15:45:16 2000
@@ -868,9 +868,9 @@
   This is a driver for the OPTi 82C621 EIDE controller.
   Please read the comments at the top of drivers/ide/opti621.c.
 
-ServerWorks OSB4 chipset support (EXPERIMENTAL)
+ServerWorks OSB4 chipset support
 CONFIG_BLK_DEV_OSB4
-  This driver adds PIO/DMA support for the Serverworks OSB4 chipset
+  This driver adds PIO/(U)DMA support for the ServerWorks OSB4 chipset.
 
 Intel PIIXn chipsets support
 CONFIG_BLK_DEV_PIIX
@@ -898,7 +898,7 @@
 
   If unsure, say N.
 
-PROMISE PDC20246/PDC20262/PDC20267 support
+PROMISE PDC20246/PDC20262/PDC20265/PDC20267 support
 CONFIG_BLK_DEV_PDC202XX
   Promise Ultra33 or PDC20246
   Promise Ultra66 or PDC20262
@@ -972,23 +972,15 @@
 VIA82CXXX chipset support
 CONFIG_BLK_DEV_VIA82CXXX
   This allows you to to configure your chipset for a better use while
-  running (U)DMA: it will allow you to enable efficiently the second
-  channel dma usage, as it may not be set by BIOS. It allows you to
-  pass a kernel command line at boot time in order to set fifo
-  config. If no command line is provided, it will try to set fifo
+  running PIO/(U)DMA, it will allow you to enable efficiently the second
+  channel dma usage, as it may not be set by BIOS. It will try to set fifo
   configuration at its best. It will allow you to get information from
-  /proc/ide/via provided you enabled "proc" support.
+  /proc/ide/via provided you enabled "/proc file system" support.
 
   Please read the comments at the top of drivers/ide/via82cxxx.c
 
   If you say Y here, then say Y to "Use DMA by default when available"
   as well.
-
-  If unsure, say N.
-
-VIA82CXXX Tuning support (WIP)
-CONFIG_VIA82CXXX_TUNING
-  Please read the comments at the top of drivers/ide/via82cxxx.c
 
   If unsure, say N.


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
