Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316579AbSHOFiD>; Thu, 15 Aug 2002 01:38:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316580AbSHOFiD>; Thu, 15 Aug 2002 01:38:03 -0400
Received: from dp.samba.org ([66.70.73.150]:44185 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S316579AbSHOFiD>;
	Thu, 15 Aug 2002 01:38:03 -0400
From: Rusty Russell <rusty@rustcorp.com.au>
To: trivial@rustcorp.com.au
Cc: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: [PATCH] init_tasks is not defined anywhere.
Date: Thu, 15 Aug 2002 15:23:47 +1000
Message-Id: <20020815004224.49F392C3C3@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

It's referenced by mips and mips64 (both far out of date), but never
actually defined anywhere.

diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.31/include/linux/sched.h working-2.5.31-percpu/include/linux/sched.h
--- linux-2.5.31/include/linux/sched.h	2002-08-02 11:15:10.000000000 +1000
+++ working-2.5.31-percpu/include/linux/sched.h	2002-08-15 11:47:02.000000000 +1000
@@ -440,7 +441,6 @@ extern union thread_union init_thread_un
 extern struct task_struct init_task;
 
 extern struct   mm_struct init_mm;
-extern struct task_struct *init_tasks[NR_CPUS];
 
 /* PID hashing. (shouldnt this be dynamic?) */
 #define PIDHASH_SZ (4096 >> 2)

--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
