Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262271AbSIZJuq>; Thu, 26 Sep 2002 05:50:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262283AbSIZJuq>; Thu, 26 Sep 2002 05:50:46 -0400
Received: from mail2.sonytel.be ([195.0.45.172]:9871 "EHLO mail.sonytel.be")
	by vger.kernel.org with ESMTP id <S262271AbSIZJuo>;
	Thu, 26 Sep 2002 05:50:44 -0400
Date: Thu, 26 Sep 2002 11:55:56 +0200 (MEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Linux Kernel Development <linux-kernel@vger.kernel.org>
cc: Rusty Trivial Russell <trivial@rustcorp.com.au>
Subject: [PATCH] __downgrade_write: wrong debug message
Message-ID: <Pine.GSO.4.21.0209261154450.25364-100000@vervain.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Fix debug message in __downgrade_write()

--- linux-2.5.38/lib/rwsem-spinlock.c	Sun Aug  4 15:58:58 2002
+++ linux-m68k-2.5.38/lib/rwsem-spinlock.c	Mon Aug 12 17:03:31 2002
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

