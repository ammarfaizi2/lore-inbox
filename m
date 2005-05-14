Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262703AbVENH6G@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262703AbVENH6G (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 May 2005 03:58:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262704AbVENH6G
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 May 2005 03:58:06 -0400
Received: from smtp005.bizmail.sc5.yahoo.com ([66.163.175.82]:24416 "HELO
	smtp005.bizmail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S262703AbVENH6C (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 May 2005 03:58:02 -0400
Subject: [PATCH] Remove unused CONFIG_LOCKMETER functions
From: Kirk True <kernel@kirkandsheila.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Date: Sat, 14 May 2005 00:57:54 -0700
Message-Id: <1116057474.7432.4.camel@itchy.kirkandsheila.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-3) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm working on porting SGI's lockmeter to 2.6 when I chanced upon this. I was very perplexed that it's in there since this is the only place that it appears in the codebase (according to grep).

        Signed-off-by: Kirk True <kirk@kirkandsheila.com>

diff -urpN linux-2.6.11.9/include/linux/spinlock.h linux-2.6.11.9-remove/include/linux/spinlock.h
--- linux-2.6.11.9/include/linux/spinlock.h	2005-05-11 15:42:01.000000000 -0700
+++ linux-2.6.11.9-remove/include/linux/spinlock.h	2005-05-14 00:28:04.000000000 -0700
@@ -502,18 +502,6 @@ do { \
 	1 : ({local_irq_restore(flags); 0;}); \
 })
 
-#ifdef CONFIG_LOCKMETER
-extern void _metered_spin_lock   (spinlock_t *lock);
-extern void _metered_spin_unlock (spinlock_t *lock);
-extern int  _metered_spin_trylock(spinlock_t *lock);
-extern void _metered_read_lock    (rwlock_t *lock);
-extern void _metered_read_unlock  (rwlock_t *lock);
-extern void _metered_write_lock   (rwlock_t *lock);
-extern void _metered_write_unlock (rwlock_t *lock);
-extern int  _metered_read_trylock (rwlock_t *lock);
-extern int  _metered_write_trylock(rwlock_t *lock);
-#endif
-
 /* "lock on reference count zero" */
 #ifndef ATOMIC_DEC_AND_LOCK
 #include <asm/atomic.h>

