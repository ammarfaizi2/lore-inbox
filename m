Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261758AbVEPQ7R@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261758AbVEPQ7R (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 May 2005 12:59:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261757AbVEPQ7R
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 May 2005 12:59:17 -0400
Received: from fire.osdl.org ([65.172.181.4]:48611 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261758AbVEPQ6c (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 May 2005 12:58:32 -0400
Date: Mon, 16 May 2005 10:00:20 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Scott Robert Ladd <lkml@coyotegulch.com>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Andi Kleen <ak@muc.de>,
       Gabor MICSKO <gmicsko@szintezis.hu>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Hyper-Threading Vulnerability
In-Reply-To: <4284F6B5.2080308@coyotegulch.com>
Message-ID: <Pine.LNX.4.58.0505160945280.28162@ppc970.osdl.org>
References: <1115963481.1723.3.camel@alderaan.trey.hu>  <m164xnatpt.fsf@muc.de>
 <1116009347.1448.489.camel@localhost.localdomain> <4284F6B5.2080308@coyotegulch.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 13 May 2005, Scott Robert Ladd wrote:
>
> Alan Cox wrote:
> > HT for most users is pretty irrelevant, its a neat idea but the
> > benchmarks don't suggest its too big a hit
> 
> On real-world applications, I haven't seen HT boost performance by more
> than 15% on a Pentium 4 -- and the usual gain is around 5%, if anything
> at all. HT is a nice idea, but I don't enable it on my systems.

HT is _wonderful_ for latency reduction. 

Why people think "performace" means "throughput" is something I'll never
understand. Throughput is _always_ secondary to latency, and really only
becomes interesting when it becomes a latency number (ie "I need higher
throughput in order to process these jobs in 4 hours instead of 8" -
notice how the real issue was again about _latency_).

Now, Linux tends to have pretty good CPU latency anyway, so it's not
usually that big of a deal, but I definitely enjoyed having a HT machine
over a regular UP one. I'm told the effect was even more pronounced on 
XP. 

Of course, these days I enjoy having dual cores more, though, and with
multiple cores, the latency advantages of HT become much less pronounced.

As to the HT "vulnerability", it really seems to be not a whole lot
different than what people saw with early SMP and (small) direct-mapped
caches. Thank God those days are gone.

I'd be really surprised if somebody is actually able to get a real-world
attack on a real-world pgp key usage or similar out of it (and as to the
covert channel, nobody cares). It's a fairly interesting approach, but
it's certainly neither new nor HT-specific, or necessarily seem all that
worrying in real life.

(HT and modern CPU speeds just means that the covert channel is _faster_
than it has been before, since you can test the L1 at core speeds. I doubt
it helps the key attack much, though, since faster in that case cuts both
ways: the speed of testing the cache eviction may have gone up, but so has
the speed of the operation you're trying to follow, and you'd likely have
a really hard time trying to catch things in real life).

It does show that if you want to hide key operations, you want to be 
careful. I don't think HT is at fault per se. 

		Linus
