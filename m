Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261534AbUJaKUA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261534AbUJaKUA (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 31 Oct 2004 05:20:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261569AbUJaKTT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 31 Oct 2004 05:19:19 -0500
Received: from amsfep19-int.chello.nl ([213.46.243.20]:12638 "EHLO
	amsfep19-int.chello.nl") by vger.kernel.org with ESMTP
	id S261535AbUJaKDk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 31 Oct 2004 05:03:40 -0500
Date: Sun, 31 Oct 2004 11:03:39 +0100
Message-Id: <200410311003.i9VA3d14009637@anakin.of.borg>
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: Linux Kernel Development <linux-kernel@vger.kernel.org>,
       Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH 504] smp_lock.h: Avoid recursive include
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

smp_lock.h: Avoid recursive include

Signed-off-by: Roman Zippel <zippel@linux-m68k.org>
Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>

--- linux-2.6.10-rc1/include/linux/smp_lock.h	2004-04-28 15:47:31.000000000 +0200
+++ linux-m68k-2.6.10-rc1/include/linux/smp_lock.h	2004-10-20 22:24:05.000000000 +0200
@@ -2,7 +2,6 @@
 #define __LINUX_SMPLOCK_H
 
 #include <linux/config.h>
-#include <linux/sched.h>
 #include <linux/spinlock.h>
 
 #if defined(CONFIG_SMP) || defined(CONFIG_PREEMPT)

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
