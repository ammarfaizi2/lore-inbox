Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264879AbUAAVC2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Jan 2004 16:02:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264905AbUAAVBr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Jan 2004 16:01:47 -0500
Received: from amsfep14-int.chello.nl ([213.46.243.22]:21019 "EHLO
	amsfep14-int.chello.nl") by vger.kernel.org with ESMTP
	id S264879AbUAAUCw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Jan 2004 15:02:52 -0500
Date: Thu, 1 Jan 2004 21:02:50 +0100
Message-Id: <200401012002.i01K2o9i031822@callisto.of.borg>
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: Linux Kernel Development <linux-kernel@vger.kernel.org>,
       Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH 365] ncr53c7xx SCSI
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ncr53c7xx: Cleanup prototypes for ncr53c7xx_init()

--- linux-2.6.0/drivers/scsi/53c7xx.c	2003-08-09 21:43:12.000000000 +0200
+++ linux-m68k-2.6.0/drivers/scsi/53c7xx.c	2003-11-03 21:44:14.000000000 +0100
@@ -1102,8 +1102,8 @@
 }
 
 /* 
- * Function : static int ncr53c7xx_init(Scsi_Host_Template *tpnt, int board, 
- *	int chip, u32 base, int io_port, int irq, int dma, long long options,
+ * Function : int ncr53c7xx_init(Scsi_Host_Template *tpnt, int board, int chip,
+ *	unsigned long base, int io_port, int irq, int dma, long long options,
  *	int clock);
  *
  * Purpose : initializes a NCR53c7,8x0 based on base addresses,
--- linux-2.6.0/drivers/scsi/53c7xx.h	2003-05-05 10:31:51.000000000 +0200
+++ linux-m68k-2.6.0/drivers/scsi/53c7xx.h	2003-11-03 21:45:33.000000000 +0100
@@ -1600,5 +1600,9 @@
 /* Paranoid people could use panic() here. */
 #define FATAL(host) shutdown((host));
 
+extern int ncr53c7xx_init(Scsi_Host_Template *tpnt, int board, int chip,
+			  unsigned long base, int io_port, int irq, int dma,
+			  long long options, int clock);
+
 #endif /* NCR53c710_C */
 #endif /* NCR53c710_H */
--- linux-2.6.0/drivers/scsi/amiga7xx.c	2003-07-29 18:19:08.000000000 +0200
+++ linux-m68k-2.6.0/drivers/scsi/amiga7xx.c	2003-11-03 21:45:40.000000000 +0100
@@ -30,9 +30,6 @@
 
 #include<linux/stat.h>
 
-extern int ncr53c7xx_init (Scsi_Host_Template *tpnt, int board, int chip, 
-			   unsigned long base, int io_port, int irq, int dma,
-			   long long options, int clock);
 
 int __init amiga7xx_detect(Scsi_Host_Template *tpnt)
 {
--- linux-2.6.0/drivers/scsi/bvme6000.c	2003-07-29 18:19:09.000000000 +0200
+++ linux-m68k-2.6.0/drivers/scsi/bvme6000.c	2003-11-03 21:47:55.000000000 +0100
@@ -23,9 +23,6 @@
 
 #include<linux/stat.h>
 
-extern int ncr53c7xx_init(Scsi_Host_Template *tpnt, int board, int chip,
-			  unsigned long base, int io_port, int irq, int dma,
-			  long long options, int clock);
 
 int bvme6000_scsi_detect(Scsi_Host_Template *tpnt)
 {
--- linux-2.6.0/drivers/scsi/mvme16x.c	2003-07-29 18:19:10.000000000 +0200
+++ linux-m68k-2.6.0/drivers/scsi/mvme16x.c	2003-11-03 21:45:52.000000000 +0100
@@ -21,9 +21,6 @@
 
 #include<linux/stat.h>
 
-extern int ncr53c7xx_init(Scsi_Host_Template *tpnt, int board, int chip,
-			  unsigned long base, int io_port, int irq, int dma,
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
