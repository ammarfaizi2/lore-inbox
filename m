Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261456AbVEPImH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261456AbVEPImH (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 May 2005 04:42:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261405AbVEPIlN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 May 2005 04:41:13 -0400
Received: from smtp005.bizmail.sc5.yahoo.com ([66.163.175.82]:46228 "HELO
	smtp005.bizmail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S261456AbVEPIeI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 May 2005 04:34:08 -0400
Subject: [PATCH V2] Remove unused CONFIG_LOCKMETER functions
From: Kirk True <kernel@kirkandsheila.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Date: Mon, 16 May 2005 01:33:56 -0700
Message-Id: <1116232437.27227.3.camel@itchy.kirkandsheila.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-3) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Take 2 on removing these unused extern functions...

I had been working on porting SGI's lockmeter to 2.6 when I chanced upon
this. I was very perplexed that it's in there since this is the only
place that it appears in the codebase (according to grep).

        Signed-off-by: Kirk True <kirk@kirkandsheila.com>

--- linux-2.6.12-rc4/include/linux/spinlock.h 2005-03-01 23:38:09.000000000 -0800
+++ linux-2.6.12-rc4-debug/include/linux/spinlock.h   2005-05-16 01:23:43.000000000 -0700
@@ -502,18 +502,6 @@
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

