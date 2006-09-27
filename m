Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030191AbWI0MLN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030191AbWI0MLN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Sep 2006 08:11:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030208AbWI0MLN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Sep 2006 08:11:13 -0400
Received: from ms-smtp-02.nyroc.rr.com ([24.24.2.56]:25812 "EHLO
	ms-smtp-02.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S1030191AbWI0MLN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Sep 2006 08:11:13 -0400
Date: Wed, 27 Sep 2006 08:10:52 -0400 (EDT)
From: Steven Rostedt <rostedt@goodmis.org>
X-X-Sender: rostedt@gandalf.stny.rr.com
To: akpm@osdl.org
cc: LKML <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@elte.hu>,
       Jan Altenberg <tb10alj@tglx.de>
Subject: [PATCH] typo fixes for rt-mutex-design.txt
Message-ID: <Pine.LNX.4.58.0609270806220.12950@gandalf.stny.rr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Here Andrew,

Jan gave me some typo fixes for the rt-mutex-design doc.

Acked-by: Steven Rostedt <rostedt@goodmis.org>

---------- Forwarded message ----------

Hi Steven,

the attached patch addresses some simple typos in rt-mutex-design.txt
It also changes the indentation of the cmpxchg example (the cmpxchg
example was indented by spaces, while all other code snippets were
indented by tabs).

Cheers,
JAN

Signed-off-by: Jan Altenberg <tb10alj@tglx.de>

----------------------

--- linux-2.6.18/Documentation/rt-mutex-design.txt.orig	2006-09-20 05:42:06.000000000 +0200
+++ linux-2.6.18/Documentation/rt-mutex-design.txt	2006-09-27 13:15:54.000000000 +0200
@@ -333,11 +333,11 @@ cmpxchg is basically the following funct

 unsigned long _cmpxchg(unsigned long *A, unsigned long *B, unsigned long *C)
 {
-        unsigned long T = *A;
-        if (*A == *B) {
-                *A = *C;
-        }
-        return T;
+	unsigned long T = *A;
+	if (*A == *B) {
+		*A = *C;
+	}
+	return T;
 }
 #define cmpxchg(a,b,c) _cmpxchg(&a,&b,&c)

@@ -582,7 +582,7 @@ contention).
 try_to_take_rt_mutex is used every time the task tries to grab a mutex in the
 slow path.  The first thing that is done here is an atomic setting of
 the "Has Waiters" flag of the mutex's owner field.  Yes, this could really
-be false, because if the the mutex has no owner, there are no waiters and
+be false, because if the mutex has no owner, there are no waiters and
 the current task also won't have any waiters.  But we don't have the lock
 yet, so we assume we are going to be a waiter.  The reason for this is to
 play nice for those architectures that do have CMPXCHG.  By setting this flag
@@ -735,7 +735,7 @@ do have CMPXCHG, that check is done in t
 in the slow path too.  If a waiter of a mutex woke up because of a signal
 or timeout between the time the owner failed the fast path CMPXCHG check and
 the grabbing of the wait_lock, the mutex may not have any waiters, thus the
-owner still needs to make this check. If there are no waiters than the mutex
+owner still needs to make this check. If there are no waiters then the mutex
 owner field is set to NULL, the wait_lock is released and nothing more is
 needed.

