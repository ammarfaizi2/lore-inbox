Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316195AbSFPM3l>; Sun, 16 Jun 2002 08:29:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316199AbSFPM3k>; Sun, 16 Jun 2002 08:29:40 -0400
Received: from proxy.aub.dk ([195.24.1.195]:43904 "EHLO Princess")
	by vger.kernel.org with ESMTP id <S316195AbSFPM3j>;
	Sun, 16 Jun 2002 08:29:39 -0400
From: Allan Sandfeld Jensen <snowwolf@one2one-networks.com>
Organization: One2one Networks A/S
To: Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Dual Athlon 2000 XP MP nightmare
Date: Sun, 16 Jun 2002 14:29:15 +0200
User-Agent: KMail/1.4.5
In-Reply-To: <003101c214bb$0275a720$0a00000a@kos.net> <3D0C4CAF.578D7CC1@cfl.rr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Message-Id: <200206161429.15653.snowwolf@one2one-networks.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 16 June 2002 10:30, Mark Hounschell wrote:
> Steve Cole wrote:
> >  I'm not sure that what I'm experiencing is a kernel problem, but I
> > thought I  would stick my foot in the door nonetheless, since I have no
> > real indication of what is going on.
> >
> > I have a dual Athlon 2000+ XP MP system.  It's crashing very frequently
> > and looks to be getting worse.  It seems to crash less with
> > 2.4.19pre10-ac2 which supports the 760 bus and 744x IDE controller, but
> > with something that is as intermittent as this, who can tell?
> >
> > Machine specs:
> >
> >  ASUS A7M266-D motherboard, 1006 BIOS rev.
> >  2GB ECC registered memory
> >  4 x 15K RPM Seagate UltraSCSI drives
> >  2 x 2960 (AIC7892 rev 2) controllers
> >  2 x 3C59x 3Com ethernet controllers
> >  !USB card to free up IRQs (removed later)
> >  400W power supply
> >  240W power supply driving two of the hard drives + CD ROM
> >  Budget vid card
> >  2 drives partitioned 30%/70%, 30% mirrored together for boot, 70%
> > mirrored in RAID 0+1 with other drives
> >
> >  I get EIP errors and Null pointer exception errors during full kernel
> > panics.  I've had a lot of file system corruption in ReiserFS originally
> > and now in EXT2, both fixable though Reiser seemed worse.  Uptime is
> > measured in hours - usually 12 or more, sometimes two or three.
> >
> > I can't come up with any reasons for this that point at the kernel, but
> > on the other hand, nothing is ever logged regarding SCSI I/O problems
> > (verbose logging turned on in kernel with extra queue checks).  I've
> > replaced the
> >
> > > memory to no avail, and updated the BIOS' of both motherboard and
> > > Adaptec
> >
> > cards.  No memory errors are logged and one pass of memtest86 found no
> > memory errors.
> >
> > Yet, the machine crashes semi-randomly (load seems to play some part in
> > this) and often crashes during the shutdown/reboot phase if it's run
> > reliably for a few hours.
> >
> > If it's hardware for sure, please just indicate that and I'll move on. 
> > I'm getting semi-desperate. :(
>
> First make sure you have MP cpus NOT XP's. The XP's are not certified by
> amd to run SMP. Second, try append="mem=nopentium" in your lilo.conf file.
> I have a dual 1900+ MP box and without that I have random lockups also.
>
BS and FUD! 

First try to remove one processor, and test the motherboard in single CPU 
configuration. If you still see crashes replace the motherboard. I also have 
a defective Asus A7M266-D. It crashes in any configuration of CPUs, power 
supplies and video cards.
