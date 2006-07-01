Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751900AbWGAPHW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751900AbWGAPHW (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 1 Jul 2006 11:07:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751815AbWGAO5b
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 1 Jul 2006 10:57:31 -0400
Received: from www.osadl.org ([213.239.205.134]:37540 "EHLO mail.tglx.de")
	by vger.kernel.org with ESMTP id S1751635AbWGAO5J (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 1 Jul 2006 10:57:09 -0400
Message-Id: <20060701145225.183718000@cruncher.tec.linutronix.de>
References: <20060701145211.856500000@cruncher.tec.linutronix.de>
Date: Sat, 01 Jul 2006 14:54:39 -0000
From: Thomas Gleixner <tglx@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@elte.hu>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       David Miller <davem@davemloft.net>, schwidefsky@de.ibm.com
Subject: [RFC][patch 17/44] S390: Use the new IRQF_ constansts
Content-Disposition: inline; filename=irqflags-s390.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Use the new IRQF_ constants and remove the SA_INTERRUPT define

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
 include/asm-s390/signal.h |    2 --
 1 file changed, 2 deletions(-)

Index: linux-2.6.git/include/asm-s390/signal.h
===================================================================
--- linux-2.6.git.orig/include/asm-s390/signal.h	2006-07-01 16:51:23.000000000 +0200
+++ linux-2.6.git/include/asm-s390/signal.h	2006-07-01 16:51:36.000000000 +0200
@@ -84,7 +84,6 @@ typedef unsigned long sigset_t;
  * SA_FLAGS values:
  *
  * SA_ONSTACK indicates that a registered stack_t will be used.
- * SA_INTERRUPT is a no-op, but left due to historical reasons. Use the
  * SA_RESTART flag to get restarting signals (which were the default long ago)
  * SA_NOCLDSTOP flag to turn off SIGCHLD when children stop.
  * SA_RESETHAND clears the handler when the signal is delivered.
@@ -104,7 +103,6 @@ typedef unsigned long sigset_t;
 
 #define SA_NOMASK       SA_NODEFER
 #define SA_ONESHOT      SA_RESETHAND
-#define SA_INTERRUPT    0x20000000 /* dummy -- ignored */
 
 #define SA_RESTORER     0x04000000
 

--

