Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261426AbSLMFe5>; Fri, 13 Dec 2002 00:34:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261427AbSLMFe5>; Fri, 13 Dec 2002 00:34:57 -0500
Received: from mx20a.rmci.net ([205.162.184.37]:38543 "HELO mx20a.rmci.net")
	by vger.kernel.org with SMTP id <S261426AbSLMFe4>;
	Fri, 13 Dec 2002 00:34:56 -0500
Subject: [PATCH] signal.c: wrong rt signals comment, 2.4.20-pre11
From: Kristis Makris <mkdebian@gmx.net>
To: linux-kernel@vger.kernel.org
Content-Type: multipart/mixed; boundary="=-I2GyfuyCJ0Xydtwlym7n"
X-Mailer: Ximian Evolution 1.0.5 
Date: 12 Dec 2002 22:42:40 -0700
Message-Id: <1039758162.589.8.camel@mcmicro>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-I2GyfuyCJ0Xydtwlym7n
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

I'm sorry for being a little out of date.

I believe it's the RT signals that get queued. Someone please apply
against 2.5.x?




--=-I2GyfuyCJ0Xydtwlym7n
Content-Disposition: attachment; filename=rt_signals_comment.patch
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; name=rt_signals_comment.patch; charset=ANSI_X3.4-1968

--- linux/kernel/signal.c	Sat Oct 19 11:58:48 2002
+++ linux-2.4.20-pre11.mod/kernel/signal.c	Thu Dec 12 22:31:48 2002
@@ -237,7 +237,7 @@
 		kmem_cache_free(sigqueue_cachep,q);
 		atomic_dec(&nr_queued_signals);
=20
-		/* Non-RT signals can exist multiple times.. */
+		/* RT signals can exist multiple times.. */
 		if (sig >=3D SIGRTMIN) {
 			while ((q =3D *pp) !=3D NULL) {
 				if (q->info.si_signo =3D=3D sig)

--=-I2GyfuyCJ0Xydtwlym7n--

