Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261613AbVAGVOv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261613AbVAGVOv (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Jan 2005 16:14:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261617AbVAGVOj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Jan 2005 16:14:39 -0500
Received: from amsfep12-int.chello.nl ([213.46.243.17]:56925 "EHLO
	amsfep12-int.chello.nl") by vger.kernel.org with ESMTP
	id S261613AbVAGVLF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Jan 2005 16:11:05 -0500
Date: Fri, 7 Jan 2005 22:11:04 +0100
Message-Id: <200501072111.j07LB4EN011223@anakin.of.borg>
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: Linux Kernel Development <linux-kernel@vger.kernel.org>,
       linux-net@vger.kernel.org, Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH 167] Kill unused variables in the net code
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

2.4.28-rc2 introduced a warning in the net code on non-SMP:

    net/core/neighbour.c:1809: warning: unused variable `tbl'

The following patch fixes this.

Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>

--- linux-2.4.29-rc1/include/linux/spinlock.h	2004-04-27 17:22:10.000000000 +0200
+++ linux-m68k-2.4.29-rc1/include/linux/spinlock.h	2005-01-07 21:51:28.000000000 +0100
@@ -147,7 +147,7 @@
 
 #define rwlock_init(lock)	do { } while(0)
 #define read_lock(lock)		(void)(lock) /* Not "unused variable". */
-#define read_unlock(lock)	do { } while(0)
+#define read_unlock(lock)	(void)(lock) /* Not "unused variable". */
 #define write_lock(lock)	(void)(lock) /* Not "unused variable". */
 #define write_unlock(lock)	do { } while(0)
 

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
