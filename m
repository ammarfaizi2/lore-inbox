Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261193AbUBTMtd (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Feb 2004 07:49:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261181AbUBTMr3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Feb 2004 07:47:29 -0500
Received: from amsfep14-int.chello.nl ([213.46.243.22]:38448 "EHLO
	amsfep14-int.chello.nl") by vger.kernel.org with ESMTP
	id S261180AbUBTMqx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Feb 2004 07:46:53 -0500
Date: Fri, 20 Feb 2004 13:46:37 +0100
Message-Id: <200402201246.i1KCkbJH004181@callisto.of.borg>
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: Linux Kernel Development <linux-kernel@vger.kernel.org>,
       Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH 392] M68k mm init warning
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

M68k mm: Kill warning (from Sam Creasey)

--- linux-2.6.3/arch/m68k/mm/init.c	2003-07-29 18:18:35.000000000 +0200
+++ linux-m68k-2.6.3/arch/m68k/mm/init.c	2004-01-15 13:57:41.000000000 +0100
@@ -82,7 +82,9 @@
 	int datapages = 0;
 	int initpages = 0;
 	unsigned long tmp;
+#ifndef CONFIG_SUN3
 	int i;
+#endif
 
 	max_mapnr = num_physpages = (((unsigned long)high_memory - PAGE_OFFSET) >> PAGE_SHIFT);
 

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
