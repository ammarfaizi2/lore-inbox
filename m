Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263499AbTHXM7n (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Aug 2003 08:59:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263514AbTHXM6a
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Aug 2003 08:58:30 -0400
Received: from amsfep11-int.chello.nl ([213.46.243.20]:63264 "EHLO
	amsfep11-int.chello.nl") by vger.kernel.org with ESMTP
	id S263455AbTHXM6U (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Aug 2003 08:58:20 -0400
Date: Sun, 24 Aug 2003 14:58:51 +0200
Message-Id: <200308241258.h7OCwpRh000979@callisto.of.borg>
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: Linux Kernel Development <linux-kernel@vger.kernel.org>,
       Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH] Atari floppy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Atari floppy: Add missing includes and remove some unnecessary includes

--- linux-2.6.0-test2/drivers/block/ataflop.c	Tue Jul 29 18:18:44 2003
+++ linux-m68k-2.6.0-test2/drivers/block/ataflop.c	Wed Jul 30 22:49:57 2003
@@ -63,35 +63,16 @@
 
 #include <linux/module.h>
 
-#include <linux/sched.h>
-#include <linux/string.h>
-#include <linux/fs.h>
-#include <linux/fcntl.h>
-#include <linux/kernel.h>
-#include <linux/timer.h>
 #include <linux/fd.h>
-#include <linux/errno.h>
-#include <linux/types.h>
 #include <linux/delay.h>
-#include <linux/mm.h>
-#include <linux/slab.h>
 #include <linux/init.h>
-#include <linux/buffer_head.h>		/* for invalidate_buffers() */
-
-#include <asm/setup.h>
-#include <asm/system.h>
-#include <asm/bitops.h>
-#include <asm/irq.h>
-#include <asm/pgtable.h>
-#include <asm/uaccess.h>
+#include <linux/blkdev.h>
 
 #include <asm/atafd.h>
 #include <asm/atafdreg.h>
-#include <asm/atarihw.h>
 #include <asm/atariints.h>
 #include <asm/atari_stdma.h>
 #include <asm/atari_stram.h>
-#include <linux/blkpg.h>
 
 #define	FD_MAX_UNITS 2
 

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
