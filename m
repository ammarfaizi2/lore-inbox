Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262135AbVATMXI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262135AbVATMXI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Jan 2005 07:23:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262136AbVATMXH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Jan 2005 07:23:07 -0500
Received: from mx1.elte.hu ([157.181.1.137]:18061 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S262135AbVATMXC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Jan 2005 07:23:02 -0500
Date: Thu, 20 Jan 2005 13:22:54 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [patch] minor spinlock cleanups
Message-ID: <20050120122254.GA6297@elte.hu>
References: <20050120114317.GA29876@elte.hu> <20050120115947.GA31305@elte.hu> <20050120120905.GA3493@elte.hu> <20050120121813.GA4838@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050120121813.GA4838@elte.hu>
User-Agent: Mutt/1.4.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


cleanup: remove stale semicolon from linux/spinlock.h and stale space
from asm-i386/spinlock.h.

	Ingo

Signed-off-by: Ingo Molnar <mingo@elte.hu>

--- linux/include/linux/spinlock.h.orig
+++ linux/include/linux/spinlock.h
@@ -202,7 +202,7 @@ typedef struct {
 #define _raw_spin_lock(lock)	do { (void)(lock); } while(0)
 #define spin_is_locked(lock)	((void)(lock), 0)
 #define _raw_spin_trylock(lock)	(((void)(lock), 1))
-#define spin_unlock_wait(lock)	(void)(lock);
+#define spin_unlock_wait(lock)	(void)(lock)
 #define _raw_spin_unlock(lock) do { (void)(lock); } while(0)
 #endif /* CONFIG_DEBUG_SPINLOCK */
 
--- linux/include/asm-i386/spinlock.h.orig
+++ linux/include/asm-i386/spinlock.h
@@ -92,7 +92,7 @@ static inline void spin_unlock_wait(spin
  * (except on PPro SMP or if we are using OOSTORE)
  * (PPro errata 66, 92)
  */
- 
+
 #if !defined(CONFIG_X86_OOSTORE) && !defined(CONFIG_X86_PPRO_FENCE)
 
 #define spin_unlock_string \
