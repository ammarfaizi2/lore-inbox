Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266879AbUIJIB6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266879AbUIJIB6 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Sep 2004 04:01:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267205AbUIJIB5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Sep 2004 04:01:57 -0400
Received: from ozlabs.org ([203.10.76.45]:16593 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S266879AbUIJIBo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Sep 2004 04:01:44 -0400
Date: Fri, 10 Sep 2004 17:56:54 +1000
From: Anton Blanchard <anton@samba.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: William Lee Irwin III <wli@holomorphy.com>,
       Paul Mackerras <paulus@samba.org>,
       Zwane Mwaikambo <zwane@linuxpower.ca>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Matt Mackall <mpm@selenic.com>,
       "Nakajima, Jun" <jun.nakajima@intel.com>
Subject: Re: [PATCH][5/8] Arch agnostic completely out of line locks / ppc64
Message-ID: <20040910075654.GL11358@krispykreme>
References: <20040909154259.GE11358@krispykreme> <20040909171954.GW3106@holomorphy.com> <16704.52551.846184.630652@cargo.ozlabs.ibm.com> <20040909220040.GM3106@holomorphy.com> <16704.59668.899674.868174@cargo.ozlabs.ibm.com> <20040910000903.GS3106@holomorphy.com> <Pine.LNX.4.58.0409091712270.5912@ppc970.osdl.org> <20040910003505.GG11358@krispykreme> <Pine.LNX.4.58.0409091750300.5912@ppc970.osdl.org> <20040910032313.GJ11358@krispykreme>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040910032313.GJ11358@krispykreme>
User-Agent: Mutt/1.5.6+20040818i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 
I forgot to remove the no longer used __preempt_*_lock prototypes.

Signed-off-by: Anton Blanchard <anton@samba.org>

diff -puN include/linux/spinlock.h~fix_preempt include/linux/spinlock.h
--- foobar2/include/linux/spinlock.h~fix_preempt	2004-09-10 17:45:47.600637107 +1000
+++ foobar2-anton/include/linux/spinlock.h	2004-09-10 17:45:54.710204190 +1000
@@ -405,11 +405,6 @@ do { \
 
 /* Where's read_trylock? */
 
-#if defined(CONFIG_SMP) && defined(CONFIG_PREEMPT)
-void __preempt_spin_lock(spinlock_t *lock);
-void __preempt_write_lock(rwlock_t *lock);
-#endif
-
 #define spin_lock(lock)		_spin_lock(lock)
 #define write_lock(lock)	_write_lock(lock)
 #define read_lock(lock)		_read_lock(lock)
_
