Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264549AbTLGVGW (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Dec 2003 16:06:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264560AbTLGVCV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Dec 2003 16:02:21 -0500
Received: from amsfep13-int.chello.nl ([213.46.243.24]:10833 "EHLO
	amsfep13-int.chello.nl") by vger.kernel.org with ESMTP
	id S264559AbTLGVAt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Dec 2003 16:00:49 -0500
Date: Sun, 7 Dec 2003 21:51:25 +0100
Message-Id: <200312072051.hB7KpPYS000741@callisto.of.borg>
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: Linux Kernel Development <linux-kernel@vger.kernel.org>,
       Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH 135] Amiga Gayle IDE cleanup
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Amiga Gayle IDE: Kill old test code for the IDE doubler

--- linux-2.4.23/drivers/ide/legacy/gayle.c	2003-05-09 11:02:33.000000000 +0200
+++ linux-m68k-2.4.23/drivers/ide/legacy/gayle.c	2003-11-02 13:49:18.000000000 +0100
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
