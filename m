Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269951AbRHMHnS>; Mon, 13 Aug 2001 03:43:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269946AbRHMHnI>; Mon, 13 Aug 2001 03:43:08 -0400
Received: from cc668399-a.ewndsr1.nj.home.com ([24.180.97.113]:13814 "EHLO
	eriador.mirkwood.net") by vger.kernel.org with ESMTP
	id <S269944AbRHMHmy>; Mon, 13 Aug 2001 03:42:54 -0400
Date: Mon, 13 Aug 2001 03:43:05 -0400 (EDT)
From: PinkFreud <pf-kernel@mirkwood.net>
To: linux-kernel@vger.kernel.org
Subject: Are we going too fast?
Message-ID: <Pine.LNX.4.20.0108130303120.1037-100000@eriador.mirkwood.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Please CC me in any replies, I am not subscribed to this list.

Please forgive me if I seem incoherent.  It's after 3:30 AM here.


I have installed various 2.4.x kernels on 3 seperate systems here.  *ALL*
of them have suffered from one malady or another - from the dual PIII with
the VIA chipset and Matrox G400 card, which locks up nicely when I switch
from X to a text console and back to X (but NOT under a uniprocessor
kernel!), to the system with the NCR 53c810 SCSI board, which suffered
random kernel panics anywhere from 2 hours to 5 days after booting, due to
the ncr53c8xx driver, to YET ANOTHER system which has shown a penchant for
crashing (read: no response on console, can use magic sysrq, but fails to
emergency sync) when attempting to use 'ls' on a mounted QNX filesystem
(ls comes up fine, then system crashes - nothing sent to syslog, no errors
on screen, nothing!) - and this latest is with 2.4.8!

I've used Linux for over 5 years now.  In all the time I've used it, I
have never seen this much instability in a single kernel
series - though I've noticed each successive 'stable' series having
more bugs than the last (2.2.x crashed once a week with SMP 
until 2.2.10!).  Furthermore, I have had a HELL of a time trying
to get responses to the first two problems (this is the first report for
the third).  It used to be that I could ask a question on this list, and
receive responses.  Not anymore.  I can't seem to get the time of day from
anyone on this list now.

This brings me to the subject of this rant: are we going too fast?  New
drivers are still showing up in each successive kernel, and yet no one
seems to be able to fix the old bugs that already exist.  Are we looking
to have the reliability of Windows?  It's starting to seem so - each
successive kernel series just seems to crash more and more often.  When
will we reach the point where Windows, on the average, will have greater
uptime than Linux systems?  Perhaps it's time to slow down, and do some
debugging.

This is supposed to be a 'stable' kernel series?  I see nothing stable
about it.

Should development continue on the latest and supposedly greatest
drivers?  Or should the existing bugs be fixed first?  I've got at least
three up there that need taking care of, and I'm sure others on this list
have found more.  3 seperate crashes on 3 seperate installs on 3 seperate
boxes - that's 100% failure rate.  If I get 100% failure on my installs,
what are others seeing?

To those of you who would tell me to fix them myself: I am an
administrator.  I know Perl.  I am not all that familiar with C, nor with
kernel programming.  They're not my bugs, but I would fix them if I were
able to.  I'd hope the authors of said bugs would be willing to fix them -
but given the track record I've seen for the first two problems, I'm not
holding my breath for the third to be fixed any time soon.

I don't know about the rest of you, but I'm going to give up soon and
switch to NetBSD.  I've already done it on the system with the NCR 53c810
board - and it's proven to be far more stable than 2.4.x kernels have ever
managed to be on it.  What does that say?

sauron@rivendell:~$ uptime
 3:17AM  up 12 days, 15:20, 2 users, load averages: 1.48, 0.66, 0.31
sauron@rivendell:~$ uname -a
NetBSD rivendell 1.5.1 NetBSD 1.5.1 (RIVENDELL) #0: Tue Jul 31 22:58:54
EDT 2001     root@rivendell:/usr/src/sys/arch/i386/compile/RIVENDELL i386
sauron@rivendell:~$ dmesg | grep -i sym
siop0 at pci0 dev 6 function 0: Symbios Logic 53c810 (fast scsi)

(The controller is old - it was made by NCR before it became Symbios Logic
- hence, why I was using the NCR driver for it, rather than the Symbios
driver, in Linux.)

Working on 13 days uptime.  That's well over twice the uptime for Linux on
that box.  That's what happens when the kernel has bugs.

Take this rant for what you will.  Personally, I switched from Windows to
Linux 5 years ago for the stability.  If I need to switch OSs again to
continue to have stability, I will.  Somehow, I suspect, if kernel
development continues down this path, many others will wind up switching
to other OSs as well.

I like Linux.  I'd like to stick with it.  But if it's going to
continually crash, I'm going to jump ship - and I'll start recommending to
others that they do the same.


	Mike Edwards

Brainbench certified Master Linux Administrator
http://www.brainbench.com/transcript.jsp?pid=158188
-----------------------------------
Unsolicited advertisments to this address are not welcome.

