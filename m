Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318965AbSHFCIS>; Mon, 5 Aug 2002 22:08:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318966AbSHFCIS>; Mon, 5 Aug 2002 22:08:18 -0400
Received: from samba.sourceforge.net ([198.186.203.85]:39146 "HELO
	lists.samba.org") by vger.kernel.org with SMTP id <S318965AbSHFCIS>;
	Mon, 5 Aug 2002 22:08:18 -0400
From: Rusty Russell <rusty@rustcorp.com.au>
To: linux-kernel@vger.kernel.org, mingo@redhat.com
Subject: [PATCH] Minor scheduler comment fix
Date: Tue, 06 Aug 2002 12:08:53 +1000
Message-Id: <20020806021340.453A6413C@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I find the "pulling" threads comment for the migration thread
misleading: the migration thread is running on the source CPU, not the
target.

Ingo?
Rusty.

diff -urpN -I '\$.*\$' --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.30/kernel/sched.c working-2.5.30-comment/kernel/sched.c
--- linux-2.5.30/kernel/sched.c	2002-08-02 11:15:10.000000000 +1000
+++ working-2.5.30-comment/kernel/sched.c	2002-08-06 12:06:08.000000000 +1000
@@ -1959,7 +1959,8 @@ out:
 
 /*
  * migration_thread - this is a highprio system thread that performs
- * thread migration by 'pulling' threads into the target runqueue.
+ * thread migration by bumping the process off this cpu and then
+ * pushing it onto the new runqueue.
  */
 static int migration_thread(void * data)
 {

--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
