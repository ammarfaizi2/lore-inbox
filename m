Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261225AbTEKKXm (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 May 2003 06:23:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261227AbTEKKXH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 May 2003 06:23:07 -0400
Received: from amsfep16-int.chello.nl ([213.46.243.26]:17503 "EHLO
	amsfep16-int.chello.nl") by vger.kernel.org with ESMTP
	id S261225AbTEKKVf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 May 2003 06:21:35 -0400
Date: Sun, 11 May 2003 12:30:59 +0200
Message-Id: <200305111030.h4BAUx60019676@callisto.of.borg>
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Linux Kernel Development <linux-kernel@vger.kernel.org>,
       Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH] HAVE_ARCH_GET_SIGNAL_TO_DELIVER warning
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kill warning about unused static functions if HAVE_ARCH_GET_SIGNAL_TO_DELIVER
is defined.

--- linux-2.5.x/kernel/signal.c	Tue Mar 25 10:07:31 2003
+++ linux-m68k-2.5.x/kernel/signal.c	Thu Mar 27 12:08:54 2003
@@ -1343,6 +1343,9 @@
 	spin_unlock_irqrestore(&sighand->siglock, flags);
 }
 
+
+#ifndef HAVE_ARCH_GET_SIGNAL_TO_DELIVER
+
 static void
 finish_stop(int stop_count)
 {
@@ -1456,9 +1459,6 @@
 
 	finish_stop(stop_count);
 }
-
-
-#ifndef HAVE_ARCH_GET_SIGNAL_TO_DELIVER
 
 /*
  * Do appropriate magic when group_stop_count > 0.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
