Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751125AbWF3UZP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751125AbWF3UZP (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Jun 2006 16:25:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751126AbWF3UZP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Jun 2006 16:25:15 -0400
Received: from www.osadl.org ([213.239.205.134]:45720 "EHLO mail.tglx.de")
	by vger.kernel.org with ESMTP id S1751125AbWF3UZN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Jun 2006 16:25:13 -0400
Subject: Re: SA_TRIGGER_* vs. SA_SAMPLE_RANDOM
From: Thomas Gleixner <tglx@linutronix.de>
Reply-To: tglx@linutronix.de
To: David Miller <davem@davemloft.net>
Cc: rmk+lkml@arm.linux.org.uk, mingo@redhat.com, linux-kernel@vger.kernel.org
In-Reply-To: <20060630.132128.26278530.davem@davemloft.net>
References: <20060629.141703.59468770.davem@davemloft.net>
	 <1151676007.25491.712.camel@localhost.localdomain>
	 <20060630184745.GA13429@flint.arm.linux.org.uk>
	 <20060630.132128.26278530.davem@davemloft.net>
Content-Type: text/plain
Date: Fri, 30 Jun 2006 22:27:27 +0200
Message-Id: <1151699247.25491.806.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-06-30 at 13:21 -0700, David Miller wrote:
> From: Russell King <rmk+lkml@arm.linux.org.uk>
> Date: Fri, 30 Jun 2006 19:47:45 +0100
> 
> > On Fri, Jun 30, 2006 at 04:00:07PM +0200, Thomas Gleixner wrote:
> > > We have the same hassle with SA_INTERRUPT. The question arises, if we
> > > should move the SA_XX flags for interrupts completely out of the signal
> > > SA name space. Rename to IRQ_xxx and put them into interrupt.h.
> > 
> > It would probably be sensible, but isn't there rather a lot of
> > drivers to update?  We could do it as a transitional thing -
> > #define the old SA_* names to the new in interrupt.h for a while.
> 
> This seems like a sane plan.
> 
> Someone skilled in sed and awk could probably do the whole
> current tree up in a short amount of time though :-)
> 
> I would then only keep the existing defines around for the
> sake of being polite to out-of-tree folks :)  Put them in
> the deprecation schedule, then zap them for good a few months
> from now.

I'll cook it up tomorrow.

	tglx


