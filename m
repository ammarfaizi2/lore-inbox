Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262554AbTI1NEQ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 Sep 2003 09:04:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262540AbTI1ND6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 Sep 2003 09:03:58 -0400
Received: from amsfep15-int.chello.nl ([213.46.243.28]:50751 "EHLO
	amsfep15-int.chello.nl") by vger.kernel.org with ESMTP
	id S262554AbTI1NC6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 Sep 2003 09:02:58 -0400
Date: Sun, 28 Sep 2003 14:55:22 +0200
Message-Id: <200309281255.h8SCtMMO005522@callisto.of.borg>
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: Linux Kernel Development <linux-kernel@vger.kernel.org>,
       Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH 308] Atari ACSI fix
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Atari ACSI: Add missing include and fix duplicate parameter type

--- linux-2.6.0-test6/drivers/block/acsi.c	Sat Aug  9 21:42:48 2003
+++ linux-m68k-2.6.0-test6/drivers/block/acsi.c	Thu Sep 18 04:30:39 2003
@@ -63,6 +63,7 @@
 #include <linux/hdreg.h> /* for HDIO_GETGEO */
 #include <linux/blkpg.h>
 #include <linux/buffer_head.h>
+#include <linux/blkdev.h>
 
 #include <asm/setup.h>
 #include <asm/pgtable.h>
@@ -346,7 +347,7 @@
 static int acsicmd_dma( const char *cmd, char *buffer, int blocks, int
                         rwflag, int enable);
 static int acsi_reqsense( char *buffer, int targ, int lun);
-static void acsi_print_error(const unsigned char *errblk, int struct acsi_info_struct *aip);
+static void acsi_print_error(const unsigned char *errblk, struct acsi_info_struct *aip);
 static irqreturn_t acsi_interrupt (int irq, void *data, struct pt_regs *fp);
 static void unexpected_acsi_interrupt( void );
 static void bad_rw_intr( void );

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
