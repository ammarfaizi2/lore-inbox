Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264537AbTLGU6r (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Dec 2003 15:58:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264531AbTLGU54
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Dec 2003 15:57:56 -0500
Received: from amsfep19-int.chello.nl ([213.46.243.20]:29484 "EHLO
	amsfep11-int.chello.nl") by vger.kernel.org with ESMTP
	id S264537AbTLGUzo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Dec 2003 15:55:44 -0500
Date: Sun, 7 Dec 2003 21:51:29 +0100
Message-Id: <200312072051.hB7KpTXn000771@callisto.of.borg>
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: Linux Kernel Development <linux-kernel@vger.kernel.org>,
       Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH 140] M68k asm/system.h
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

M68k: Add missing #ifdef __KERNEL / #endif (from Christian T. Steigies)

--- linux-2.4.23/include/asm-m68k/system.h	2003-10-15 11:13:29.000000000 -0400
+++ linux-m68k-2.4.23/include/asm-m68k/system.h	2003-11-18 22:33:02.000000000 -0500
@@ -7,6 +7,8 @@
 #include <asm/segment.h>
 #include <asm/entry.h>
 
+#ifdef __KERNEL__
+
 /*
  * switch_to(n) should switch tasks to task ptr, first checking that
  * ptr isn't the current task, in which case it does nothing.  This
@@ -156,4 +158,6 @@
 }
 #endif
 
+#endif /* __KERNEL__ */
+
 #endif /* _M68K_SYSTEM_H */

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
