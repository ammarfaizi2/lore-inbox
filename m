Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268097AbUJGUZn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268097AbUJGUZn (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Oct 2004 16:25:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268051AbUJGUWr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Oct 2004 16:22:47 -0400
Received: from smtp207.mail.sc5.yahoo.com ([216.136.129.97]:36698 "HELO
	smtp207.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S268104AbUJGUUU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Oct 2004 16:20:20 -0400
Subject: Re: strange AMD x Intel Behaviour in 2.4.26
From: Fabiano Ramos <ramos_fabiano@yahoo.com.br>
To: Valdis.Kletnieks@vt.edu
Cc: LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <200410071845.i97Ijcv2025341@turing-police.cc.vt.edu>
References: <1097172936.3832.1.camel@lfs.barra.bali>
	 <200410071845.i97Ijcv2025341@turing-police.cc.vt.edu>
Content-Type: text/plain
Date: Thu, 07 Oct 2004 17:19:36 -0300
Message-Id: <1097180376.4161.3.camel@lfs.barra.bali>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.0 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2004-10-07 at 14:45 -0400, Valdis.Kletnieks@vt.edu wrote:
> On Thu, 07 Oct 2004 15:15:36 -0300, Fabiano Ramos said:
> 
> >   The code is producing correct results (same as ptrace, I mean)
> > but is RUNNING FASTER on a 500Mhz AMD K6-2 than on a 2.6Ghz HT
> > Pentium 4 !!!!  The monitored code runs faster on P4 if not being
> > monitored, as expected.
> 
> Most likely, the old slow AMD chipset doesn't take a big performance
> hit for each of the loops into debug-land, and the P4 chipset takes a
> big hit.  Not sure if it's a pipeline-drain issue, or relative cost
> of L1/2 cache misses, or what - an architecture expert could probably
> say more.  Basically, the AMD goes faster because it has less to forget
> at the end of each counted instruction, while the P4 gains much of its
> speed via a lot of caching/decoding/pipelining tricks, so it has to throw
> away more, and then re-establish state when it comes back.
> 

yes, you are probably right. I thought about that, but in no way
I could imagine such a drastic situation. I was wondering if maybe
the kernel did different things for AMD and Pentium, but both
are treated the same, as a i386, RIGHT?????

I have just tried on another AMD core, a 1Ghz Duron, and it outperforms
the AMD K6 (as expected) and the 2.6Ghz P4 as well, probably due to the
same thing.


> Imagine 2 people walking down a hallway - one moves at 1 mile per hour
> when walking, the other at 5.  However, every third step each of them drops
> the stack of papers they are carrying - and the slow person drops 5 sheets
> of paper and the fast one drops 200.  Who reaches the end of the hall first?
> 
> It's probably sort of like that....

:)

Thanks.

