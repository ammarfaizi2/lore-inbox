Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289172AbSAVFtM>; Tue, 22 Jan 2002 00:49:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289171AbSAVFtD>; Tue, 22 Jan 2002 00:49:03 -0500
Received: from w089.z209220022.nyc-ny.dsl.cnc.net ([209.220.22.89]:26897 "HELO
	yucs.org") by vger.kernel.org with SMTP id <S289172AbSAVFsx>;
	Tue, 22 Jan 2002 00:48:53 -0500
Subject: Re: Athlon PSE/AGP Bug
From: Shaya Potter <spotter@opus.cs.columbia.edu>
To: Steve Brueggeman <brewgyman@mediaone.net>
Cc: Linux Kernel List <linux-kernel@vger.kernel.org>
In-Reply-To: <o7cp4ukpr9ehftpos1hg807a9hfor7s55e@4ax.com>
In-Reply-To: <1011610422.13864.24.camel@zeus>
	<20020121.053724.124970557.davem@redhat.com>,
	<20020121.053724.124970557.davem@redhat.com>; from davem@redhat.com on Mon,
	Jan 21, 2002 at 05:37:24AM -0800 <20020121175410.G8292@athlon.random>
	<3C4C5B26.3A8512EF@zip.com.au>  <o7cp4ukpr9ehftpos1hg807a9hfor7s55e@4ax.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0 (Preview Release)
Date: 22 Jan 2002 00:45:59 -0500
Message-Id: <1011678359.904.4.camel@zaphod>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

athlon XP 1800 is a cpuid 622 (aka an A5)

doesn't have this bug, according to AMD tech docs.

at least my 2 XP 1800+s are 622, so I assume all are (could be wrong)

On Mon, 2002-01-21 at 19:36, Steve Brueggeman wrote:
> Actually, this one hit home this weekend.
> 
> I bought a new computer at a computer fair.
> ECS K7S5A Motherboard
> 1.8Ghz (1.5actually) Athelon XP
> 3DForce2-MX
> 256MB DDR SDRAM PC-2100
> AHA2940UW SCSI Controller
> Compaq CDROM (reused from other upgraded system)
> 
> Spent all of Saturday trying to install Mandrake Linux 8.1 with random crashes,
> segfaults, IDE-Timeouts.  Figuring this to be a memory problem, I ran memtest86
> for 4 hours without any errors.  Was getting late, and said screw-it and went to
> bed.  
> 
> Sunday, set the memory and CPU both to 100Mhz, still have problems. so I set
> both back to 133Mhz.  Booted kernel 2.2.19 from 2nd CD in Mandrake set, and had
> better luck.  Got it installed after 3 restarts.  Figuring this was somehow
> related to APM or ACPI, I compiled a standard Marcello  kernel 2.4.17, but could
> not make it through a whole compile without segfaults.  I'd just restart the
> compile, letting make skip past the stuff that was already compiled.  Got an
> average of 3-4 segfaults on compile run, and I tried about 5 runs.
> 
> Boot to linux-2.4.17 with APM and ACPI disabled, and only stuff in my system
> enabled, and no Frame Buffer, still get segfaults when compiling kernel.
> 
> Then by sheer luck, while doing my normal check of linuxtoday.com, the top
> article mentioned this Athelon bug.  I figure, "Hey, this sounds somewhat
> familar", so I reboot with mem=nopentium as they suggested.
> 
> I've compiled the linux-2.4.17 about 10 times now, without a single segfault.
> 
> So, add me to the "Yes I've got this problem" list, and Yes, it appears to be
> related to Nvidia AGP boards.
> 
> I've been running a 1Ghz Thunderbird for about a year now, with 2 different ATI
> boards without any problems.  I'll try swapping the ATI and Nvidia display
> adapters and see if it follows.
> 
> Steve Brueggeman
> 
> On Mon, 21 Jan 2002 10:17:10 -0800, you wrote:
> 
> >Andrea Arcangeli wrote:
> >> 
> >> ...
> >> 
> >> I think this is a very very minor issue, I doubt anybody ever triggered
> >> it in real life with linux.
> >
> >It is said that the crashes cease when the `nopentium' option
> >is used, so it does appear that something is up.
> >
> >I does seem that the nVidia driver is usually involved.
> >
> >> And Gentoo is shipping a kernel with preempt and rmaps included, so it
> >> can crash anytime anyways, no matter how good the cpu is, so if they
> >> got crashes with such a kernel (maybe even with nvidia driver) that's
> >> normal. I was speaking today with a trusted party doing vm benchmarking
> >> and rmap crashes the kernel reproducibly under a stright calloc while
> >> swapping heavily, so clearly the implementation is still broken.
> >
> >-rmap is still young.  I did some heavy stress testing on it a couple
> >of days ago and it was rock-solid, and performed well.
> >
> >> preempt additionally will mess up all the locking into the nvidia driver as
> >> well. so if the combination of the two runs for some time without any
> >> lockup that's pure luck IMHO.
> >
> >Yup.  But don't forget about the `nopentium' observations.
> >
> >-
> >-
> >To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> >the body of a message to majordomo@vger.kernel.org
> >More majordomo info at  http://vger.kernel.org/majordomo-info.html
> >Please read the FAQ at  http://www.tux.org/lkml/
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/


