Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272536AbTGZPSm (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Jul 2003 11:18:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272550AbTGZOly
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Jul 2003 10:41:54 -0400
Received: from amsfep13-int.chello.nl ([213.46.243.24]:25617 "EHLO
	amsfep13-int.chello.nl") by vger.kernel.org with ESMTP
	id S272537AbTGZOcz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Jul 2003 10:32:55 -0400
Date: Sat, 26 Jul 2003 16:52:03 +0200
Message-Id: <200307261452.h6QEq3gK002514@callisto.of.borg>
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Linus Torvalds <torvalds@transmeta.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Linux Kernel Development <linux-kernel@vger.kernel.org>,
       Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH] m68k flush_icache_page()
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

m68k: Add missing cacheflush (from Roman Zippel)

--- linux-2.6.x/include/asm-m68k/cacheflush.h	Sun Apr 20 12:54:01 2003
+++ linux-m68k-2.6.x/include/asm-m68k/cacheflush.h	Wed Jul 23 22:16:16 2003
@@ -124,8 +124,8 @@
 	}
 }
 
-#define flush_dcache_page(page)	__flush_page_to_ram(page_address(page))
-#define flush_icache_page(vma,pg)              do { } while (0)
+#define flush_dcache_page(page)		__flush_page_to_ram(page_address(page))
+#define flush_icache_page(vma, page)	__flush_page_to_ram(page_address(page))
 #define flush_icache_user_range(vma,pg,adr,len)	do { } while (0)
 
 extern void flush_icache_range(unsigned long address, unsigned long endaddr);

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
