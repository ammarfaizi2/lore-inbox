Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263535AbTHXNC3 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Aug 2003 09:02:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263525AbTHXM7u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Aug 2003 08:59:50 -0400
Received: from amsfep15-int.chello.nl ([213.46.243.28]:34642 "EHLO
	amsfep15-int.chello.nl") by vger.kernel.org with ESMTP
	id S263463AbTHXM62 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Aug 2003 08:58:28 -0400
Date: Sun, 24 Aug 2003 14:58:50 +0200
Message-Id: <200308241258.h7OCwogI000967@callisto.of.borg>
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: Linux Kernel Development <linux-kernel@vger.kernel.org>,
       Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH] Amiga floppy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Amiga floppy: Add missing includes and remove some unnecessary includes (from
Roman Zippel)

--- linux-2.6.0-test2/drivers/block/amiflop.c	Tue Jul 29 18:18:44 2003
+++ linux-m68k-2.6.0-test2/drivers/block/amiflop.c	Tue Jul 29 23:35:37 2003
@@ -55,24 +55,15 @@
 
 #include <linux/module.h>
 
-#include <linux/sched.h>
-#include <linux/fs.h>
-#include <linux/fcntl.h>
-#include <linux/kernel.h>
-#include <linux/timer.h>
 #include <linux/fd.h>
 #include <linux/hdreg.h>
-#include <linux/errno.h>
-#include <linux/types.h>
 #include <linux/delay.h>
-#include <linux/string.h>
-#include <linux/slab.h>
 #include <linux/init.h>
 #include <linux/amifdreg.h>
 #include <linux/amifd.h>
-#include <linux/ioport.h>
 #include <linux/buffer_head.h>
-#include <linux/interrupt.h>
+#include <linux/blkdev.h>
+#include <linux/elevator.h>
 
 #include <asm/setup.h>
 #include <asm/uaccess.h>

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
