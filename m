Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268968AbTBXCrb>; Sun, 23 Feb 2003 21:47:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269006AbTBXCrb>; Sun, 23 Feb 2003 21:47:31 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:59404 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S268968AbTBXCra>; Sun, 23 Feb 2003 21:47:30 -0500
Date: Sun, 23 Feb 2003 18:54:41 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: davidm@hpl.hp.com
cc: David Lang <david.lang@digitalinsight.com>, <linux-kernel@vger.kernel.org>
Subject: Re: Minutes from Feb 21 LSE Call
In-Reply-To: <15961.33856.876529.568807@napali.hpl.hp.com>
Message-ID: <Pine.LNX.4.44.0302231840220.1690-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sun, 23 Feb 2003, David Mosberger wrote:
>   >> 2 GHz Xeon:	701 SPECint
>   >> 1 GHz Itanium 2:	810 SPECint
> 
>   >> That is, Itanium 2 is 15% faster.
> 
> Unfortunately, HP doesn't sell 1.5MB/1GHz Itanium 2 workstations, but
> we can do some educated guessing:
> 
>   1GHz Itanium 2, 3MB cache:		810 SPECint
>   900MHz Itanium 2, 1.5MB cache:	674 SPECint
> 
> Assuming pure frequency scaling, a 1GHz/1.5MB Itanium 2 would get
> around 750 SPECint.  In reality, it would get slightly less, but most
> likely substantially more than 701.

And as Dean pointed out:

  2Ghz Xeon MP with 2MB L3 cache:	842 SPECint

In other words, the P4 eats the Itanium for breakfast even if you limit it 
to 2GHz due to some "process" rule.

And if you don't make up any silly rules, but simply look at "what's 
available today", you get

  2.8Ghz Xeon MP with 2MB L3 cache: 	907 SPECint

or even better (much cheaper CPUs):

  3.06 GHz P4 with 512kB L2 cache:	1074 SPECint
  AMD Athlon XP 2800+:			 933 SPECint

These are systems that you can buy today. With _less_ cache, and clearly
much higher performance (the difference between the best-performing
published ia-64 and the best P4 on specint, the P4 is 32% faster. Even 
with the "you can only run the P4 at 2GHz because that is all it ever ran 
at in 0.18" thing the ia-64 falls behind.

>   Linus> The only thing that is meaningful is "performace at the same
>   Linus> time of general availability".
> 
> You claimed that x86 is inherently superior.  I provided data that
> shows that much of this apparent superiority is simply an effect of
> the larger volume that x86 achieves today.

And I showed that your data is flawed. Clearly the P4 outperforms ia-64 
on an architectural level _even_ when taking process into account.

		Linus

