Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136177AbRAJVG1>; Wed, 10 Jan 2001 16:06:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132930AbRAJVGT>; Wed, 10 Jan 2001 16:06:19 -0500
Received: from node181b.a2000.nl ([62.108.24.27]:10250 "EHLO ddx.a2000.nu")
	by vger.kernel.org with ESMTP id <S131935AbRAJVGG>;
	Wed, 10 Jan 2001 16:06:06 -0500
Date: Wed, 10 Jan 2001 22:06:27 +0100 (CET)
From: <kernel@ddx.a2000.nu>
To: Hacksaw <hacksaw@hacksaw.org>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: unexplained high load 
In-Reply-To: <Pine.LNX.4.30.0101102159470.4377-100000@ddx.a2000.nu>
Message-ID: <Pine.LNX.4.30.0101102203340.4377-100000@ddx.a2000.nu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

detected this in kernel log :

Jan 10 00:34:15 ddx kernel: Unable to handle kernel paging request in mna
handler<1> at virtual address f7d93ef869a1610c
Jan 10 00:34:15 ddx kernel: current->mm->context = 0000000000000639
Jan 10 00:34:15 ddx kernel: current->mm->pgd = fffff8000c0d2000
Jan 10 00:34:15 ddx kernel:               \|/ ____ \|/
Jan 10 00:34:15 ddx kernel:               "@'/ .. \`@"
Jan 10 00:34:15 ddx kernel:               /_| \__/ |_\
Jan 10 00:34:15 ddx kernel:                  \__U_/
Jan 10 00:34:15 ddx kernel: proftpd(27129): Oops
Jan 10 00:34:15 ddx kernel: TSTATE: 0000000080009602 TPC: 000000000044f8ac
TNPC: 000000000044f8b0 Y: 00000000
Jan 10 00:34:15 ddx kernel: g0: 0000000000000000 g1: 0000000000000001 g2:
0000000000c34000 g3: ffffffffffffe000
Jan 10 00:34:15 ddx kernel: g4: fffff80000000000 g5: 0000000000000000 g6:
fffff8000d8b8000 g7: 0000000000000001
Jan 10 00:34:15 ddx kernel: o0: f7d93ef869a16104 o1: 0000000000000104 o2:
0000000000358d60 o3: fffff80000334000
Jan 10 00:34:15 ddx kernel: o4: fffff8001fe00000 o5: fffff8001fe77c68 sp:
fffff8000d8bb491 ret_pc: 000000000044f828
Jan 10 00:34:15 ddx kernel: l0: fffff8000068cd60 l1: 0000000000000346 l2:
fffff80019d2e600 l3: 0000000000000000
Jan 10 00:34:15 ddx kernel: l4: fffff800156bc000 l5: 0000000000c34000 l6:
fffff8000068cde0 l7: 000000000000026e
Jan 10 00:34:15 ddx kernel: i0: 000000000000026e i1: 0000000070228286 i2:
0000000000000346 i3: 0000000000605c00
Jan 10 00:34:15 ddx kernel: i4: fffff8001fc8b9e0 i5: 0000000000605c00 i6:
fffff8000d8bb561 i7: 000000000049b7ec
Jan 10 00:34:15 ddx kernel: Caller[000000000049b7ec]
Jan 10 00:34:15 ddx kernel: Caller[000000000045954c]
Jan 10 00:34:15 ddx kernel: Caller[0000000000410114]
Jan 10 00:34:15 ddx kernel: Caller[0000000000022bb0]
Jan 10 00:34:15 ddx kernel: Instruction DUMP: d05ca0e0  02c20003  d072c00a
<e0722008> e074a0e0  d05f6100  90022001  d0776100  d25b40



On Wed, 10 Jan 2001 kernel@ddx.a2000.nu wrote:

> On Wed, 10 Jan 2001, Hacksaw wrote:
>
> > > Could someone maybe explain this ?
> > > (top output, but same load is given with 'uptime')
> > > there is no cpu or disk activity
> > > kernel is 2.2.18pre9 on sun ultra10-300 (ultrasparc IIi)
> > >
> > >    9:25pm  up 112 days,  1:52,  1 user,  load average: 1.24, 1.05, 1.02
> > >  91 processes: 90 sleeping, 1 running, 0 zombie, 0 stopped
> > >  CPU states:  2.5% user,  2.3% system,  0.0% nice, 95.1% idle
> > >  Mem:  515144K av, 506752K used,   8392K free,  73464K shrd,  58472K buff
> > >  Swap: 131528K av,  15968K used, 115560K free                358904K cached
> >
> > You have no processes??? My gosh, that is a problem. :-)
> 91 processes, only 1 running (think top)
>
> >
> > The load average is how many processes are runnable, therefore you have
> > runnable processes.
> >
> > If you have Netscape or Mozilla running on your box, it may be in a
> > permanently runnable state.
> it's a firewall/gateway/mail box, so no X or netscape
>
> > Another amusing possibility is that you have a hacked box, and top is
> > reporting the stupid IRC bot that is running, but not showing you the actuall
> > process, because it too is hacked.
> don't think
> w,uptime,top give the same value
>
> >
> > Replace ps and top, and have a look. Don't believe ls, either.
> >
> > If none of these things are true, you might have another problem.
> think this, but problem, machine is running ok
> no slow response, only load 1.00 (it's not getting lower)
>
>

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
