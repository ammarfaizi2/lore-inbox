Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129600AbQKJQZK>; Fri, 10 Nov 2000 11:25:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130205AbQKJQZA>; Fri, 10 Nov 2000 11:25:00 -0500
Received: from TSX-PRIME.MIT.EDU ([18.86.0.76]:41360 "HELO tsx-prime.MIT.EDU")
	by vger.kernel.org with SMTP id <S129600AbQKJQY5>;
	Fri, 10 Nov 2000 11:24:57 -0500
Date: Fri, 10 Nov 2000 11:24:28 -0500
Message-Id: <200011101624.LAA22004@tsx-prime.MIT.EDU>
From: "Theodore Y. Ts'o" <tytso@MIT.EDU>
To: richardj_moore@uk.ibm.com
CC: "Theodore Y. Ts'o" <tytso@MIT.EDU>, Paul Jakma <paulj@itg.ie>,
        Michael Rothwell <rothwell@holly-springs.nc.us>,
        Christoph Rohland <cr@sap.com>, linux-kernel@vger.kernel.org
In-Reply-To: richardj_moore@uk.ibm.com's message of Fri, 10 Nov 2000 11:41:09
	+0000, <80256993.0047077C.00@d06mta06.portsmouth.uk.ibm.com>
Subject: Re: [ANNOUNCE] Generalised Kernel Hooks Interface (GKHI)
Phone: (781) 391-3464
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: richardj_moore@uk.ibm.com
   Date: 	Fri, 10 Nov 2000 11:41:09 +0000

   It has the potential to to make patches easier to re-work for different
   kernel versions, and to enable development maintence and fixing of the
   patch to be done independently of a kernel build. And it also has the
   potential of helping with co-existence. If for example the RAS community
   could agree on a number of hooks (I'm thinking here of crash dump, trace,
   dprobes and maybe KDB as well) then you'd probably find a good may on them
   using then same hooks. The modifications to the kernel would be minimal and
   the user would be left an easy means of installing a co-existing subset of
   the offerings supported by hooks.

   An example: DProbes is down to three hooks - that's three lines of code in
   the kernel + three lines in ksyms.c

   Patching DProbes onto any custom kernel is a doddle.

Right.  So what you're saying is that GKHI is adding complexity to the
kernel to make it easier for peopel to put in non-standard patches which
exposes non-standard interfaces which will lead to kernels not supported
by the Linux Kernel Development Community.  Right?

Alternatively, you can argue for specific hooks, and try to see if you
can convince the Kernel Developers (and Linus Torvalds, in
particular) that such hooks are good public interfaces, and that adding
such interfaces are a Good Thing.  If such hooks are agreed to, then the
GKHI might be a good wya of implementing these hooks.

But if there are no standard hooks in the mainline kernel, it's going to
be hard to pursuade people that adding the GKHI would be a good thing.
So for the purposes of getting GKHI into the kernel, argueing for GKHI
in the abstract is putting the card before the horse.  What I would
recommend is showing how certain hooks are good things to have in the
mainline kernel, and to try to pursuade people of that question first.
Only then try to argue for GKHI.

						- Ted

P.S.  There are some such RAS features which I wouldn't be surprised
there being interest in having integrated into the kernel directly
post-2.4, with no need to put in "kernel hooks" for that particular
feature.  A good example of that would be kernel crash dumps.  For all
Linux houses which are doing support of customers remotely, being able
to get a crash dump so that developers can investigate a problem
remotely instead of having to fly a developer out to the customer site
is invaluable.  In fact, it might be considerd more valuable than the
kernel debugger....
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
