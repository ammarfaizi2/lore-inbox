Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263298AbTL2Msd (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Dec 2003 07:48:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263310AbTL2Msd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Dec 2003 07:48:33 -0500
Received: from gprs214-59.eurotel.cz ([160.218.214.59]:28032 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S263298AbTL2Msa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Dec 2003 07:48:30 -0500
Date: Mon, 29 Dec 2003 13:49:14 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Nick Piggin <piggin@cyberone.com.au>
Cc: Con Kolivas <kernel@kolivas.org>,
       linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.6.0 batch scheduling, HT aware
Message-ID: <20031229124914.GA317@elf.ucw.cz>
References: <200312231138.21734.kernel@kolivas.org> <20031226225652.GE197@elf.ucw.cz> <200312271042.55989.kernel@kolivas.org> <20031227110903.GA1413@elf.ucw.cz> <3FEFD18D.3070608@cyberone.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3FEFD18D.3070608@cyberone.com.au>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> >>>BTW this is going to be an issue even on normal (non-HT)
> >>>systems. Imagine memory-bound scientific task on CPU0 and nice -20
> >>>memory-bound seti&home at CPU1. Even without hyperthreading, your
> >>>scientific task is going to run at 50% of speed and seti&home is going
> >>>to get second half. Oops.
> >>>
> >>>Something similar can happen with disk, but we are moving out of
> >>>cpu-scheduler arena with that.
> >>>
> >>>[I do not have SMP nearby to demonstrate it, anybody wanting to
> >>>benchmark a bit?]
> >>>
> >>This is definitely the case but there is one huge difference. If you have 
> >>2x1Ghz non HT processors then the fastest a single threaded task can run 
> >>is at 1Ghz. If you have 1x2Ghz HT processor the fastest a single threaded 
> >>task can run is 2Ghz. 
> >>
> >
> >Well, gigaherz is not the *only* important thing.
> >
> >On 2x1GHz, 2GB/sec RAM bandwidth, fastest a single threaded task can
> >run is 1GHz, 2GB/sec. If you run two of them, it is 1GHz,
> >*1*GB/sec. So you still have effect similar to hyperthreading. And
> >yes, it can be measured.
> >
> 
> Hi Pavel,
> Sure this might be a real problem sometimes, but I don't see the
> CPU scheduler ever handling it unless we want to add a few kitchen
> sinks to its nice lean code as well.

Why is it a problem? If you are handling HT case, anyway, it should be
fairly easy to say "imagine it is HT system, not SMP one", and poof,
problem magically goes away.
								Pavel

/*
 *  .----~~|
 *  \      |
 *   ~~~~~~
 */

[Ready-made kitchen-sink for scheduler :-)))]
-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
