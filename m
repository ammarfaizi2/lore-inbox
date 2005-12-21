Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964834AbVLUWVl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964834AbVLUWVl (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Dec 2005 17:21:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964836AbVLUWVl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Dec 2005 17:21:41 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:36882 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S964834AbVLUWVk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Dec 2005 17:21:40 -0500
Date: Wed, 21 Dec 2005 22:21:31 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Adrian Bunk <bunk@stusta.de>
Cc: Andrew Morton <akpm@osdl.org>, torvalds@osdl.org,
       linux-kernel@vger.kernel.org, uclinux-v850@lsi.nec.co.jp
Subject: Re: [RFC: 2.6 patch] include/linux/irq.h: #include <linux/smp.h>
Message-ID: <20051221222131.GL1736@flint.arm.linux.org.uk>
Mail-Followup-To: Adrian Bunk <bunk@stusta.de>,
	Andrew Morton <akpm@osdl.org>, torvalds@osdl.org,
	linux-kernel@vger.kernel.org, uclinux-v850@lsi.nec.co.jp
References: <20051221012750.GD5359@stusta.de> <20051221024133.93b75576.akpm@osdl.org> <20051221110421.GA26630@flint.arm.linux.org.uk> <20051221213321.GC3888@stusta.de> <20051221214806.GJ1736@flint.arm.linux.org.uk> <20051221221114.GA3917@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051221221114.GA3917@stusta.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 21, 2005 at 11:11:14PM +0100, Adrian Bunk wrote:
> On Wed, Dec 21, 2005 at 09:48:06PM +0000, Russell King wrote:
> > On Wed, Dec 21, 2005 at 10:33:21PM +0100, Adrian Bunk wrote:
> > > On Wed, Dec 21, 2005 at 11:04:22AM +0000, Russell King wrote:
> > > > On Wed, Dec 21, 2005 at 02:41:33AM -0800, Andrew Morton wrote:
> > > > > Yes, it's basically always wrong to include asm/foo.h when linux/foo.h
> > > > > exists. 
> > > > 
> > > > There's always an exception to every rule.  linux/irq.h is that
> > > > exception for the above rule.
> > > 
> > > Why?
> > 
> > /*
> >  * Please do not include this file in generic code.  There is currently
> >  * no requirement for any architecture to implement anything held
> >  * within this file.
> >  *
> >  * Thanks. --rmk
> >  */
> > 
> > Using linux/irq.h instead of asm/irq.h _breaks_ architectures
> > which do not use the generic irq code.
> > 
> > Basically, linux/irq.h should have been called asm-generic/irq.h.
> 
> I'm not getting your point.

The point is _exactly_ as the above quotation between Andrew Morton
and myself.  I'm sure it's not me being thick because it's absolutely
damned obvious from the above.

Andrew said: "Yes, it's basically always wrong to include asm/foo.h
when linux/foo.h exists."

That statement is a rule.  I assert that this is an incorrect statement
and I assert that there is a proven case where this statement is incorrect.

Hence, to avoid people reading Andrew's misleading statement, I followed
up on precisely _that_ point and _that_ point alone.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
