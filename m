Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315265AbSGVA5N>; Sun, 21 Jul 2002 20:57:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315439AbSGVA5N>; Sun, 21 Jul 2002 20:57:13 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:15609 "EHLO
	hermes.mvista.com") by vger.kernel.org with ESMTP
	id <S315265AbSGVA5M>; Sun, 21 Jul 2002 20:57:12 -0400
Subject: Re: [patch] "big IRQ lock" removal, 2.5.27-A9
From: Robert Love <rml@tech9.net>
To: Ingo Molnar <mingo@elte.hu>
Cc: Linus Torvalds <torvalds@transmeta.com>, Christoph Hellwig <hch@lst.de>,
       linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.44.0207220224170.4909-100000@localhost.localdomain>
References: <Pine.LNX.4.44.0207220224170.4909-100000@localhost.localdomain>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 
Date: 21 Jul 2002 18:00:15 -0700
Message-Id: <1027299616.932.5.camel@sinai>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2002-07-21 at 17:31, Ingo Molnar wrote:

> i've done a minor comment update in softirq.c, plus i've written a
> cli-sti-removal.txt guide to help driver writers do the transition:

Nice document.

One more doc correction while we are at it...

	Robert Love

diff -urN linux-2.5.27/Documentation/preempt-locking.txt linux/Documentation/preempt-locking.txt
--- linux-2.5.27/Documentation/preempt-locking.txt	Sat Jul 20 12:11:06 2002
+++ linux/Documentation/preempt-locking.txt	Sun Jul 21 17:59:13 2002
@@ -70,7 +70,8 @@
 preempt_enable()		decrement the preempt counter
 preempt_disable()		increment the preempt counter
 preempt_enable_no_resched()	decrement, but do not immediately preempt
-preempt_get_count()		return the preempt counter
+preempt_check_resched()		if needed, reschedule
+preempt_count()			return the preempt counter
 
 The functions are nestable.  In other words, you can call preempt_disable
 n-times in a code path, and preemption will not be reenabled until the n-th

