Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030285AbWHXEsm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030285AbWHXEsm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Aug 2006 00:48:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030286AbWHXEsm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Aug 2006 00:48:42 -0400
Received: from smtp.osdl.org ([65.172.181.4]:37561 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1030285AbWHXEsm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Aug 2006 00:48:42 -0400
Date: Wed, 23 Aug 2006 21:48:31 -0700
From: Andrew Morton <akpm@osdl.org>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: Edward Falk <efalk@google.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Fix x86_64 _spin_lock_irqsave()
Message-Id: <20060823214831.aa687ebe.akpm@osdl.org>
In-Reply-To: <44ED1891.6090708@yahoo.com.au>
References: <44ED157D.6050607@google.com>
	<44ED1891.6090708@yahoo.com.au>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 24 Aug 2006 13:10:09 +1000
Nick Piggin <nickpiggin@yahoo.com.au> wrote:

> Edward Falk wrote:
> > Add spin_lock_string_flags and _raw_spin_lock_flags() to 
> > asm-x86_64/spinlock.h so that _spin_lock_irqsave() has the same 
> > semantics on x86_64 as it does on i386 and does *not* have interrupts 
> > disabled while it is waiting for the lock.
> > 
> > This fix is courtesy of Michael Davidson
> 
> So, what's the bug? You shouldn't rely on these semantics anyway
> because you should never expect to wait for a spinlock for so long
> (and it may be the case that irqs can't be enabled anyway).
> 
> BTW. you should be cc'ing Andi Kleen (x86+/-64 maintainer) on
> this type of stuff.
> 
> No comments on the merits of adding this feature. I suppose parity
> with i386 is a good thing, though.
> 

We put this into x86 ages ago and Andi ducked the x86_64 patch at the time.

I don't recall any reports about the x86 patch (Zwane?) improving or
worsening anything.  I guess there are some theoretical interrupt latency
benefits.

