Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315547AbSFTV1n>; Thu, 20 Jun 2002 17:27:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315593AbSFTV1m>; Thu, 20 Jun 2002 17:27:42 -0400
Received: from [195.63.194.11] ([195.63.194.11]:19460 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S315547AbSFTV1j> convert rfc822-to-8bit; Thu, 20 Jun 2002 17:27:39 -0400
Message-ID: <3D1248BB.6070007@evision-ventures.com>
Date: Thu, 20 Jun 2002 23:27:23 +0200
From: Martin Dalecki <dalecki@evision-ventures.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; pl-PL; rv:1.0.0) Gecko/20020611
X-Accept-Language: pl, en-us
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: Cort Dougan <cort@fsmlabs.com>,
       "Eric W. Biederman" <ebiederm@xmission.com>,
       Benjamin LaHaise <bcrl@redhat.com>,
       Rusty Russell <rusty@rustcorp.com.au>, Robert Love <rml@tech9.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: latest linus-2.5 BK broken
References: <Pine.LNX.4.44.0206201344080.8225-100000@home.transmeta.com>
Content-Type: text/plain; charset=ISO-8859-2; format=flowed
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

U¿ytkownik Linus Torvalds napisa³:
> 
> On Thu, 20 Jun 2002, Martin Dalecki wrote:
> 
>>2. See 1. even dual CPU machines are a rarity even *now*.
> 
> 
> With stuff like HT, you may well not be able to _buy_ an intel desktop
> machine with just "one" CPU.

Linus you forget one simple fact - a HT CPU is *not* two CPUs.
It is one CPU with a slightly better utilization of the
super scalar pipelines. And it's only slightly better.
Just another way of increasind the fill reate of the pipelines
for some specific tasks.

> Get with the flow. The old Windows codebase is dead as far as new machines
> are concerned, which means that there is no reason to hold back any more:
> all OS's support SMP.
> 
> 
>>3. Nobody needs them for the usual tasks they are a *waste*
>>of resources and economics still applies.
> 
> 
> That's a load of bull.

Did I mention that ARMs are the most sold CPUs out there?

> For usual tasks, two CPU's give clearly better responsiveness than one. If
> only because one of them may be doing the computation, and the other may
> be doing GUI.

For the usual task of controlling just the fuel level of the motor
or therlike one CPU makes fine. For the other usual
tasks - well dissect a PCMCIA WLAN card or some reasonable fast
ethernet card or some hard disk. You will find tons of
independant CPUs in your system... but they are hardly SMP
connected. For the other usual task my single Athlon is
just fine. The main argument is yes it makes sense to
use additional CPUs for work offload on dedicated tasks
but the normal case is not to do it SMP way.

> The number of people doing things like mp3 ripping is apparently quite
> high. And it's definitely CPU-intensive.
> 
> Now, I suspect that past two CPU's you won't find much added oomph, but

Well on intel two CPU give you about 1.5 horse power of
a single CPU. On Good SPM systems it's about 1.7.

> the load-balancing of just two is definitely noticeable on a personal
> scale. I just don't want to use UP machines any more unless they have
> other things going for them (ie really really small).
> > 
>>4. SMP doesn't scale behind 4. Point. (64 hardly makes sense...)
> > 
> That's not true either.
> 
> You can easily make _cheap_ hardware scale to 4, no problem. You may not
> want a shared bus, but hey, they's a small implementation detail. Most new
> CPU's have the interconnect hardware on-die (either now or planned).
> 
> Intel made SMP cheap by putting all the glue logic on-chip and in the
> standard chipsets.

Not if I look out to buy a real SMP board. They are still
very expensive in comparision to normal boards. However
indeed they are nowadays affordable.

> And besides, you don't actually need to _scale_ well, if the actual
> incremental costs are low. That's the whole point with the P4-HT, of
> course. Intel claims 5% die area addition for a 30% scaling. They may be

The 30% - I never saw it in the intel paper. I remember they talk
about 20% + something. And 30% is a *peak* value.
The paper in question talks about 12% on average. Awfoul much for
5% die area (2.4 factor win) in esp. if you look at the constant
increase of die area of CPUs in comparision to the speed factoring out
the scaling of the production process. If once factors out
the production process scale modern CPU are wasting transistors like
no good in comparision to they older silbings. (Remember 8088 was
just about 22t transistors and not 140M!).
But it's not much in absolute numbers...

> full of sh*t, of course, and it may be that the added complexity in the
> control logic hurts them in other areas (longer pipeline, whatever), but
> the point is that if it's cheap, the second CPU doesn't have to "scale".

The main hurting point is the quadruple of the correctness testing
effort. Longer pipelines - I hardly think so. The synchronization infrastructure
for out of order execution was already there in the last CPU generation.
This is the reaons why it's so cheap in terms of die estate to add it now.

BTW. Them pulling this trick shows nicely that we are now at a point
where there will be hardly any increase in the deployment of micro scale
paralellity in CPU design nowadays... And not just on behalf of
the CPU - even more importantly you could read it as public admit to the
fact that we are near the end of static optimizations by improvements in
compiler technology as well. Oh the compiler people promise miracles
constantly since the first days of pipeline of course...
In view of this I would  love to see how they intend
to HT the VLSI design of the Itanic :-).



