Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261593AbSLZAvl>; Wed, 25 Dec 2002 19:51:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261594AbSLZAvl>; Wed, 25 Dec 2002 19:51:41 -0500
Received: from mx20b.rmci.net ([205.162.184.38]:48795 "HELO mx20b.rmci.net")
	by vger.kernel.org with SMTP id <S261593AbSLZAvk>;
	Wed, 25 Dec 2002 19:51:40 -0500
Subject: [PATCH] signal.c(collect_signal): wrong comment
From: Kristis Makris <mkdebian@gmx.net>
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org
Content-Type: multipart/mixed; boundary="=-5xXPyAA6+JJiymiDBF+f"
Organization: 
Message-Id: <1040864388.942.9.camel@mcmicro>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.0 
Date: 25 Dec 2002 17:59:50 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-5xXPyAA6+JJiymiDBF+f
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Fixed a wrong comment regarding RT signal queueing.

--=-5xXPyAA6+JJiymiDBF+f
Content-Disposition: attachment; filename=nonrt_badcomment.patch
Content-Type: text/plain; name=nonrt_badcomment.patch; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 7bit

--- linux/kernel/signal.c	2002-12-23 22:20:05.000000000 -0700
+++ linux-2.5.53.mod/kernel/signal.c	2002-12-25 17:53:45.000000000 -0700
@@ -422,7 +422,7 @@
 		kmem_cache_free(sigqueue_cachep,q);
 		atomic_dec(&nr_queued_signals);
 
-		/* Non-RT signals can exist multiple times.. */
+		/* RT signals can exist multiple times.. */
 		if (sig >= SIGRTMIN) {
 			while ((q = *pp) != NULL) {
 				if (q->info.si_signo == sig)

--=-5xXPyAA6+JJiymiDBF+f--

