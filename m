Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261287AbTEKK0X (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 May 2003 06:26:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261252AbTEKKZR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 May 2003 06:25:17 -0400
Received: from amsfep13-int.chello.nl ([213.46.243.24]:57186 "EHLO
	amsfep13-int.chello.nl") by vger.kernel.org with ESMTP
	id S261253AbTEKKVn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 May 2003 06:21:43 -0400
Date: Sun, 11 May 2003 12:31:03 +0200
Message-Id: <200305111031.h4BAV3Wr019712@callisto.of.borg>
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Linux Kernel Development <linux-kernel@vger.kernel.org>,
       Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH] M68k sys_ipc ENOSYS
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

M68k: Fix sys_ipc() to return ENOSYS instead of EINVAL as appropriate.

--- linux-2.5.x/arch/m68k/kernel/sys_m68k.c	21 Jun 2002 07:50:53 -0000	1.1.1.2
+++ linux-m68k-2.5.x/arch/m68k/kernel/sys_m68k.c	8 Apr 2003 08:41:59 -0000
@@ -202,7 +202,7 @@
 			return sys_semctl (first, second, third, fourth);
 			}
 		default:
-			return -EINVAL;
+			return -ENOSYS;
 		}
 	if (call <= MSGCTL) 
 		switch (call) {
@@ -233,7 +233,7 @@
 			return sys_msgctl (first, second,
 					   (struct msqid_ds *) ptr);
 		default:
-			return -EINVAL;
+			return -ENOSYS;
 		}
 	if (call <= SHMCTL) 
 		switch (call) {
@@ -256,7 +256,7 @@
 			return sys_shmctl (first, second,
 					   (struct shmid_ds *) ptr);
 		default:
-			return -EINVAL;
+			return -ENOSYS;
 		}
 
 	return -EINVAL;

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
