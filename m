Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318458AbSIKHXW>; Wed, 11 Sep 2002 03:23:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318460AbSIKHXW>; Wed, 11 Sep 2002 03:23:22 -0400
Received: from angband.namesys.com ([212.16.7.85]:17547 "HELO
	angband.namesys.com") by vger.kernel.org with SMTP
	id <S318458AbSIKHXV>; Wed, 11 Sep 2002 03:23:21 -0400
Date: Wed, 11 Sep 2002 11:28:08 +0400
From: Oleg Drokin <green@namesys.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: Robert Love <rml@tech9.net>, Thomas Molina <tmolina@cox.net>,
       linux-kernel@vger.kernel.org
Subject: Re: 2.5 Problem Status Report
Message-ID: <20020911112808.A6341@namesys.com>
References: <20020911110709.A6193@namesys.com> <Pine.LNX.4.44.0209110915140.5546-100000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0209110915140.5546-100000@localhost.localdomain>
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On Wed, Sep 11, 2002 at 09:26:40AM +0200, Ingo Molnar wrote:
> > > >    BUG at kernel/sched.c        open                  10 Sep 2002
> > > What exactly is this?
> > Looks like this is my bugreport for BUG in kernel/sched.c:944 in the middle
> > of partition parsing output on boot.
> > Subject of email was
> > '2.5.34 BUG at kernel/sched.c:944 (partitions code related?)'
> > msgid: 20020910175639.A830@namesys.com
> very strange backtrace:
>  >>EIP; c0115818 <schedule+18/4a0>   <=====
>  Trace; c01053a0 <default_idle+0/40>

I noticed it too.

> i've once seen the 2.5 IDE code doing a schedule_timeout() from an IRQ
> handler, but the above has to be something else. Could you hack sched.c to
> print out the exact preemption count? It could be a preempt-count
> underflow due to an unbalanced spin_unlock, or an inbalanced
> preempt_enable. [or the IRQ code - but i doubt that, we'd have seen

I have preemption disabled.

> problems much earlier if this was the case.]

> Oleg, do you have CONFIG_DEBUG_SPINLOCK enabled? That should catch an
> unbalanced spin_unlock().

Yes, I do.
CONFIG_DEBUG_KERNEL=y
CONFIG_DEBUG_SLAB=y
CONFIG_MAGIC_SYSRQ=y
CONFIG_DEBUG_SPINLOCK=y
CONFIG_DEBUG_HIGHMEM=y

Bye,
    Oleg
