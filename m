Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316322AbSFUG0E>; Fri, 21 Jun 2002 02:26:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316339AbSFUG0D>; Fri, 21 Jun 2002 02:26:03 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:15470 "EHLO
	frodo.biederman.org") by vger.kernel.org with ESMTP
	id <S316322AbSFUG0C>; Fri, 21 Jun 2002 02:26:02 -0400
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Cort Dougan <cort@fsmlabs.com>, Benjamin LaHaise <bcrl@redhat.com>,
       Rusty Russell <rusty@rustcorp.com.au>, Robert Love <rml@tech9.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: latest linus-2.5 BK broken
References: <Pine.LNX.4.44.0206201003500.8225-100000@home.transmeta.com>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 21 Jun 2002 00:15:54 -0600
In-Reply-To: <Pine.LNX.4.44.0206201003500.8225-100000@home.transmeta.com>
Message-ID: <m1r8j1rwbp.fsf@frodo.biederman.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds <torvalds@transmeta.com> writes:

> On Thu, 20 Jun 2002, Cort Dougan wrote:
> >
> > "Beating the SMP horse to death" does make sense for 2 processor SMP
> > machines.
> 
> It makes fine sense for any tightly coupled system, where the tight
> coupling is cost-efficient.
> 
> Today that means 2 CPU's, and maybe 4.
> 
> Things like SMT (Intel calls it "HT") increase that to 4/8. It's just
> _cheaper_ to do that kind of built-in SMP support than it is to not use
> it.
> 
> The important part of what Cort says is "commodity". Not the "small number
> of CPU's". Linux is focusing on SMP, because it is the ONLY INTERESTING
> HARDWARE BASE in the commodity space.

Commodity is the wrong word.  Volume is the right word.  Volumes of machines,
volumes of money, and volumes of developers.

> ccNuma and clusters just aren't even on the _radar_ from a commodity
> standpoint. While commodity 4- and 8-way SMP is just a few years away.

I bet it is easy to find a easy to find a 2-4 way heterogenous pile of
computers in many a developers personal possession that could be turned
into a cluster if the software wasn't so inconvenient to use, or if
there was a good reason to run computer systems that way.

Clusters and ccNuma are entirely different animals.  ccNuma is about
specialized hardware.  Clusters are about using commodity hardware in
a different way.

> So because SMP hardware is cheap and efficient, all reasonable scalability
> work is done on SMP. And the fringe is just that - fringe. The
> numa/cluster fringe tends to try to use SMP approaches because they know
> they are a minority, and they want to try to leverage off the commodity.

The cluster fringe is a minority.  But the high performance computer
and batch scheduling minority has done a lot of work of the
theoretical, and developmental computer science in the past.  And I
would be surprised if they weren't influential in the future.  But
like most research a lot of it is trying suboptimal solutions that
eventually get ditched.

The only SMP like stuff I have seen in clustering are the attempts to
make clusters simpler to use.  And the question I hear is how simple
can we make it without sacrificing scaleabilty.

> And it will continue to be this way for the forseeable future. People
> should just accept the fact.

I apparently see things differently.  That the clusters will be a
minority certainly.  That the people working on them are hopelessly in
fringes not a bit.  

Clusters of Linux machines scale acceptably .  And for a certain set of
people get the job done.  The problem is making it more convenient to
get the job done.  And just like in hardware as integration can make
extra hardware features essentially free, the next step is to begin
integrating cluster features into Linux both kernel and user space.  

Basically the technique is.  Implement something that works.  Then
find the clean efficient way to do it.  If that takes kernel support
write a kernel patch, and get it in.

> And I guarantee Linux will scale up fine to 16 CPU's, once that is
> commodity. And the rest is just not all that important.

It works just fine on my little 20 node 20 kernel test machine too.

I think Larry's perspective is interesting and if the common cluster
software gets working well enough I might even try it.  But until a
big SMP becomes commodity I don't see the point.

Eric
