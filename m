Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316840AbSFFG7V>; Thu, 6 Jun 2002 02:59:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316846AbSFFG7U>; Thu, 6 Jun 2002 02:59:20 -0400
Received: from ausmtp01.au.ibm.COM ([202.135.136.97]:62445 "EHLO
	ausmtp01.au.ibm.com") by vger.kernel.org with ESMTP
	id <S316840AbSFFG7T>; Thu, 6 Jun 2002 02:59:19 -0400
From: Rusty Russell <rusty@rustcorp.com.au>
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org, frankeh@watson.ibm.com
Subject: [PATCH] Futex update I: Trivial comment removal
Date: Thu, 06 Jun 2002 17:01:14 +1000
Message-Id: <E17FrGk-0003j9-00@wagner.rustcorp.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Name: Obsolete comment replacement
Author: Rusty Russell
Status: Trivial

D: This comment refers to the original implementation.

diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/current-dontdiff --minimal linux-2.5.20/kernel/futex.c working-2.5.20-afutex/kernel/futex.c
--- linux-2.5.20/kernel/futex.c	Sat May 25 14:35:00 2002
+++ working-2.5.20-afutex/kernel/futex.c	Wed Jun  5 18:42:17 2002
@@ -35,12 +35,7 @@
 #include <linux/time.h>
 #include <asm/uaccess.h>
 
-/* These mutexes are a very simple counter: the winner is the one who
-   decrements from 1 to 0.  The counter starts at 1 when the lock is
-   free.  A value other than 0 or 1 means someone may be sleeping.
-   This is simple enough to work on all architectures, but has the
-   problem that if we never "up" the semaphore it could eventually
-   wrap around. */
+/* Simple "sleep if unchanged" interface. */
 
 /* FIXME: This may be way too small. --RR */
 #define FUTEX_HASHBITS 6
 
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
