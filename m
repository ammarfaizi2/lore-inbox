Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261491AbVASDIG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261491AbVASDIG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Jan 2005 22:08:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261550AbVASDHl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Jan 2005 22:07:41 -0500
Received: from ipcop.bitmover.com ([192.132.92.15]:45463 "EHLO
	work.bitmover.com") by vger.kernel.org with ESMTP id S261491AbVASDHQ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Jan 2005 22:07:16 -0500
Date: Tue, 18 Jan 2005 19:05:06 -0800
From: Larry McVoy <lm@bitmover.com>
To: Linus Torvalds <torvalds@osdl.org>
Cc: davidm@hpl.hp.com, carl.staelin@hp.com, "Luck, Tony" <tony.luck@intel.com>,
       lmbench-users@bitmover.com, linux-ia64@vger.kernel.org,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [Lmbench-users] Re: pipe performance regression on ia64
Message-ID: <20050119030506.GA19700@work.bitmover.com>
Mail-Followup-To: Larry McVoy <lm@work.bitmover.com>,
	Linus Torvalds <torvalds@osdl.org>, davidm@hpl.hp.com,
	carl.staelin@hp.com, "Luck, Tony" <tony.luck@intel.com>,
	lmbench-users@bitmover.com, linux-ia64@vger.kernel.org,
	Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <200501181741.j0IHfGf30058@unix-os.sc.intel.com> <Pine.LNX.4.58.0501180951050.8178@ppc970.osdl.org> <16877.21998.984277.551515@napali.hpl.hp.com> <Pine.LNX.4.58.0501181200460.8178@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0501181200460.8178@ppc970.osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

It would be good if you copied me directly since I don't read the kernel
list anymore (I'd love to but don't have the bandwidth) and I rarely read
the lmbench list.  But only if you want to drag me into it, of course.

Carl and I both work on LMbench but not very actively.  I had really 
hoped that once people saw how small the benchmarks are they would
create their own:

work ~/LMbench2/src wc bw_pipe.c 
    120     340    2399 bw_pipe.c

I'm very unthrilled with the idea of adding stuff to the release benchmark
which is OS specific.  That said, there is nothing to say that you can't
grab the benchmark and tweak your own test case in there to prove or 
disprove your theory.

If you want to take LMbench and turn it into LinuxBench or something like
that so that it is clear that it is just a regression test for Linux then
hacking in a bunch of tests would make a ton of sense.

But, if you keep it generic I can give you output on a pile of different
OS's on relatively recent hardware since we just upgraded our build 
cluster:

Welcome to redhat52.bitmover.com, a 2.1Ghz Athlon running Red Hat 5.2.
Welcome to redhat62.bitmover.com, a 2.16Ghz Athlon running Red Hat 6.2.
Welcome to redhat71.bitmover.com, a 2.1Ghz Athlon running Red Hat 7.1.
Welcome to redhat9.bitmover.com, a 2.1Ghz Athlon running Red Hat 9.
Welcome to amd64.bitmover.com, a 2Ghz AMD 64 running Fedora Core 1.
Welcome to parisc.bitmover.com, a 552Mhz PA8600 running Debian 3.1
Welcome to ppc.bitmover.com, a 400Mhz PowerPC running Yellow Dog 1.2.
Welcome to macos.bitmover.com, a dual 1.2Ghz G4 running MacOS 10.2.8.
Welcome to sparc.bitmover.com a 440 Mhz Sun Netra T1 running Debian 3.1.
Welcome to alpha.bitmover.com, a 500Mhz AlphaPC running Red Hat 7.2.
Welcome to ia64.bitmover.com, a dual 800Mhz Itanium running Red Hat 7.2.
Welcome to freebsd.bitmover.com, a 2.17Ghz Athlon running FreeBSD 2.2.8.
Welcome to freebsd3.bitmover.com, a 1.8Ghz Athlon running FreeBSD 3.2.
Welcome to freebsd4.bitmover.com, a 1.8Ghz Athlon running FreeBSD 4.1.
Welcome to freebsd5.bitmover.com, a 1.6Ghz Athlon running FreeBSD 5.1.
Welcome to openbsd.bitmover.com, a 2.17Ghz Athlon running OpenBSD 3.4.
Welcome to netbsd.bitmover.com, a 1Ghz Athlon running NetBSD 1.6.1.
Welcome to sco.bitmover.com, a 1.8Ghz Athlon running SCO OpenServer R5.
Welcome to sun.bitmover.com, a 440Mhz Sun Ultra 10 running Solaris 2.6
Welcome to sunx86.bitmover.com, a dual 1Ghz PIII running Solaris 2.7.
Welcome to sgi.bitmover.com, a 195Mhz MIPS IP28 running IRIX 6.5.
Welcome to sibyte.bitmover.com, a dual 800Mhz MIPS running Debian 3.0.
Welcome to hp.bitmover.com, a 552Mhz PA8600 running HP-UX 10.20.
Welcome to hp11.bitmover.com, a dual 550Mhz PA8500 running HP-UX 11.11.
Welcome to hp11-32bit.bitmover.com, a 400Mhz PA8500 running HP-UX 11.11.
Welcome to aix.bitmover.com, a 332Mhz PowerPC running AIX 4.1.5.
Welcome to qube.bitmover.com, a 250Mhz MIPS running Linux 2.0.34.
Welcome to arm.bitmover.com, a 233Mhz StrongARM running Linux 2.2.
Welcome to tru64.bitmover.com, a 600Mhz Alpha running Tru64 5.1B.
Welcome to winxp2.bitmover.com, a 2.1Ghz Athlon running Windows XP.


On Tue, Jan 18, 2005 at 12:17:11PM -0800, Linus Torvalds wrote:
> 
> 
> On Tue, 18 Jan 2005, David Mosberger wrote:
> >
> > >>>>> On Tue, 18 Jan 2005 10:11:26 -0800 (PST), Linus Torvalds <torvalds@osdl.org> said:
> > 
> >   Linus> I don't know how to make the benchmark look repeatable and
> >   Linus> good, though.  The CPU affinity thing may be the right thing.
> > 
> > Perhaps it should be split up into three cases:
> > 
> > 	- producer/consumer pinned to the same CPU
> > 	- producer/consumer pinned to different CPUs
> > 	- producer/consumer lefter under control of the scheduler
> > 
> > The first two would let us observe any changes in the actual pipe
> > code, whereas the 3rd case would tell us which case the scheduler is
> > leaning towards (or if it starts doing something real crazy, like
> > reschedule the tasks on different CPUs each time, we'd see a bandwith
> > lower than case 2 and that should ring alarm bells).
> 
> Yes, that would be good.
> 
> However, I don't know who (if anybody) maintains lmbench any more. It 
> might be Carl Staelin (added to cc), and there used to be a mailing list 
> which may or may not be active any more..
> 
> [ Background for Carl (and/or lmbench-users): 
> 
>   The "pipe bandwidth" test ends up giving wildly fluctuating (and even
>   when stable, pretty nonsensical, since they depend very strongly on the
>   size of the buffer being used to do the writes vs the buffer size in the
>   kernel) numbers purely depending on where the reader/writer got
>   scheduled.
> 
>   So a recent kernel buffer management change made lmbench numbers vary 
>   radically, ranging from huge improvements to big decreases. It would be 
>   useful to see the numbers as a function of CPU selection on SMP (the 
>   same is probably true also for the scheduling latency benchmark, which 
>   is also extremely unstable on SMP).
> 
>   It's not just that it has big variance - you can't just average out many 
>   runs. It has very "modal" operation, making averages meaningless. 
> 
>   A trivial thing that would work for most cases is just a simple (change 
>   the "1" to whatever CPU-mask you want for some case)
> 
> 	long affinity = 1;	/* bitmask: CPU0 only */
> 	sched_setaffinity(0, sizeof(long), &affinity);
> 
>   but I don't know what other OS's do, so it's obviously not portable ]
> 
> Hmm?
> 
> 			Linus
> _______________________________________________
> Lmbench-users mailing list
> Lmbench-users@bitmover.com
> http://bitmover.com/mailman/listinfo/lmbench-users

-- 
---
Larry McVoy                lm at bitmover.com           http://www.bitkeeper.com
