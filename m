Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261364AbSJ1Ug7>; Mon, 28 Oct 2002 15:36:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261462AbSJ1Ug6>; Mon, 28 Oct 2002 15:36:58 -0500
Received: from amsfep11-int.chello.nl ([213.46.243.20]:33632 "EHLO
	amsfep11-int.chello.nl") by vger.kernel.org with ESMTP
	id <S261364AbSJ1Ug5>; Mon, 28 Oct 2002 15:36:57 -0500
Date: Sat, 28 Sep 2002 22:42:26 +0200
Message-Id: <200209282042.g8SKgQ57001401@callisto.of.borg>
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Linux Kernel Development <linux-kernel@vger.kernel.org>,
       Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH] Fix rwsemtrace() message
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fix rwsemtrace() message

--- linux-2.5.44/lib/rwsem-spinlock.c	Sun Aug  4 15:58:58 2002
+++ linux-m68k-2.5.44/lib/rwsem-spinlock.c	Mon Aug 12 17:03:31 2002
@@ -290,7 +290,7 @@
  */
 void __downgrade_write(struct rw_semaphore *sem)
 {
-	rwsemtrace(sem,"Entering __rwsem_downgrade");
+	rwsemtrace(sem,"Entering __downgrade_write");
 
 	spin_lock(&sem->wait_lock);
 
@@ -300,7 +300,7 @@
 
 	spin_unlock(&sem->wait_lock);
 
-	rwsemtrace(sem,"Leaving __rwsem_downgrade");
+	rwsemtrace(sem,"Leaving __downgrade_write");
 }
 
 EXPORT_SYMBOL(init_rwsem);

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

