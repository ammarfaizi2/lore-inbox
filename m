Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270333AbRHMRxQ>; Mon, 13 Aug 2001 13:53:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270343AbRHMRxH>; Mon, 13 Aug 2001 13:53:07 -0400
Received: from cc668399-a.ewndsr1.nj.home.com ([24.180.97.113]:20215 "EHLO
	eriador.mirkwood.net") by vger.kernel.org with ESMTP
	id <S270333AbRHMRwy>; Mon, 13 Aug 2001 13:52:54 -0400
Date: Mon, 13 Aug 2001 13:53:12 -0400 (EDT)
From: PinkFreud <pf-kernel@mirkwood.net>
To: linux-kernel@vger.kernel.org
cc: =?ISO-8859-1?Q?G=E9rard_Roudier?= <groudier@free.fr>
Subject: Re: Are we going too fast?
Message-ID: <Pine.LNX.4.20.0108131249190.1037-100000@eriador.mirkwood.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Mon, 13 Aug 2001, PinkFreud wrote:
>
> > Please CC me in any replies, I am not subscribed to this list.

This still holds true - I'm not subscribed to this list right now.

> >
> > Please forgive me if I seem incoherent.  It's after 3:30 AM here.
>
> So, you will be forgiven, otherwise ... :-)

Thanks.  :)

> You may want to elaborate on the ncr53c8xx problems (I maintain this
> driver). More generally, you must not ignore the thousands of bugs in the
> hardware you are using, but software developpers haven't access to all
> errata descriptions since hardware vendors donnot like to make this
> information freely available.

I have elaborated.  See below.

>
> About ncr53c8xx problem reports, I cannot reply to all of them. You may
> also send them to LSILOGIC support. They also want Linux to work with the
> ncr/sym/lsi/53c8xx PCI-SCSI controllers, even with old NCR ones. Some
> other vendors seem to just ignore old hardwares. For example NVIDIA that
> killed (bought?) 3DFX, does not seem interested in maintaining drivers for
> the 3DFX graphic chips.

Have a contact address for LSILOGIC?  I'll be happy to CC them in any
future bug reports.  It may also be useful to place this address in
comments at the top of the ncr53c8xx driver as well.

> I use Linux since some 0.99.x (was yygdrasil distribution). My experience
> has been that 1.2.13, 2.0.27 and 2.2.13 worked reliable enough for me.

I've used all three of those kernels, and I tend to agree - except for the
nasty security hole in 2.2.13 (but that happens with any OS - look at
Windows!).

> 'Stable' does not means reliable for any workload. It means that we stop
> developping (implies changing large portions of code or modifying
> interfaces) but only focus on fixing the software with it current design
> (implies only changing what is proven to be broken).  This applies to all

I think I've proven a number of things to be broken in the 2.4.x series -
but they doesn't seem to be getting fixed.  My point was, perhaps more
effort should be put into fixing these bugs, rather than adding new
features to a supposedly stable series.

> softwares, not only to Linux. As a result, early stable releases still
> have numerous bugs that may prevent numerous systems from working
> reliably. It is up to user to check releases and switch to the one that
> fits his expectations.

If Linux is trying to prove itself usable for the business world, how is
that going to help?  I'm not implying that I'm a business in any way,
shape, or form - but given that I think the majority of us want to see
Linux in the server rooms, and even on the desktop, what does this mean
for those users?

> > This brings me to the subject of this rant: are we going too fast?  New
> > drivers are still showing up in each successive kernel, and yet no one
> > seems to be able to fix the old bugs that already exist.  Are we looking
> > to have the reliability of Windows?  It's starting to seem so - each
> > successive kernel series just seems to crash more and more often.  When
> > will we reach the point where Windows, on the average, will have greater
> > uptime than Linux systems?  Perhaps it's time to slow down, and do some
> > debugging.
>
> The reliabity of Windows seems to be just fine for most users since it is
> the O/S most of them want to use.:-)

I know plenty of Windows users who are quite upset at the lack of
stability.  They either don't know/understand that there are alternatives,
or feel it's too hard to switch to an alternative.

> > Should development continue on the latest and supposedly greatest
> > drivers?  Or should the existing bugs be fixed first?  I've got at least
> > three up there that need taking care of, and I'm sure others on this list
> > have found more.  3 seperate crashes on 3 seperate installs on 3 seperate
> > boxes - that's 100% failure rate.  If I get 100% failure on my installs,
> > what are others seeing?
>
> Hopefully you aren't a typical computer user or you just have bad luck
> with computers. :-)

Certainly the case with the former, and sadly, you're not the first to
suggest the latter.  :)

> All software developpers and maintainers want their software to work and
> thus bugs to be fixed. This is just sometimes hard to know what is
> actually broken. My experience is that no more than 10% bug reports about
> a software are due to a bug in the software that is pointed out by the
> report. And for these less than 10% relevant reports, maintainers must
> find what is broken... not simple as you can imagine...

I definintely believe this (the random panic) to be a bug in your
ncr53c8xx driver.  ksymoops seemed to believe it to be the case, and
NetBSD seems to be working fine, which means it's not faulty hardware.

> Btw, I use SYM-2 driver under Linux, FreeBSD and NetBSD 1.5. I have no
> problem with it. If you plan to use Ultra-160 LSI53C1010 chips, the NetBSD
> SIOP driver may be sub-optimal and, btw, it does not seem to know about
> C1010 chips erratas.

I'll keep that in mind.  However, the box in question is an older system,
so I doubt it'll ever see one of those.

By the way, the driver seems to work with 2.2.14 on an Alpha.  On this
system, though, 2.4.x just manages to blow up.

> You donnot seem to have given a try with FreeBSD. Were there some strong
> reasons for that ?

Actually, I was considering both Free- and NetBSD.  I just chose NetBSD.

> > sauron@rivendell:~$ uptime
> >  3:17AM  up 12 days, 15:20, 2 users, load averages: 1.48, 0.66, 0.31
> > sauron@rivendell:~$ uname -a
> > NetBSD rivendell 1.5.1 NetBSD 1.5.1 (RIVENDELL) #0: Tue Jul 31 22:58:54
> > EDT 2001     root@rivendell:/usr/src/sys/arch/i386/compile/RIVENDELL i386
> > sauron@rivendell:~$ dmesg | grep -i sym
> > siop0 at pci0 dev 6 function 0: Symbios Logic 53c810 (fast scsi)
> >
> > (The controller is old - it was made by NCR before it became Symbios Logic
> > - hence, why I was using the NCR driver for it, rather than the Symbios
> > driver, in Linux.)
> >
> > Working on 13 days uptime.  That's well over twice the uptime for Linux on
> > that box.  That's what happens when the kernel has bugs.
>
> You seem so sure it is the ncr53c8xx driver that breaks your Linux ...
> If it was so broken, may be I would have heared about. :-)

You should have heard about it.  The last two messages were sent to the
address you have listed in your driver.


Date: Fri, 20 Jul 2001 13:26:12 -0400 (EDT)
From: PinkFreud <pf-kernel@mirkwood.net>
To: linux-kernel@vger.kernel.org
Subject: two seperate 2.4.x problems...
Message-ID: <Pine.LNX.4.20.0107201305350.5411-100000@eriador.mirkwood.net>

                                                                          
Date: Mon, 23 Jul 2001 14:11:35 -0400 (EDT)
From: PinkFreud <pf-kernel@mirkwood.net>
To: linux-kernel@vger.kernel.org
cc: Gerard Roudier <groudier@club-internet.fr>
Subject: 2.4.6 NCR53C8XX bug?  (was: 2.4.x problems (this is *not* a
    distribution
 related question!))
Message-ID: <Pine.LNX.4.20.0107231347060.5411-100000@eriador.mirkwood.net>


Date: Sat, 28 Jul 2001 22:20:20 -0400 (EDT)
From: PinkFreud <pf-kernel@mirkwood.net>
To: linux-kernel@vger.kernel.org
cc: Gerard Roudier <groudier@club-internet.fr>
Subject: 2.4.7 oops + panic in ncr53c8xx (ncr_wakeup_done)
Message-ID: <Pine.LNX.4.20.0107282207180.316-100000@eriador.mirkwood.net>


Would you like me to re-send the ksymoops output?

> > Take this rant for what you will.  Personally, I switched from Windows to
> > Linux 5 years ago for the stability.  If I need to switch OSs again to
> > continue to have stability, I will.  Somehow, I suspect, if kernel
> > development continues down this path, many others will wind up switching
> > to other OSs as well.
>
> If NetBSD fits your need, then let me encourage you to use it.

It is for the moment.  I hoped Linux would fit my need, though.

> > I like Linux.  I'd like to stick with it.  But if it's going to
> > continually crash, I'm going to jump ship - and I'll start recommending to
> > others that they do the same.
>
> That's unclever recommendation, in my opinion.
> For example, my children are happy using Windows 98 and I donnot want to
> recommend them anything else.

I recommend using what I feel is usable (which includes stability) - which
is why I never recommend using Windows.  But that's just me.


	Mike Edwards

Brainbench certified Master Linux Administrator
http://www.brainbench.com/transcript.jsp?pid=158188
-----------------------------------
Unsolicited advertisments to this address are not welcome.



