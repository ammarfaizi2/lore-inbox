Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316023AbSFPI3z>; Sun, 16 Jun 2002 04:29:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316039AbSFPI3z>; Sun, 16 Jun 2002 04:29:55 -0400
Received: from smtp-server2.tampabay.rr.com ([65.32.1.39]:32510 "EHLO
	smtp-server2.tampabay.rr.com") by vger.kernel.org with ESMTP
	id <S316023AbSFPI3y>; Sun, 16 Jun 2002 04:29:54 -0400
Message-ID: <3D0C4CAF.578D7CC1@cfl.rr.com>
Date: Sun, 16 Jun 2002 04:30:39 -0400
From: Mark Hounschell <dmarkh@cfl.rr.com>
Reply-To: dmarkh@cfl.rr.com
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.18-lcrs i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Steve Cole <coles@vip.kos.net>
CC: linux-kernel@vger.kernel.org
Subject: Re: Dual Athlon 2000 XP MP nightmare
In-Reply-To: <003101c214bb$0275a720$0a00000a@kos.net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Steve Cole wrote:
> 
>  I'm not sure that what I'm experiencing is a kernel problem, but I thought
> I  would stick my foot in the door nonetheless, since I have no real
> indication of what is going on.
> 
> I have a dual Athlon 2000+ XP MP system.  It's crashing very frequently and
> looks to be getting worse.  It seems to crash less with 2.4.19pre10-ac2
> which supports the 760 bus and 744x IDE controller, but with something that
> is as intermittent as this, who can tell?
> 
> Machine specs:
> 
>  ASUS A7M266-D motherboard, 1006 BIOS rev.
>  2GB ECC registered memory
>  4 x 15K RPM Seagate UltraSCSI drives
>  2 x 2960 (AIC7892 rev 2) controllers
>  2 x 3C59x 3Com ethernet controllers
>  !USB card to free up IRQs (removed later)
>  400W power supply
>  240W power supply driving two of the hard drives + CD ROM
>  Budget vid card
>  2 drives partitioned 30%/70%, 30% mirrored together for boot, 70% mirrored
> in RAID 0+1 with other drives
> 
>  I get EIP errors and Null pointer exception errors during full kernel
> panics.  I've had a lot of file system corruption in ReiserFS originally and
> now in EXT2, both fixable though Reiser seemed worse.  Uptime is measured in
> hours - usually 12 or more, sometimes two or three.
> 
> I can't come up with any reasons for this that point at the kernel, but on
> the other hand, nothing is ever logged regarding SCSI I/O problems (verbose
> logging turned on in kernel with extra queue checks).  I've replaced the
> > memory to no avail, and updated the BIOS' of both motherboard and Adaptec
> cards.  No memory errors are logged and one pass of memtest86 found no
> memory errors.
> 
> Yet, the machine crashes semi-randomly (load seems to play some part in
> this) and often crashes during the shutdown/reboot phase if it's run
> reliably for a few hours.
> 
> If it's hardware for sure, please just indicate that and I'll move on.  I'm
> getting semi-desperate. :(
> 

First make sure you have MP cpus NOT XP's. The XP's are not certified by amd to run
SMP. Second, try append="mem=nopentium" in your lilo.conf file. I have a dual 1900+ MP
box and without that I have random lockups also.

Mark
