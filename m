Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316715AbSFVBwK>; Fri, 21 Jun 2002 21:52:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316721AbSFVBwJ>; Fri, 21 Jun 2002 21:52:09 -0400
Received: from pimout3-ext.prodigy.net ([207.115.63.102]:31695 "EHLO
	pimout3-int.prodigy.net") by vger.kernel.org with ESMTP
	id <S316715AbSFVBwI>; Fri, 21 Jun 2002 21:52:08 -0400
Message-Id: <200206220151.g5M1prI260344@pimout3-int.prodigy.net>
Content-Type: text/plain;
  charset="iso-8859-1"
From: Rob Landley <landley@trommello.org>
To: Martin Dalecki <dalecki@evision-ventures.com>,
       Cort Dougan <cort@fsmlabs.com>
Subject: Re: latest linus-2.5 BK broken
Date: Fri, 21 Jun 2002 15:53:32 -0400
X-Mailer: KMail [version 1.3.1]
Cc: "Eric W. Biederman" <ebiederm@xmission.com>,
       Benjamin LaHaise <bcrl@redhat.com>,
       Rusty Russell <rusty@rustcorp.com.au>, Robert Love <rml@tech9.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.44.0206191018510.2053-100000@home.transmeta.com> <20020620103003.C6243@host110.fsmlabs.com> <3D123DB9.8090909@evision-ventures.com>
In-Reply-To: <3D123DB9.8090909@evision-ventures.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 20 June 2002 04:40 pm, Martin Dalecki wrote:
> U¿ytkownik Cort Dougan napisa³:
> > "Beating the SMP horse to death" does make sense for 2 processor SMP
> > machines.  When 64 processor machines become commodity (Linux is a
> > commodity hardware OS) something will have to be done.  When research
>
> 64 processor machines will *never* become a commodity becouse:
>
> 1. It's not like paralell machines are something entierly new. They are
> around for an awfoul long time on this planet. (nearly longer then myself)
>
> 2. See 1. even dual CPU machines are a rarity even *now*.

DOS was a reverse engineered clone of CP/M with some unix features bolted on 
in the early 80's.  Dos couldn't multitask on a single CPU.  Dos couldn't 
handle more than one video card.  DOS could barely keep track of more than 
one hard drive.

Windows 3.1 through Windows 98 (and bill gates' 1/8 scale clone wini-me) were 
based on DOS, they couldn't take advantage of SMP if their life depended on 
it.  NT through 4.0 had a market share dwarfed by the macintosh.

> 3. Nobody needs them for the usual tasks they are a *waste*
> of resources and economics still applies.

Until moore's law hits atomic resolution, sure.  How long that will take is 
hotly debated...

> 4. SMP doesn't scale behind 4. Point. (64 hardly makes sense...)

Actually it does, just not with Intel's brain dead memory bus architecture.  
EV6 goes to 32-way pretty well.

The question is, at what point is it cheaper to just go to NUMA or clusters.  
(And at what point do your trace lengths get long enough that SMP starts 
acting like NUMA.  And at what point do your cluster interconnects get fast 
enough that something like mosix starts acting like numa?)

And the REALLY interesting advance is SMT (hyper-threading), rather than SMP. 
 How do you go beyond the athlon's three execution cores without running out 
of parallel instructions to feed them?  Simple, teach the chip about 
processes, so it can advance multiple points of execution to keep the cores 
fed.  This lets you throw a higher transistor budget at the L1 and L2 caches 
without encountering diminishing returns as well.  It's pretty 
straightforward, and at the very least allows dispatching interrupts in 
parallel and lets your GUI overlap drawing on the screen with the processing 
to figure out what goes on the screen.  Between the two of them, even X11 
might finally give me smooth mouse scrolling, one of these days... :)

SMP on a chip really is overkill. Why give the multiple processors their own 
cache and memory bus interface?  Waste of transistors, power, heat, etc...  
SMT is minimalist SMP on a chip...

> 5. It will never become a commodity to run highly transactional
> workloads where integrated bunches of 4 make sense. Neiter will
> it be common to solve partial differential equations for aeroplane
> dynamics or to calculate the behaviour of an hydrogen bomb.

No, but it will be common to display bidirectional MP4 compressed video 
through an encrypted link, with sound, quite possibly in a window while you 
do other stuff with the machine.  And some day voice recognition may actually 
replace "the clapper" to turn your light off when you get into bed at night...

> One exception could be dedicated rendering CPUs - which is the
> direction where graphics cards are apparently heading - but they

"heading"?  Headed.  (What did you think your 3D accelerator card was?)

> PS. I'm sick of seeing bunches of PC's which are accidentally in
> the same room nowadays in the list of the 500 fastest computers
> on the world. It makes this list useless...

It shows who has money to throw at the problem, and approximately how much, 
which is all it ever really showed...

> If one want's to have a grasp on how the next generation of
> really fast computers will look alike. Well: they will be based
> on Johnson-junctions. TRW will build them (same company
> as Voyager sonde). Look there they don't plan for thousands of CPUs
> they plan for few CPUs in liquid helium:
>
> http://www.trw.com/extlink/1,,,00.html?ExternalTRW=/images/imaps_2000_paper
>.pdf&DIR=2

And cray bathed their circuitry in flourinert decades ago.  Liquid Helium 
ain't winding up on my desktop any time soon, and my laptop outperforms a 
cray-1, and I use it for a dozen variations of text editing (coding, 
email...)  Not interesting.

Rob
