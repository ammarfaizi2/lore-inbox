Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932201AbWF3UV0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932201AbWF3UV0 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Jun 2006 16:21:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932217AbWF3UV0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Jun 2006 16:21:26 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:21128
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S932201AbWF3UVZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Jun 2006 16:21:25 -0400
Date: Fri, 30 Jun 2006 13:21:28 -0700 (PDT)
Message-Id: <20060630.132128.26278530.davem@davemloft.net>
To: rmk+lkml@arm.linux.org.uk
Cc: tglx@linutronix.de, mingo@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: SA_TRIGGER_* vs. SA_SAMPLE_RANDOM
From: David Miller <davem@davemloft.net>
In-Reply-To: <20060630184745.GA13429@flint.arm.linux.org.uk>
References: <20060629.141703.59468770.davem@davemloft.net>
	<1151676007.25491.712.camel@localhost.localdomain>
	<20060630184745.GA13429@flint.arm.linux.org.uk>
X-Mailer: Mew version 4.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Russell King <rmk+lkml@arm.linux.org.uk>
Date: Fri, 30 Jun 2006 19:47:45 +0100

> On Fri, Jun 30, 2006 at 04:00:07PM +0200, Thomas Gleixner wrote:
> > We have the same hassle with SA_INTERRUPT. The question arises, if we
> > should move the SA_XX flags for interrupts completely out of the signal
> > SA name space. Rename to IRQ_xxx and put them into interrupt.h.
> 
> It would probably be sensible, but isn't there rather a lot of
> drivers to update?  We could do it as a transitional thing -
> #define the old SA_* names to the new in interrupt.h for a while.

This seems like a sane plan.

Someone skilled in sed and awk could probably do the whole
current tree up in a short amount of time though :-)

I would then only keep the existing defines around for the
sake of being polite to out-of-tree folks :)  Put them in
the deprecation schedule, then zap them for good a few months
from now.

