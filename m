Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130651AbRCFNSI>; Tue, 6 Mar 2001 08:18:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130655AbRCFNR7>; Tue, 6 Mar 2001 08:17:59 -0500
Received: from nic-31-c31-100.mn.mediaone.net ([24.31.31.100]:32640 "EHLO
	nic-31-c31-100.mn.mediaone.net") by vger.kernel.org with ESMTP
	id <S130651AbRCFNRs>; Tue, 6 Mar 2001 08:17:48 -0500
Date: Tue, 6 Mar 2001 07:17:40 -0600 (CST)
From: "Scott M. Hoffman" <scott@mediaone.net>
X-X-Sender: <scott@nic-31-c31-100.mn.mediaone.net>
Reply-To: <scott1021@mediaone.net>
To: God <atm@pinky.penguinpowered.com>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.4.2-ac12
In-Reply-To: <Pine.LNX.4.21.0103060507140.878-100000@scotch.homeip.net>
Message-ID: <Pine.LNX.4.32.0103060713400.3095-100000@nic-31-c31-100.mn.mediaone.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 6 Mar 2001, God wrote:

> On Mon, 5 Mar 2001, Scott M. Hoffman wrote:
>
> > On Mon, 5 Mar 2001, Richard B. Johnson wrote:
> > >
> > > I   -- S T R O N G L Y -- suggest that nobody use this kernel with
> > > a BusLogic SCSI controller until this problem is fixed.
> > >
> > > Dick Johnson
> >
> >  It may not be related, but out of five boot attempts, only one got past
> > the IDE driver stage(ie, below from 2.4.2 :
> >   VP_IDE: IDE controller on PCI bus 00 dev 39
> >   VP_IDE: chipset revision 16
> >   VP_IDE: not 100% native mode: will probe irqs later
> >   ide: Assuming 33MHz system bus speed for PIO modes; override with
> >   idebus=xx
> >   VP_IDE: VIA vt82c596b (rev 23) IDE UDMA66 controller on pci00:07.1
> >       ide0: BM-DMA at 0xe000-0xe007, BIOS settings: hda:DMA, hdb:DMA
> >       ide1: BM-DMA at 0xe008-0xe00f, BIOS settings: hdc:DMA, hdd:DMA)
> >   I've had 2.4.2 running great for the past 10 days. Need any more info?
>
> heh... I had (probably still do), the same problem.  Took me a few boots
> before it would get passed the drives (this was right after upgrading to
> 2.4.2).
>
> PIIX4: IDE controller on PCI bus 00 dev 21
> PIIX4: chipset revision 1
> PIIX4: not 100% native mode: will probe irqs later
>     ide0: BM-DMA at 0xd800-0xd807, BIOS settings: hda:DMA, hdb:DMA
>     ide1: BM-DMA at 0xd808-0xd80f, BIOS settings: hdc:DMA, hdd:DMA
> hda: QUANTUM FIREBALL CX6.4A, ATA DISK drive
> hdb: ST33210A, ATA DISK drive
> hdc: WDC AC2340F, ATA DISK drive
> hdd: ATAPI CD-ROM DRIVE 40X MAXIMUM, ATAPI CD/DVD-ROM drive
>
>
> Other then the fact that as I look down at the drive activity light on the
> case, it's lit ... things from a IO standpoint seem to be ok .. (and I
> hope it stays that way) ...
>
> btw, for the curious:
>
>
> # iostat
> Linux 2.4.2 (scotch)    03/06/2001
>
> tty:     tin       tout   avg-cpu:  %user   %nice    %sys   %idle  %iowait
>            0          0              1.09    0.00    0.69    0.00   98.22
> Disks:         tps   Blk_read/s   Blk_wrtn/s   Blk_read   Blk_wrtn
> hdisk0        0.00         0.00         0.00          0          0
> hdisk1        0.00         0.00         0.00          0          0
> hdisk2        0.00         0.00         0.00          0          0
>
> # hdparm -I /dev/hdd
> hdd: drive_cmd: status=0x51 { DriveReady SeekComplete Error }
> hdd: drive_cmd: error=0x04
>
> /dev/hdd:
> hdd: drive_cmd: status=0x58 { DriveReady SeekComplete DataRequest }
>  HDIO_DRIVE_CMD(identify) failed: Input/output error
>
>
> Doesn't matter what I have hdparm do to the drive, after running a
> function the drive / bus activity light turns off ...
>
>
> Thoughts?

 I have not had problems with 2.4.2, just tried 2.4.2-ac12.  About the IDE
stage it just reboots.
 As for your iostat output, which version do you have?  The stock one with
RH7 needs to be upgraded to work with 2.4 kernels.  I'm using 3.3.5 now,
which seems to work.


