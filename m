Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136294AbRECJe2>; Thu, 3 May 2001 05:34:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136298AbRECJeS>; Thu, 3 May 2001 05:34:18 -0400
Received: from mail.scs.ch ([212.254.229.5]:42765 "EHLO mail.scs.ch")
	by vger.kernel.org with ESMTP id <S136294AbRECJeD>;
	Thu, 3 May 2001 05:34:03 -0400
Message-ID: <3AF126FB.1911930D@scs.ch>
Date: Thu, 03 May 2001 11:38:03 +0200
From: Reto Baettig <baettig@scs.ch>
X-Mailer: Mozilla 4.77 [de] (X11; U; Linux 2.2.19 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: MICROPATCH: define rwlock_init() for ALPHA platforms
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Here's a small patch which defines rwlock_init() for alphas. It's
defined for all the other platforms.

    Reto

--- include/asm-alpha/spinlock.h.orig   Thu May  3 11:00:08 2001
+++ include/asm-alpha/spinlock.h        Thu May  3 11:01:46 2001
@@ -95,6 +95,7 @@
 } /*__attribute__((aligned(32)))*/ rwlock_t;

 #define RW_LOCK_UNLOCKED (rwlock_t) { 0, 0 }
+#define rwlock_init(lp) do { *(lp) = RW_LOCK_UNLOCKED; } while(0)

 #if DEBUG_RWLOCK
 extern void write_lock(rwlock_t * lock);


