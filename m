Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270205AbRHMNz3>; Mon, 13 Aug 2001 09:55:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270204AbRHMNzT>; Mon, 13 Aug 2001 09:55:19 -0400
Received: from libra.cus.cam.ac.uk ([131.111.8.19]:135 "EHLO
	libra.cus.cam.ac.uk") by vger.kernel.org with ESMTP
	id <S270205AbRHMNzI>; Mon, 13 Aug 2001 09:55:08 -0400
Message-Id: <5.1.0.14.2.20010813143232.00a38140@pop.cus.cam.ac.uk>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Mon, 13 Aug 2001 14:55:18 +0100
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
From: Anton Altaparmakov <aia21@cam.ac.uk>
Subject: Re: Are we going too fast?
Cc: pf-kernel@mirkwood.net (PinkFreud), linux-kernel@vger.kernel.org
In-Reply-To: <E15WHVE-0007N6-00@the-village.bc.nu>
In-Reply-To: <Pine.LNX.4.20.0108130303120.1037-100000@eriador.mirkwood.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 14:11 13/08/01, Alan Cox wrote:
> > Should development continue on the latest and supposedly greatest
> > drivers?  Or should the existing bugs be fixed first?  I've got at least
> > three up there that need taking care of, and I'm sure others on this list
> > have found more.  3 seperate crashes on 3 seperate installs on 3 seperate
> > boxes - that's 100% failure rate.  If I get 100% failure on my installs,
> > what are others seeing?
>
>Near enough 0%. But then I try and avoid buying broken chipsets.

0% here. Admittedly I have only one VIA box and only as of this weekend but 
it works great with all kernels tried. [Epox 8KTA3 mobo, KT133A chipset 
running 266MHz FSB and 1.33GHz Athlon Thunderbird, PC133 CL2 RAM from 
Micron, active PFC power supply, BIOS setup to the fastest settings it 
allows me to set it to while stayin in spec (i.e. no o/c of CPU or 
busses!), IBM Ericson ATA100 41GiB HD attached to the VIA controller].

Tried kernels are 2.4.4-4GB (from SuSE 7.1 binary install Pentium 
optimizations I believe), 2.4.8 and 2.4.8-ac1 (the latter two both compiled 
with Athlon optimizations) and the system is absolutely fine. bonnie 
scores >30MiB/s (in mostly 34-39 MiB/s) on intelligent read/write tests 
with DMA enabled and a working set 2x size of RAM (i.e. 512MiB test size on 
256MiB RAM). Even when using fsync after every operation i/o speed is 
almost unaffected (it drops a bit but only by about 1-2MiB/s).

Copying 15 GiB of data from one partition to the other on the same disk 
worked fine. Compiling kernels works fine (Admittedly it only takes just 
over 3 minutes to compile the kernel with make -j 2 bzImage, so it's not 
too much of a stress test).

Oh and the VIA AC97 audio codec seems to work beautifully, too. As does X 
(both 3.3.x and 4.0.3) is fine, too. (I use an ancient ET6000 PCI gfx card.)

So, basically no problems here. I was quite worried about buying a VIA 
chipset but now it seems like a great buy. (-:

The only thing that's slightly annoying is that during boot three of the 
PCI resources from the VIA chipset are reported as "unknown, treating 
transparently" (or some simillar msg), don't have box handy to say what 
they were exactly... if anyone is intersted in exact messages I can provide 
dmesg + lspci -vvv output once I get home tonight.

> > I like Linux.  I'd like to stick with it.  But if it's going to
> > continually crash, I'm going to jump ship - and I'll start recommending to
>
>If you want maximum stability you want to be running 2.2 or even 2.0. Newer
>less tested code is always less table. 2.4 wont be as stable as 2.2 for a
>year yet.

Or alternatively buy quality components that other people have tested under 
Linux with kernel 2.4...

Anton


-- 
   "Nothing succeeds like success." - Alexandre Dumas
-- 
Anton Altaparmakov <aia21 at cam.ac.uk> (replace at with @)
Linux NTFS Maintainer / WWW: http://linux-ntfs.sf.net/
ICQ: 8561279 / WWW: http://www-stu.christs.cam.ac.uk/~aia21/

