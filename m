Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268870AbUHUHEj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268870AbUHUHEj (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Aug 2004 03:04:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268872AbUHUHEj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Aug 2004 03:04:39 -0400
Received: from jade.spiritone.com ([216.99.193.136]:52646 "EHLO
	jade.spiritone.com") by vger.kernel.org with ESMTP id S268870AbUHUHEf
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Aug 2004 03:04:35 -0400
Date: Sat, 21 Aug 2004 00:04:21 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: William Lee Irwin III <wli@holomorphy.com>,
       Anton Blanchard <anton@samba.org>
cc: Andrew Morton <akpm@osdl.org>, Jesse Barnes <jbarnes@engr.sgi.com>,
       linux-kernel@vger.kernel.org
Subject: Re: 2.6.8.1-mm3
Message-ID: <307090000.1093071859@[10.10.2.4]>
In-Reply-To: <20040821000343.GR11200@holomorphy.com>
References: <20040820031919.413d0a95.akpm@osdl.org> <200408201144.49522.jbarnes@engr.sgi.com> <200408201257.42064.jbarnes@engr.sgi.com> <20040820115541.3e68c5be.akpm@osdl.org> <20040820200248.GJ11200@holomorphy.com> <20040820233126.GJ1945@krispykreme> <20040821000343.GR11200@holomorphy.com>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--William Lee Irwin III <wli@holomorphy.com> wrote (on Friday, August 20, 2004 17:03:43 -0700):

> At some point in the past, I wrote:
>>> Parallel compilation is an extremely poor benchmark in general, as the
>>> workload is incapable of being effectively scaled to system sizes, the
>>> linking phase is inherently unparallelizable and the compilation phase
>>> too parallelizable to actually stress anything. There is also precisely
>>> zero relevance the benchmark has to anything real users would do.

The compilation phase seems to stress a whole bunch of stuff, primarily
the VM and scheduler, and a little on the VFS. Saying that things are 
"too parallizable" to stress things is odd - that seems to cause more
stress, not less.

> Kernel hacking is not an end in itself, regardless of the fact there
> are some, such as myself, who use computers for no other purpose. A
> real user generally has some purpose to their activity beyond working
> on the software or hardware they are "using". e.g. various real users
> use their systems for entertainment: playing games, music, and movies.
> Others may use their systems to make money somehow, e.g. archiving
> information about customers so they can look up what they've bought
> and paid for or have yet to pay for.
> 
> Regardless of the social issue, the rather serious technical deficits
> of compilation of any software as a benchmark are showstopping issues.
> Frankly, even the issues I've dredged up are nowhere near comprehensive.
> There are further issues such as that stable (i.e. not varying across
> the benchmarks being done on various systems at various times) versions
> of the software being compiled and the toolchain being used to compile
> it are lacking as components of any "kernel compile benchmarking suite"
> and worse still the variance in target architecture of the toolchain
> also defeats any attempt at meaningful benchmarking.

The benchmark is perfectly stable on one machine as long as the user
has some vague grip on the enviroment, and isn't running debian unstable
and auto-updating every night. Benchmarking across arches has always been
done with a target of i386 when Anton and I have done it, and no, it 
doesn't serve much purpose apart from a fun pissing contest. However,
benchmarking different kernels with the same userspace setup on one
machine is perfectly valid, and very useful.
 
> If you're truly concerned about compilation speed, userspace is going
> to be the most productive area to work on anyway, as the vast majority
> of time during compilation is spent in userspace. AIUI the userspace
> algorithms in gcc are not particularly cognizant of cache locality and
> in various instances have suboptimal time and space behavior, so it's
> not as if there isn't work to be done there. Improving the compactness
> and cache locality of data structures is important in userspace also,
> and most (perhaps all) userspace programs are grossly ignorant of this.
> FWIW, there are notable kernel hackers known to use very downrev gcc
> versions due to regressions in compilation speed in subsequent versions,
> so there are already large known differences in compilation speed that
> can be obtained just by choosing a different compiler version.

Altering userspace is of course going to change the result - but has 
absolutely no relevance whatsoever to whether this is a useful benchmark
or not. 

The point is not to compile the kernel - the point is to get a vaguely
realistic simulation of something a user might do to stress the kernel
in interesting ways. At which I think kernbench does reasonably well.
No, it's not perfect, but it's simple, and it's useful - it's led to
many useful improvements already, and no doubt will continue to do so.

All benchmarks are crap. Some are just less crap than others.

M.

compile the kernel, but 
