Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292915AbSCJJ12>; Sun, 10 Mar 2002 04:27:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292924AbSCJJ1S>; Sun, 10 Mar 2002 04:27:18 -0500
Received: from rj.sgi.com ([204.94.215.100]:64710 "EHLO rj.sgi.com")
	by vger.kernel.org with ESMTP id <S292915AbSCJJ1K>;
	Sun, 10 Mar 2002 04:27:10 -0500
Date: Sun, 10 Mar 2002 01:26:55 -0800 (PST)
From: Samuel Ortiz <sortiz@dbear.engr.sgi.com>
To: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
cc: =?ISO-8859-1?Q?Dieter_N=FCtzel?= <Dieter.Nuetzel@hamburg.de>,
        Linux Kernel List <linux-kernel@vger.kernel.org>,
        Andrea Arcange <andrea@suse.de>, Ingo Molnar <mingo@elte.hu>,
        Robert Love <rml@tech9.net>, Oleg Drokin <green@namesys.com>
Subject: Re: 23 second kernel compile (aka which patches help scalibility on
 NUMA)
In-Reply-To: <135154151.1015676353@[10.10.2.3]>
Message-ID: <Pine.LNX.4.33.0203100120290.26154-100000@dbear.engr.sgi.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 9 Mar 2002, Martin J. Bligh wrote:

> > -rmap later for 2.5.x.
>
> rmap has the huge advantage that it's much easier to split
> up the pagemap_lru_lock per zone, do per node kswapd without
> much remote referencing, etc. Remeber this is NUMA with a
> remote:local mem latency of 10:1 to 20:1. Non-local access
> hurts. If we can fix some of the scaling problems with rmap,
> I expect that to be the real way to fix some of the harder
> "global stuff is bad" problems.
Martin, I wrote a patch in order to have a kswap daemon per node. Each
daemon swaps pages out only from its node. It might be of some interest
for your scalability problem, so let me know if you're interested in it (I
can't paste it here because it has also some other stuffs in it, and I
have to split the patch in several parts. I also need to port it to -rmap).

Cheers,
Samuel.

