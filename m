Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265405AbUAAU7G (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Jan 2004 15:59:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265080AbUAAUzv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Jan 2004 15:55:51 -0500
Received: from amsfep15-int.chello.nl ([213.46.243.28]:25903 "EHLO
	amsfep15-int.chello.nl") by vger.kernel.org with ESMTP
	id S264881AbUAAUDE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Jan 2004 15:03:04 -0500
Date: Thu, 1 Jan 2004 21:02:59 +0100
Message-Id: <200401012002.i01K2xlP031836@callisto.of.borg>
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: Linux Kernel Development <linux-kernel@vger.kernel.org>,
       Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH 367] Amiga Gayle IDE cleanup
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Amiga Gayle IDE: Kill old test code for the IDE doubler

--- linux-2.6.0/drivers/ide/legacy/gayle.c	2003-04-20 12:28:33.000000000 +0200
+++ linux-m68k-2.6.0/drivers/ide/legacy/gayle.c	2003-11-03 21:54:03.000000000 +0100
@@ -174,16 +174,5 @@
 	    }
 	} else
 	    release_mem_region(res_start, res_n);
-
-#if 1 /* TESTING */
-	if (i == 1) {
-	    volatile u_short *addr = (u_short *)base;
-	    u_short data;
-	    printk("+++ Probing for IDE doubler... ");
-	    *addr = 0xffff;
-	    data = *addr;
-	    printk("probe returned 0x%02x (PLEASE REPORT THIS!!)\n", data);
-	}
-#endif /* TESTING */
     }
 }

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
