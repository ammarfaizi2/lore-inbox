Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161190AbWFVTF2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161190AbWFVTF2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jun 2006 15:05:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161208AbWFVTF2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jun 2006 15:05:28 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:63379 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S1161190AbWFVTF1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jun 2006 15:05:27 -0400
Date: Thu, 22 Jun 2006 19:47:10 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Dave Jones <davej@redhat.com>, Pavel Machek <pavel@ucw.cz>,
       "linux-os (Dick Johnson)" <linux-os@analogic.com>,
       Andreas Mohr <andi@rhlx01.fht-esslingen.de>,
       linux-kernel@vger.kernel.org
Subject: Re: [RFC/SERIOUS] grilling troubled CPUs for fun and profit?
Message-ID: <20060622174710.GC2959@openzaurus.ucw.cz>
References: <20060619191543.GA17187@rhlx01.fht-esslingen.de> <Pine.LNX.4.61.0606191542050.4926@chaos.analogic.com> <20060619202354.GD26759@redhat.com> <20060619222528.GC1648@openzaurus.ucw.cz> <20060619224130.GA17134@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060619224130.GA17134@redhat.com>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

>  > > Another anecdote: Upon fan failure, I once had an athlon MP *completely shatter*
>  > > (as in broke in two pieces) under extreme heat.
>  > > 
>  > > This _does_ happen.
>  > 
>  > If it happens to you... you needed a new cpu anyway. Anything non-historical
>  > *has* thermal protection.
> 
> That's the single dumbest thing I've read today.

Sorry to upset you.

> newsflash: you don't get to dictate when I (or anyone else) buys new hardware.
> Before its accident, that box happily was my home firewall for 3 years, and
> its replacement is actually an /older/ box.  I didn't "need a new cpu" at all.
> 

Yep, it is bad... broken machines die. And while proposed patches
probably will not hurt, I do not think they will help, and I do not think
anyone will ever *test* them.

>  > BTW I doubt those old athlons can be saved by cli; hlt . (Someone willing to try if old
>  > athlon can run cli; hlt code w/o heatsink?).
> 
> you snipped the important part of my mail.
> 
> "cpu_relax() and friends aren't going to save a box"
> 
> We have two completely different things being discussed in this thread.
> 
> 1. Fan failure, and the possibility to keep running.
> IMO, there's nothing we can do here, and nor should we try.

Agreed... so you  know that proposed patch would probably not prevent your old
box from self-destructing?

> 2. Situations where we forcibly lock up and spin the CPU in a tight loop,
> producing heat.  Given there are CPUs that benefit from cpu_relax()
> in such places, adding them so that they don't unnecessarily sit there
> sucking power until someone gets to the datacenter to investigate
> can only be a good thing.

Are you sure that cpu_relax actually does somenthing on pre-pentium-4 machines?

>  > And no, we probably do not want to enter C2 or C3 from doublefault handler.
> 
> I didn't see that being proposed.

Good. 
			Pavel
-- 
64 bytes from 195.113.31.123: icmp_seq=28 ttl=51 time=448769.1 ms         

