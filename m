Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317913AbSGKVZl>; Thu, 11 Jul 2002 17:25:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317914AbSGKVZk>; Thu, 11 Jul 2002 17:25:40 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:12787 "EHLO
	hermes.mvista.com") by vger.kernel.org with ESMTP
	id <S317913AbSGKVZj>; Thu, 11 Jul 2002 17:25:39 -0400
Subject: Re: Q: preemptible kernel and interrupts consistency.
From: Robert Love <rml@tech9.net>
To: Oleg Nesterov <oleg@tv-sign.ru>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <3D2DF64D.838BD6D6@tv-sign.ru>
References: <3D2DEB91.57FA34E6@tv-sign.ru>
	<1026420107.1178.279.camel@sinai>  <3D2DF64D.838BD6D6@tv-sign.ru>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 
Date: 11 Jul 2002 14:28:24 -0700
Message-Id: <1026422904.1244.294.camel@sinai>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2002-07-11 at 14:19, Oleg Nesterov wrote:

> Safe? Look, if process does not hold any spinlock and interrupts
> disabled, then any distant implicit call to resched_task() silently
> enables irqs. At least, this must be documented.

If interrupts are disabled, where is this distant implicit call from
resched_task() coming from?

That was my point, aside from interrupt handlers all the
need_resched-touching code is in sched.c and both Ingo and I verified
everything is locked.

If interrupts are disabled, there are no interrupts handlers.  And if
you are in an interrupt handler, preemption is already disabled.

	Robert Love

