Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317879AbSFSNAa>; Wed, 19 Jun 2002 09:00:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317880AbSFSNA3>; Wed, 19 Jun 2002 09:00:29 -0400
Received: from chaos.analogic.com ([204.178.40.224]:10114 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S317879AbSFSNA2>; Wed, 19 Jun 2002 09:00:28 -0400
Date: Wed, 19 Jun 2002 09:02:17 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Roberto Nibali <ratz@drugphish.ch>
cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Firewire Disks. (fwd)
In-Reply-To: <3D0FC86A.2030203@drugphish.ch>
Message-ID: <Pine.LNX.3.95.1020619083141.12024A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 19 Jun 2002, Roberto Nibali wrote:

> Hi,
> 
> > Okay. I tried the ieee1394-508.tar.gz tar-ball at home, replacing
> > ../linux/drivers/ieee1394 directory contents of Linux version 2.4.18.
> > 
> > I have sbp2.o inserted by initrd. It initializes, but doesn't find
> > any devices. If, once the machine is up, I remove the module and then
> > re-install it, it finds the two devices that I have on the Firewire.
> 
> Ever tried to find the attached devices with rescan-scsi-bus.sh [1]?
> 

No because I don't have such a script at home and it didn't come
with the distribution.


> > I have been able to make an e2fs file-system on the 80 Gb drive.
> > I can also create a large file on the drive. But... The following
> > will lock up... `cp /dev/sdd /dev/null`, the raw device being /dev/sdd.
> 
> Could you try with the latest 2.4.19pre tree, please? I remember some 
> scsi related fixes from Alan and some other which went into that tree. 
> Besides that the 2.4.18 is _really_ old with regard to certain subsystems.
> 

I will try 2.4.19pre, but I have had many problems with kernels later
than 2.4.18 and sort of "gave up". Changes have been made that prevented
even booting SMP Pentium II machines. Maybe things have been fixed.

> > The disk drive light comes on, then stays on forever. I get error
> > messages about "resetting the drive", and I can't get control from
> 
> I reckon some sbp2 problem together with the currect scsi interface. If 
> you can, you should try it with a 2.4.19pre tree even if it is simply to 
> show people that something is still heavily broken and to have a decent 
> starting point for debugging purposes.

Okay. I will try to build a later kernel today. What I have to do
is download a tarball, put it on a CD-ROM, then extract it at home.
Telco removed ISDN capability at home so I'm back to 56kb unless I
want to buy an expensive cable-modem service. That's what happens
when the 'phone company' is the cable company.

> 
> > any terminal. If I power off the drive, then power it back on, the
> > process reading from the drive, enters the 'D' state (forever), but
> > I can get control from another virtual terminal and reboot the machine.
> > There is something, probably in SCSI, that won't allow the root file-
> > system to be unmounted so there is a long fsck upon reboot.
> 
> Always enable SysRq for such test cases, so you can at least emergency 
> sync and remount,ro.

It is enabled, but it requires interrupts to work. Something was spinning
inside some spin-lock somewhere or had gone off into hyper-space with
the keyboard interrupt disabled. Also, if SCSI won't allow writes to
the disks, it's beyond me how you can complete a dismount if you
can't write to the disk(s).

> 
> > Anyway. I have a setup at home that can be used to test anything.
> > I think the hangup comes from the raw-read length being greater
> > than the "payload", but I'm not sure.
> 
> I don't know either, we might also need an ieee1394 specialist to solve 
> that problem, but only after you tested it with a more recent kernel 
> tree ;).
> 
> [1] http://www.garloff.de/kurt/linux/rescan-scsi-bus.sh
> 

I will grab this.


Cheers,
Dick Johnson

Penguin : Linux version 2.4.18 on an i686 machine (797.90 BogoMips).

                 Windows-2000/Professional isn't.

