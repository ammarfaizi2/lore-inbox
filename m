Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266559AbRHMKGj>; Mon, 13 Aug 2001 06:06:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270063AbRHMKGa>; Mon, 13 Aug 2001 06:06:30 -0400
Received: from postfix2-2.free.fr ([213.228.0.140]:6408 "HELO
	postfix2-2.free.fr") by vger.kernel.org with SMTP
	id <S266559AbRHMKGP> convert rfc822-to-8bit; Mon, 13 Aug 2001 06:06:15 -0400
Date: Mon, 13 Aug 2001 12:03:48 +0200 (CEST)
From: =?ISO-8859-1?Q?G=E9rard_Roudier?= <groudier@free.fr>
X-X-Sender: <groudier@gerard>
To: PinkFreud <pf-kernel@mirkwood.net>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: Are we going too fast?
In-Reply-To: <Pine.LNX.4.20.0108130303120.1037-100000@eriador.mirkwood.net>
Message-ID: <20010813105059.B1071-100000@gerard>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 13 Aug 2001, PinkFreud wrote:

> Please CC me in any replies, I am not subscribed to this list.
>
> Please forgive me if I seem incoherent.  It's after 3:30 AM here.

So, you will be forgiven, otherwise ... :-)

> I have installed various 2.4.x kernels on 3 seperate systems here.  *ALL*
> of them have suffered from one malady or another - from the dual PIII with
> the VIA chipset and Matrox G400 card, which locks up nicely when I switch
> from X to a text console and back to X (but NOT under a uniprocessor
> kernel!), to the system with the NCR 53c810 SCSI board, which suffered
> random kernel panics anywhere from 2 hours to 5 days after booting, due to
> the ncr53c8xx driver, to YET ANOTHER system which has shown a penchant for
> crashing (read: no response on console, can use magic sysrq, but fails to
> emergency sync) when attempting to use 'ls' on a mounted QNX filesystem
> (ls comes up fine, then system crashes - nothing sent to syslog, no errors
> on screen, nothing!) - and this latest is with 2.4.8!

You may want to elaborate on the ncr53c8xx problems (I maintain this
driver). More generally, you must not ignore the thousands of bugs in the
hardware you are using, but software developpers haven't access to all
errata descriptions since hardware vendors donnot like to make this
information freely available.

About ncr53c8xx problem reports, I cannot reply to all of them. You may
also send them to LSILOGIC support. They also want Linux to work with the
ncr/sym/lsi/53c8xx PCI-SCSI controllers, even with old NCR ones. Some
other vendors seem to just ignore old hardwares. For example NVIDIA that
killed (bought?) 3DFX, does not seem interested in maintaining drivers for
the 3DFX graphic chips.

> I've used Linux for over 5 years now.  In all the time I've used it, I
> have never seen this much instability in a single kernel
> series - though I've noticed each successive 'stable' series having
> more bugs than the last (2.2.x crashed once a week with SMP
> until 2.2.10!).  Furthermore, I have had a HELL of a time trying
> to get responses to the first two problems (this is the first report for
> the third).  It used to be that I could ask a question on this list, and
> receive responses.  Not anymore.  I can't seem to get the time of day from
> anyone on this list now.

I use Linux since some 0.99.x (was yygdrasil distribution). My experience
has been that 1.2.13, 2.0.27 and 2.2.13 worked reliable enough for me.
'Stable' does not means reliable for any workload. It means that we stop
developping (implies changing large portions of code or modifying
interfaces) but only focus on fixing the software with it current design
(implies only changing what is proven to be broken).  This applies to all
softwares, not only to Linux. As a result, early stable releases still
have numerous bugs that may prevent numerous systems from working
reliably. It is up to user to check releases and switch to the one that
fits his expectations.

> This brings me to the subject of this rant: are we going too fast?  New
> drivers are still showing up in each successive kernel, and yet no one
> seems to be able to fix the old bugs that already exist.  Are we looking
> to have the reliability of Windows?  It's starting to seem so - each
> successive kernel series just seems to crash more and more often.  When
> will we reach the point where Windows, on the average, will have greater
> uptime than Linux systems?  Perhaps it's time to slow down, and do some
> debugging.

The reliabity of Windows seems to be just fine for most users since it is
the O/S most of them want to use.:-)
I use Win98/SE, Win/NT 4.0, Linux-2.2.19, FreeBSD-4.2, and sometimes
NetBSD-1.5 on my personnal machine. They all work reliably enough for my
personnal usage. But, indeed, this is a station and not a server, even if
I use to sometimes stress the system under Linux and *BSDs.

> This is supposed to be a 'stable' kernel series?  I see nothing stable
> about it.
>
> Should development continue on the latest and supposedly greatest
> drivers?  Or should the existing bugs be fixed first?  I've got at least
> three up there that need taking care of, and I'm sure others on this list
> have found more.  3 seperate crashes on 3 seperate installs on 3 seperate
> boxes - that's 100% failure rate.  If I get 100% failure on my installs,
> what are others seeing?

Hopefully you aren't a typical computer user or you just have bad luck
with computers. :-)

> To those of you who would tell me to fix them myself: I am an
> administrator.  I know Perl.  I am not all that familiar with C, nor with
> kernel programming.  They're not my bugs, but I would fix them if I were
> able to.  I'd hope the authors of said bugs would be willing to fix them -
> but given the track record I've seen for the first two problems, I'm not
> holding my breath for the third to be fixed any time soon.

All software developpers and maintainers want their software to work and
thus bugs to be fixed. This is just sometimes hard to know what is
actually broken. My experience is that no more than 10% bug reports about
a software are due to a bug in the software that is pointed out by the
report. And for these less than 10% relevant reports, maintainers must
find what is broken... not simple as you can imagine...

> I don't know about the rest of you, but I'm going to give up soon and
> switch to NetBSD.  I've already done it on the system with the NCR 53c810
> board - and it's proven to be far more stable than 2.4.x kernels have ever
> managed to be on it.  What does that say?

You can break any O/S given an appropriate workload. Add to this all the
hidden/unknown hardware bugs that can be randomly triggerred ...

Btw, I use SYM-2 driver under Linux, FreeBSD and NetBSD 1.5. I have no
problem with it. If you plan to use Ultra-160 LSI53C1010 chips, the NetBSD
SIOP driver may be sub-optimal and, btw, it does not seem to know about
C1010 chips erratas.

You donnot seem to have given a try with FreeBSD. Were there some strong
reasons for that ?

> sauron@rivendell:~$ uptime
>  3:17AM  up 12 days, 15:20, 2 users, load averages: 1.48, 0.66, 0.31
> sauron@rivendell:~$ uname -a
> NetBSD rivendell 1.5.1 NetBSD 1.5.1 (RIVENDELL) #0: Tue Jul 31 22:58:54
> EDT 2001     root@rivendell:/usr/src/sys/arch/i386/compile/RIVENDELL i386
> sauron@rivendell:~$ dmesg | grep -i sym
> siop0 at pci0 dev 6 function 0: Symbios Logic 53c810 (fast scsi)
>
> (The controller is old - it was made by NCR before it became Symbios Logic
> - hence, why I was using the NCR driver for it, rather than the Symbios
> driver, in Linux.)
>
> Working on 13 days uptime.  That's well over twice the uptime for Linux on
> that box.  That's what happens when the kernel has bugs.

You seem so sure it is the ncr53c8xx driver that breaks your Linux ...
If it was so broken, may be I would have heared about. :-)

> Take this rant for what you will.  Personally, I switched from Windows to
> Linux 5 years ago for the stability.  If I need to switch OSs again to
> continue to have stability, I will.  Somehow, I suspect, if kernel
> development continues down this path, many others will wind up switching
> to other OSs as well.

If NetBSD fits your need, then let me encourage you to use it.

> I like Linux.  I'd like to stick with it.  But if it's going to
> continually crash, I'm going to jump ship - and I'll start recommending to
> others that they do the same.

That's unclever recommendation, in my opinion.
For example, my children are happy using Windows 98 and I donnot want to
recommend them anything else.

> 	Mike Edwards
>
> Brainbench certified Master Linux Administrator
> http://www.brainbench.com/transcript.jsp?pid=158188
> -----------------------------------
> Unsolicited advertisments to this address are not welcome.

Regards,
  Gérard.


