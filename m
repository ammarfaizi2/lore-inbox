Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261372AbTCYCrR>; Mon, 24 Mar 2003 21:47:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261377AbTCYCrF>; Mon, 24 Mar 2003 21:47:05 -0500
Received: from TYO202.gate.nec.co.jp ([202.32.8.202]:31146 "EHLO
	TYO202.gate.nec.co.jp") by vger.kernel.org with ESMTP
	id <S261362AbTCYCqJ>; Mon, 24 Mar 2003 21:46:09 -0500
To: Linus Torvalds <torvalds@transmeta.com>
Subject: [PATCH][v850]  Correct argument to thread_saved_pc on v850
Cc: linux-kernel@vger.kernel.org
Reply-To: Miles Bader <miles@gnu.org>
Message-Id: <20030325025658.C20EB37C2@mcspd15.ucom.lsi.nec.co.jp>
Date: Tue, 25 Mar 2003 11:56:58 +0900 (JST)
From: miles@lsi.nec.co.jp (Miles Bader)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff -ruN -X../cludes linux-2.5.66-moo.orig/arch/v850/kernel/process.c linux-2.5.66-moo/arch/v850/kernel/process.c
--- linux-2.5.66-moo.orig/arch/v850/kernel/process.c	2003-02-25 10:44:59.000000000 +0900
+++ linux-2.5.66-moo/arch/v850/kernel/process.c	2003-03-25 10:37:52.000000000 +0900
@@ -226,7 +226,7 @@
 	if (!p || p == current || p->state == TASK_RUNNING)
 		return 0;
 
-	pc = thread_saved_pc (&p->thread);
+	pc = thread_saved_pc (p);
 
 	/* This quite disgusting function walks up the stack, following
 	   saved return address, until it something that's out of bounds
