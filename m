Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261193AbTKXVzZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Nov 2003 16:55:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261240AbTKXVzZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Nov 2003 16:55:25 -0500
Received: from web40904.mail.yahoo.com ([66.218.78.201]:35516 "HELO
	web40904.mail.yahoo.com") by vger.kernel.org with SMTP
	id S261193AbTKXVzS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Nov 2003 16:55:18 -0500
Message-ID: <20031124215517.3538.qmail@web40904.mail.yahoo.com>
Date: Mon, 24 Nov 2003 13:55:17 -0800 (PST)
From: Bradley Chapman <kakadu_croc@yahoo.com>
Subject: Re: What exactly are the issues with 2.6.0-test10 preempt?
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.44.0311242240410.2874-100000@poirot.grange>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mr. Liakhovetski,

--- Guennadi Liakhovetski <g.liakhovetski@gmx.de> wrote:
> On Mon, 24 Nov 2003, Bradley Chapman wrote:
> 
> > Hmmm. This is what I have enabled under "Kernel hacking":
> >
> > #
> > # Kernel hacking
> > #
> > CONFIG_DEBUG_KERNEL=y
> > CONFIG_DEBUG_STACKOVERFLOW=y
> > CONFIG_DEBUG_SLAB=y
> > CONFIG_DEBUG_IOVIRT=y
> > CONFIG_MAGIC_SYSRQ=y
> > CONFIG_DEBUG_SPINLOCK=y
> > # CONFIG_DEBUG_PAGEALLOC is not set
>     ^^^^^^^^^^^^^^^^^^^^^^
> 
> Here's a candidate. I did have it on. Yes, I know it causes a slowdown -
> that was for testing. I could try to double check, if disabling that
> single option fixes the problem - but for that I'd need to recompile and
> re-install kernel and modules... I also didn't have
> CONFIG_DEBUG_STACKOVERFLOW switched on - but I don't think that could be
> the reason.

I've never enabled CONFIG_DEBUG_PAGEALLOC - the slowdown bit in the help text
never gave me a warm&fuzzy. If CONFIG_PREEMPT=y && CONFIG_DEBUG_PAGEALLOC=y,
perhaps the pagealloc debug code is exposing a messed-up preempt somewhere near
a memory allocation (IANAKC).

I found the thread regarding slab Oopsen where Linus mentioned CONFIG_PREEMPT
as a possiblity, but I'm not experiencing any issues with -test10 or -test9-bk22.
So I don't think the bug in that thread is affecting me at all, if it hasn't been
fixed.

> 
> > # CONFIG_DEBUG_INFO is not set
> > CONFIG_DEBUG_SPINLOCK_SLEEP=y
> > # CONFIG_FRAME_POINTER is not set
> > CONFIG_X86_EXTRA_IRQS=y
> > CONFIG_X86_FIND_SMP_CONFIG=y
> > CONFIG_X86_MPPARSE=y
> >
> > So far, though, not a single problem -- I was playing Flash animations while
> > printing a huge document without a single hiccup (I have an HP DeskJet 880C with
> > very little memory, so there was a lot of in-kernel activity).
> 
> Guennadi

Brad


=====


__________________________________
Do you Yahoo!?
Free Pop-Up Blocker - Get it now
http://companion.yahoo.com/
