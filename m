Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267765AbTBVCPH>; Fri, 21 Feb 2003 21:15:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267769AbTBVCPH>; Fri, 21 Feb 2003 21:15:07 -0500
Received: from virtisp1.zianet.com ([216.234.192.105]:46605 "HELO
	mesatop.zianet.com") by vger.kernel.org with SMTP
	id <S267765AbTBVCPF>; Fri, 21 Feb 2003 21:15:05 -0500
Subject: Re: Minutes from Feb 21 LSE Call
From: Steven Cole <elenstev@mesatop.com>
To: William Lee Irwin III <wli@holomorphy.com>
Cc: Larry McVoy <lm@work.bitmover.com>, Hanna Linder <hannal@us.ibm.com>,
       lse-tech@lists.sf.et, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20030222002555.GC10411@holomorphy.com>
References: <96700000.1045871294@w-hlinder>
	<20030222001618.GA19700@work.bitmover.com> 
	<20030222002555.GC10411@holomorphy.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0.2-5mdk 
Date: 21 Feb 2003 19:24:43 -0700
Message-Id: <1045880685.5611.655.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2003-02-21 at 17:25, William Lee Irwin III wrote:
> On Fri, Feb 21, 2003 at 04:16:18PM -0800, Larry McVoy wrote:
> > Ben is right.  I think IBM and the other big iron companies would be
> > far better served looking at what they have done with running multiple
> > instances of Linux on one big machine, like the 390 work.  Figure out
> > how to use that model to scale up.  There is simply not a big enough
> > market to justify shoveling lots of scaling stuff in for huge machines
> > that only a handful of people can afford.  That's the same path which
> > has sunk all the workstation companies, they all have bloated OS's and
> > Linux runs circles around them.

mjb> Unfortunately, as I've pointed out to you before, this doesn't work
mjb> in practice. Workloads may not be easily divisible amongst 
mjb> machines, and you're just pushing all the complex problems out for
mjb> every userspace app to solve itself, instead of fixing it once in
mjb> the kernel.


Please permit an observer from the sidelines a few comments.
I think all four of you are right, for different reasons.
> 
> Scalability done properly should not degrade performance on smaller
> machines, Pee Cees, or even microscopic organisms.

s/should/must/ in the above.  That must be a guiding principle.

> 
> 
> On Fri, Feb 21, 2003 at 04:16:18PM -0800, Larry McVoy wrote:
> > In terms of the money and in terms of installed seats, the small Linux
> > machines out number the 4 or more CPU SMP machines easily 10,000:1.
> > And with the embedded market being one of the few real money makers
> > for Linux, there will be huge pushback from those companies against
> > changes which increase memory footprint.
> 
> There's quite a bit of commonality with large x86 highmem there, as
> the highmem crew is extremely concerned about the kernel's memory
> footprint and is looking to trim kernel memory overhead from every
> aspect of its operation they can. Reducing kernel memory footprint
> is a crucial part of scalability, in both scaling down to the low end
> and scaling up to highmem. =)
> 
> 
> -- wli

Since the time between major releases of the kernel seems to be two to 
three years now (counting to where the new kernel is really stable), 
it is probably worthwhile to think about what high-end systems will 
be like when 3.0 is expected.

My guess is that a trend will be machines with increasingly greater cpu
counts with access to the same memory.  Why?  Because if it can be done,
it will be done.  The ability to put more cpus on a single chip may
translate into a Moore's law of increasing cpu counts per machine.  And
as Martin points out, the high end machines are where the money is.

In my own unsophisticated opinion, Larry's concept of Cache Coherent
Clusters seems worth further development.  And Martin is right about the
need for fixing it in the kernel, again IMHO.  But how to fix it in the
kernel?  Would something similar to OpenMosix or OpenSSI in a future
kernel be appropriate to get Larry's CCCluster members to cooperate? Or
is it possible to continue the scalability race when cpu counts get to
256, 512, etc.

Just some thoughts from the sidelines.

Best regards,
Steven



