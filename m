Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261177AbTDHJRw (for <rfc822;willy@w.ods.org>); Tue, 8 Apr 2003 05:17:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261191AbTDHJQY (for <rfc822;linux-kernel-outgoing>); Tue, 8 Apr 2003 05:16:24 -0400
Received: from TYO202.gate.nec.co.jp ([202.32.8.202]:51101 "EHLO
	TYO202.gate.nec.co.jp") by vger.kernel.org with ESMTP
	id S261165AbTDHJQP (for <rfc822;linux-kernel@vger.kernel.org>); Tue, 8 Apr 2003 05:16:15 -0400
To: Linus Torvalds <torvalds@transmeta.com>
Subject: [PATCH][v850]  Correct argument to thread_saved_pc on v850
Cc: linux-kernel@vger.kernel.org
Reply-To: Miles Bader <miles@gnu.org>
Message-Id: <20030408092741.47F323736@mcspd15.ucom.lsi.nec.co.jp>
Date: Tue,  8 Apr 2003 18:27:41 +0900 (JST)
From: miles@lsi.nec.co.jp (Miles Bader)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff -ruN -X../cludes linux-2.5.67-moo.orig/arch/v850/kernel/process.c linux-2.5.67-moo/arch/v850/kernel/process.c
--- linux-2.5.67-moo.orig/arch/v850/kernel/process.c	2003-02-25 10:44:59.000000000 +0900
+++ linux-2.5.67-moo/arch/v850/kernel/process.c	2003-04-08 10:39:41.000000000 +0900
@@ -226,7 +226,7 @@
 	if (!p || p == current || p->state == TASK_RUNNING)
 		return 0;
 
-	pc = thread_saved_pc (&p->thread);
+	pc = thread_saved_pc (p);
 
 	/* This quite disgusting function walks up the stack, following
 	   saved return address, until it something that's out of bounds
