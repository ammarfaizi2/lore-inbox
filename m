Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264921AbUAAUuh (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Jan 2004 15:50:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264919AbUAAUtd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Jan 2004 15:49:33 -0500
Received: from amsfep13-int.chello.nl ([213.46.243.24]:46116 "EHLO
	amsfep13-int.chello.nl") by vger.kernel.org with ESMTP
	id S264921AbUAAUDh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Jan 2004 15:03:37 -0500
Date: Thu, 1 Jan 2004 21:03:35 +0100
Message-Id: <200401012003.i01K3ZOi031926@callisto.of.borg>
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: Linux Kernel Development <linux-kernel@vger.kernel.org>,
       Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH 382] M68k thread_info
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

M68k: Fix (unused) definition of init_thread_info (from Roman Zippel)

--- linux-2.6.0/include/asm-m68k/thread_info.h	2003-08-25 18:16:35.000000000 +0200
+++ linux-m68k-2.6.0/include/asm-m68k/thread_info.h	2003-11-19 21:09:32.000000000 +0100
@@ -34,7 +34,7 @@
 #define free_thread_stack(ti)  free_pages((unsigned long)(ti),1)
 #endif /* PAGE_SHIFT == 13 */
 
-#define init_thread_info	(init_thread_union.thread_info)
+//#define init_thread_info	(init_task.thread.info)
 #define init_stack		(init_thread_union.stack)
 
 #define get_thread_info(tsk)	(&(tsk)->thread.info)

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
