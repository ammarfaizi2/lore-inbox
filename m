Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264565AbTLGVVS (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Dec 2003 16:21:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264546AbTLGU4J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Dec 2003 15:56:09 -0500
Received: from amsfep16-int.chello.nl ([213.46.243.26]:22590 "EHLO
	amsfep16-int.chello.nl") by vger.kernel.org with ESMTP
	id S264532AbTLGUzj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Dec 2003 15:55:39 -0500
Date: Sun, 7 Dec 2003 21:51:24 +0100
Message-Id: <200312072051.hB7KpO75000735@callisto.of.borg>
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: Linux Kernel Development <linux-kernel@vger.kernel.org>,
       Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH 134] ncr53c7xx SCSI
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ncr53c7xx: Cleanup prototypes for ncr53c7xx_init()

--- linux-2.4.23/drivers/scsi/53c7xx.c	2003-09-04 10:29:21.000000000 +0200
+++ linux-m68k-2.4.23/drivers/scsi/53c7xx.c	2003-11-03 21:34:16.000000000 +0100
@@ -1104,8 +1104,8 @@
 }
 
 /* 
- * Function : static int ncr53c7xx_init(Scsi_Host_Template *tpnt, int board, 
- *	int chip, u32 base, int io_port, int irq, int dma, long long options,
+ * Function : int ncr53c7xx_init(Scsi_Host_Template *tpnt, int board, int chip,
+ *	unsigned long base, int io_port, int irq, int dma, long long options,
  *	int clock);
  *
  * Purpose : initializes a NCR53c7,8x0 based on base addresses,
--- linux-2.4.23/drivers/scsi/53c7xx.h	2003-09-04 10:29:22.000000000 +0200
+++ linux-m68k-2.4.23/drivers/scsi/53c7xx.h	2003-11-03 21:33:25.000000000 +0100
@@ -1600,5 +1600,9 @@
 /* Paranoid people could use panic() here. */
 #define FATAL(host) shutdown((host));
 
+extern int ncr53c7xx_init(Scsi_Host_Template *tpnt, int board, int chip,
+			  unsigned long base, int io_port, int irq, int dma,
+			  long long options, int clock);
+
 #endif /* NCR53c710_C */
 #endif /* NCR53c710_H */
--- linux-2.4.23/drivers/scsi/amiga7xx.c	2003-04-06 10:29:18.000000000 +0200
+++ linux-m68k-2.4.23/drivers/scsi/amiga7xx.c	2003-11-03 21:41:22.000000000 +0100
@@ -30,9 +30,6 @@
 
 #include<linux/stat.h>
 
-extern int ncr53c7xx_init (Scsi_Host_Template *tpnt, int board, int chip, 
-			   u32 base, int io_port, int irq, int dma,
-			   long long options, int clock);
 
 int __init amiga7xx_detect(Scsi_Host_Template *tpnt)
 {
--- linux-2.4.23/drivers/scsi/bvme6000.c	2002-09-13 10:16:31.000000000 +0200
+++ linux-m68k-2.4.23/drivers/scsi/bvme6000.c	2003-11-03 21:34:23.000000000 +0100
@@ -23,9 +23,6 @@
 
 #include<linux/stat.h>
 
-extern int ncr53c7xx_init(Scsi_Host_Template *tpnt, int board, int chip,
-			  u32 base, int io_port, int irq, int dma,
-			  long long options, int clock);
 
 int bvme6000_scsi_detect(Scsi_Host_Template *tpnt)
 {
--- linux-2.4.23/drivers/scsi/mvme16x.c	2002-09-13 10:16:33.000000000 +0200
+++ linux-m68k-2.4.23/drivers/scsi/mvme16x.c	2003-11-03 21:34:35.000000000 +0100
@@ -21,9 +21,6 @@
 
 #include<linux/stat.h>
 
-extern int ncr53c7xx_init(Scsi_Host_Template *tpnt, int board, int chip,
-			  u32 base, int io_port, int irq, int dma,
-			  long long options, int clock);
 
 int mvme16x_scsi_detect(Scsi_Host_Template *tpnt)
 {

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
