Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261646AbSJUUhZ>; Mon, 21 Oct 2002 16:37:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261644AbSJUUhZ>; Mon, 21 Oct 2002 16:37:25 -0400
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:4616 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP
	id <S261646AbSJUUhW>; Mon, 21 Oct 2002 16:37:22 -0400
Date: Mon, 21 Oct 2002 16:41:45 -0400 (EDT)
From: Bill Davidsen <davidsen@tmr.com>
To: Rob Landley <landley@trommello.org>
cc: Jurriaan <thunder7@xs4all.nl>,
       Linux-Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Any hope of fixing shutdown power off for SMP?
In-Reply-To: <200210202058.29291.landley@trommello.org>
Message-ID: <Pine.LNX.3.96.1021021163731.4564A-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 20 Oct 2002, Rob Landley wrote:

> On Sunday 20 October 2002 21:45, Bill Davidsen wrote:
> > On Sun, 20 Oct 2002, Jurriaan wrote:

> > > 2.5.43 will power down my smp VP6 board if I replace the BUG() calls in
> > > arch/i386/kernel/apm.c with warnings. Somehow, the kernel doesn't
> > > succesfully schedule itself to run on CPU 0. However, for my bios that
> > > isn't needed.
> >
> > Are you using the real-mode call? Perhaps I should try NOT doing that, and
> > see if it solves the problem. That used to be the solution, but things
> > change.
> 
> None of my systems will power down on UP if I enable the "local apic support 
> on uniprocessors" option.
> 
> Something about the APIC code prevents the power down from occuring.  The 
> symptoms are as you describe: the drives spin down, and the power goes off 
> immediately if you press the button (instead of having to hold it down), but 
> the power doesn't go off by itself.
> 
> Works fine if I compile without local APIC support.

Hum, and you can quote me on that. I don't have that particular problem at
all, my problem is only with SMP. And on several machines I note that the
code to lock up SMP machines unless you use "noapic" isn't compatible with
2.4, haven't had the lockup yet. Wish that would migrate back to 2.4!

Anyway, my kernels are SMP, and if I boot "nosmp" they work fine with
every APIC in sight enabled. This may or may not be the same problem, you
could build an SMP kernel and boot it "nosmp" with APIC on and see what
that does (if you're curious).

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

