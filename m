Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290657AbSAYM05>; Fri, 25 Jan 2002 07:26:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290653AbSAYM0r>; Fri, 25 Jan 2002 07:26:47 -0500
Received: from mx2.elte.hu ([157.181.151.9]:15257 "HELO mx2.elte.hu")
	by vger.kernel.org with SMTP id <S290651AbSAYM0d>;
	Fri, 25 Jan 2002 07:26:33 -0500
Date: Fri, 25 Jan 2002 15:24:07 +0100 (CET)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: <mingo@elte.hu>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: <linux-kernel@vger.kernel.org>
Subject: [patch] [sched] entry.S offset fix, 2.5.3-pre5.
Message-ID: <Pine.LNX.4.33.0201251518160.7264-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


the attached patch (from Robert Love) fixes the 'processor' offset in
entry.S. While the stock kernel does not use it currently, the preemptive
kernel patches use it.

	Ingo

--- linux/arch/i386/kernel/entry.S.orig	Sat Nov  3 02:18:49 2001
+++ linux/arch/i386/kernel/entry.S	Fri Jan 25 12:06:36 2002
@@ -77,7 +77,7 @@
 exec_domain	= 16
 need_resched	= 20
 tsk_ptrace	= 24
-processor	= 52
+cpu		= 32

 ENOSYS = 38



