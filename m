Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964956AbWEJNa0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964956AbWEJNa0 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 May 2006 09:30:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964958AbWEJNa0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 May 2006 09:30:26 -0400
Received: from ms-smtp-03.nyroc.rr.com ([24.24.2.57]:59295 "EHLO
	ms-smtp-03.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S964956AbWEJNaZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 May 2006 09:30:25 -0400
Date: Wed, 10 May 2006 09:30:08 -0400 (EDT)
From: Steven Rostedt <rostedt@goodmis.org>
X-X-Sender: rostedt@gandalf.stny.rr.com
To: Gleb Natapov <gleb@minantech.com>
cc: Ingo Molnar <mingo@elte.hu>, akpm@osdl.org,
       Thomas Gleixner <tglx@linutronix.de>,
       LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH -mm 01/02] Remove tabs from Document futex PI design
In-Reply-To: <Pine.LNX.4.58.0605100925190.4503@gandalf.stny.rr.com>
Message-ID: <Pine.LNX.4.58.0605100928040.4503@gandalf.stny.rr.com>
References: <Pine.LNX.4.58.0605090954150.7007@gandalf.stny.rr.com>
 <Pine.LNX.4.58.0605100331290.31598@gandalf.stny.rr.com>
 <Pine.LNX.4.58.0605100429220.436@gandalf.stny.rr.com> <20060510101729.GB31504@elte.hu>
 <Pine.LNX.4.58.0605100657510.2485@gandalf.stny.rr.com> <20060510124600.GN5319@minantech.com>
 <Pine.LNX.4.58.0605100925190.4503@gandalf.stny.rr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Use only spaces in an ASCII document. Get rid of tabs.

Signed-off-by: Steven Rostedt <rostedt@goodmis.org>

Index: linux-2.6.17-rc3-mm1/Documentation/rt-mutex-design.txt
===================================================================
--- linux-2.6.17-rc3-mm1.orig/Documentation/rt-mutex-design.txt	2006-05-10 09:20:50.000000000 -0400
+++ linux-2.6.17-rc3-mm1/Documentation/rt-mutex-design.txt	2006-05-10 09:21:26.000000000 -0400
@@ -77,30 +77,30 @@ the design that is used to implement PI.

 PI chain - The PI chain is an ordered series of locks and processes that cause
            processes to inherit priorities from a previous process that is
-	   blocked on one of its locks.  This is described in more detail
-	   later in this document.
+           blocked on one of its locks.  This is described in more detail
+           later in this document.

 mutex    - In this document, to differentiate from locks that implement
-	   PI and spin locks that are used in the PI code, from now on
-	   the PI locks will be called a mutex.
+           PI and spin locks that are used in the PI code, from now on
+           the PI locks will be called a mutex.

-lock	 - In this document from now on, the term lock and spin lock will
+lock     - In this document from now on, the term lock and spin lock will
 	   be synonymous.  These are locks that are used for SMP as well
 	   as turning off preemption to protect areas of code on SMP machines.

 spin lock - Same as lock above.

 waiter   - A waiter is a struct that is stored on the stack of a blocked
-	   process.  Since the scope of the waiter is within the code for
-	   a process being blocked on the mutex, it is fine to allocate
-	   the waiter on the process' stack (local variable).  This
-	   structure holds a pointer to the task, as well as the mutex that
-	   the task is blocked on.  It also has the plist node structures to
-	   place the task in the waiter_list of a mutex as well as the
-	   pi_list of a mutex owner task (described below).
+           process.  Since the scope of the waiter is within the code for
+           a process being blocked on the mutex, it is fine to allocate
+           the waiter on the process' stack (local variable).  This
+           structure holds a pointer to the task, as well as the mutex that
+           the task is blocked on.  It also has the plist node structures to
+           place the task in the waiter_list of a mutex as well as the
+           pi_list of a mutex owner task (described below).

-	   waiter is sometimes used in reference to the task that is waiting
-	   on a mutex. This is the same as waiter->task.
+           waiter is sometimes used in reference to the task that is waiting
+           on a mutex. This is the same as waiter->task.

 waiters  - A list of processes that are blocked on a mutex.

@@ -327,11 +327,11 @@ cmpxchg is basically the following funct

 unsigned long _cmpxchg(unsigned long *A, unsigned long *B, unsigned long *C)
 {
-	unsigned long T = *A;
-	if (*A == *B) {
-		*A = *C;
-	}
-	return T;
+        unsigned long T = *A;
+        if (*A == *B) {
+                *A = *C;
+        }
+        return T;
 }
 #define cmpxchg(a,b,c) _cmpxchg(&a,&b,&c)

@@ -372,8 +372,8 @@ priority back.

 (Note:  if looking at the code, you will notice that the lower number of
         prio is returned.  This is because the prio field in the task structure
-	is an inverse order of the actual priority.  So a "prio" of 5 is
-	of higher priority than a "prio" of 10).
+        is an inverse order of the actual priority.  So a "prio" of 5 is
+        of higher priority than a "prio" of 10).

 __rt_mutex_adjust_prio examines the result of rt_mutex_getprio, and if the
 result does not equal the task's current priority, then rt_mutex_setprio
