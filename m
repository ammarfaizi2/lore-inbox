Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315517AbSFTUyT>; Thu, 20 Jun 2002 16:54:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315525AbSFTUyT>; Thu, 20 Jun 2002 16:54:19 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:26890 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S315517AbSFTUyS>; Thu, 20 Jun 2002 16:54:18 -0400
Date: Thu, 20 Jun 2002 13:53:57 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Martin Dalecki <dalecki@evision-ventures.com>
cc: Cort Dougan <cort@fsmlabs.com>,
       "Eric W. Biederman" <ebiederm@xmission.com>,
       Benjamin LaHaise <bcrl@redhat.com>,
       Rusty Russell <rusty@rustcorp.com.au>, Robert Love <rml@tech9.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: latest linus-2.5 BK broken
In-Reply-To: <3D123DB9.8090909@evision-ventures.com>
Message-ID: <Pine.LNX.4.44.0206201344080.8225-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 20 Jun 2002, Martin Dalecki wrote:
>
> 2. See 1. even dual CPU machines are a rarity even *now*.

With stuff like HT, you may well not be able to _buy_ an intel desktop
machine with just "one" CPU.

Get with the flow. The old Windows codebase is dead as far as new machines
are concerned, which means that there is no reason to hold back any more:
all OS's support SMP.

> 3. Nobody needs them for the usual tasks they are a *waste*
> of resources and economics still applies.

That's a load of bull.

For usual tasks, two CPU's give clearly better responsiveness than one. If
only because one of them may be doing the computation, and the other may
be doing GUI.

The number of people doing things like mp3 ripping is apparently quite
high. And it's definitely CPU-intensive.

Now, I suspect that past two CPU's you won't find much added oomph, but
the load-balancing of just two is definitely noticeable on a personal
scale. I just don't want to use UP machines any more unless they have
other things going for them (ie really really small).

> 4. SMP doesn't scale behind 4. Point. (64 hardly makes sense...)

That's not true either.

You can easily make _cheap_ hardware scale to 4, no problem. You may not
want a shared bus, but hey, they's a small implementation detail. Most new
CPU's have the interconnect hardware on-die (either now or planned).

Intel made SMP cheap by putting all the glue logic on-chip and in the
standard chipsets.

And besides, you don't actually need to _scale_ well, if the actual
incremental costs are low. That's the whole point with the P4-HT, of
course. Intel claims 5% die area addition for a 30% scaling. They may be
full of sh*t, of course, and it may be that the added complexity in the
control logic hurts them in other areas (longer pipeline, whatever), but
the point is that if it's cheap, the second CPU doesn't have to "scale".

			Linus

