Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276562AbRI2RXS>; Sat, 29 Sep 2001 13:23:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276563AbRI2RXI>; Sat, 29 Sep 2001 13:23:08 -0400
Received: from fenrus.demon.co.uk ([158.152.228.152]:20354 "EHLO
	fenrus.demon.nl") by vger.kernel.org with ESMTP id <S276562AbRI2RW5>;
	Sat, 29 Sep 2001 13:22:57 -0400
From: arjan@fenrus.demon.nl
To: jalvo@mbay.net (John Alvord)
Subject: Re: kernel changes
cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.20.0109290937510.18362-100000@otter.mbay.net>
X-Newsgroups: fenrus.linux.kernel
User-Agent: tin/1.5.8-20010221 ("Blue Water") (UNIX) (Linux/2.4.3-6.0.1 (i586))
Message-Id: <E15nNpb-0002KX-00@fenrus.demon.nl>
Date: Sat, 29 Sep 2001 18:23:15 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <Pine.LNX.4.20.0109290937510.18362-100000@otter.mbay.net> you wrote:

> One aspect that bothers me is the absence of a success criteria.

I disagree here. Red Hat uses "must pass the cerberus test" as one of the
criteria for kernels. The are other similar criteria, most are obvious (must
boot :). All other distributions have similar tests and a few even use the
cerberus testsuite as well.

Maybe your problem is "absence of tests before Linus releases", well 
even that isn't fully true as distros run these tests on -pre kernels as
well (or -ac kernels, which are mostly in sync with -pre kernels)...

> The current competition for best VM is a good example. The fact is that
> every operating system will fail with a high enough load. The best you can
> hope for is a better degradation then the prior release.

There are a few basic creteria here as well, and 2.4.10 fails on some of
them so far:

1) Must not kill processes as long as there is plenty of swap
   or (possibly dirty) cache memory
2) Must not deadlock (as that is a code-bug)
3) Must not livelock without any progress

Note that no 2.4 kernel so far really achieves 1) in the presence of
highmem; the obvious deadlocks are just pushed further by tuning.

> At the moment both 2.4.10 and 2.4.9-ac16 are better then 2.2.19. But
> people keep testing under higher and higher loads and (surprise) they both
> fail... initiating a search for better degradation logic.

2.4.10 isn't better than 2.2.19 given the criteria above. 2.4.10aa2 might
be though... and 2.4.9acX+Rik's patches are solid in testing. 

Greetings,
   Arjan van de Ven



