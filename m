Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261317AbTH2O6F (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Aug 2003 10:58:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261327AbTH2O4m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Aug 2003 10:56:42 -0400
Received: from amsfep16-int.chello.nl ([213.46.243.26]:19550 "EHLO
	amsfep16-int.chello.nl") by vger.kernel.org with ESMTP
	id S261316AbTH2OwG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Aug 2003 10:52:06 -0400
Date: Fri, 29 Aug 2003 16:51:13 +0200
Message-Id: <200308291451.h7TEpDfx005920@callisto.of.borg>
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Marcelo Tosatti <marcelo@conectiva.com.br>
Cc: Linux Kernel Development <linux-kernel@vger.kernel.org>,
       Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH] M68k cpu_relax()
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

M68k: Make cpu_relax() compatible with 2.6.

--- linux-2.4.23-pre1/include/asm-m68k/processor.h	Sun Apr  6 10:29:45 2003
+++ linux-m68k-2.4.23-pre1/include/asm-m68k/processor.h	Wed Jul 23 18:26:22 2003
@@ -156,6 +156,6 @@
 #define init_task	(init_task_union.task)
 #define init_stack	(init_task_union.stack)
 
-#define cpu_relax()	do { } while (0)
+#define cpu_relax()	barrier()
 
 #endif

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
