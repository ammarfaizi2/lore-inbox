Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317096AbSHOPNZ>; Thu, 15 Aug 2002 11:13:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317101AbSHOPNZ>; Thu, 15 Aug 2002 11:13:25 -0400
Received: from mx1.elte.hu ([157.181.1.137]:33995 "HELO mx1.elte.hu")
	by vger.kernel.org with SMTP id <S317096AbSHOPNY>;
	Thu, 15 Aug 2002 11:13:24 -0400
Date: Thu, 15 Aug 2002 17:16:38 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [patch] clone-detached-2.5.31-B0
In-Reply-To: <Pine.LNX.4.44.0208132307340.12804-100000@localhost.localdomain>
Message-ID: <Pine.LNX.4.44.0208151715320.2982-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


one of the debugging tests triggered a false-positive BUG() when a
detached thread was straced. Fix against BK-curr attached.

	Ingo

--- kernel/signal.c.orig	Thu Aug 15 17:12:02 2002
+++ kernel/signal.c	Thu Aug 15 17:12:34 2002
@@ -774,7 +774,7 @@
 	int why, status;
 
 	/* is the thread detached? */
-	if (sig == -1 || tsk->exit_signal == -1)
+	if (sig == -1)
 		BUG();
 
 	info.si_signo = sig;

