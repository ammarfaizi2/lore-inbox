Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285965AbRLHVO0>; Sat, 8 Dec 2001 16:14:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285964AbRLHVOR>; Sat, 8 Dec 2001 16:14:17 -0500
Received: from astound-64-85-224-253.ca.astound.net ([64.85.224.253]:7694 "EHLO
	master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S285965AbRLHVOA>; Sat, 8 Dec 2001 16:14:00 -0500
Date: Sat, 8 Dec 2001 13:09:35 -0800 (PST)
From: Andre Hedrick <andre@linux-ide.org>
To: Gerald Britton <gbritton@mit.edu>
cc: Ishan Oshadi Jayawardena <ioshadi@sltnet.lk>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: IDE-DMA woes
In-Reply-To: <20011207113110.A3673@light-brigade.mit.edu>
Message-ID: <Pine.LNX.4.10.10112081306490.15878-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Gerald,

Like I told you in the other forum.  I have the solutions just my work is
being refused.  Don't know if I have absolutely pissed off the
king-penguin or what but there is no reason to submit when I know it is
not going to be accepted -- regardless that it is in exact compliance to
the ANSI/NCITS rules that I am now one of the co-authors.

Regards,

Andre Hedrick
CEO/President, LAD Storage Consulting Group
Linux ATA Development
Linux Disk Certification Project

On Fri, 7 Dec 2001, Gerald Britton wrote:

> On Fri, Dec 07, 2001 at 05:30:14PM -0600, Ishan Oshadi Jayawardena wrote:
> > Greetings.
> > 	I run Linux on an IBM PC300GL with Intel's
> > 82371AB PIIX4 chipset. With DMA enabled (by doing a
> > hdparm -d1 /dev/hda) on the hdd, I
> > _sometimes_ get the following message from the kernel
> > after resuming from APM standby mode:
> 
> I have very similar behavior on an IBM Thinkpad T23.  It's got this IDE
> controller:
> 
> 00:1f.1 IDE interface: Intel Corporation: Unknown device 248a (rev 01)
>         Subsystem: IBM: Unknown device 0220
> 
> And, I also only sometimes get roughly:
> 
> ide_dmaproc: chipset supported ide_dma_lostirq func only: 13
> hda: lost interrupt
> ide_dmaproc: chipset supported ide_dma_timeout func only: 14
> 
> > ide_dmaproc: chipset supported ide_dma_timeout func only: 14
> > hda: status error: status=0x59 { DriveReady SeekComplete DataRequest
> > Error }
> > hda: status error: error=0x84 { DriveStatusError BadCRC }
> > hda: drive not ready for command
> > 
> > then the drive stalls for a few seconds, and the driver
> > disables DMA. This behaviour doesn't seem to depend on the
> > kernel version (current: 2.4.14; error seen with 2.2 series also.)
> > The weird thing is that this is not reliably reproducable; most of
> > the time the system goes to apm standby (not suspend) and resumes fine.
> 
> Unfortunately, when mine hits this condition, it seems to never recover
> from it.  It also seems to only happen sometimes and I've been unable to
> reliably reproduce the problem.  I told Andre about the problem and he
> suggested doing a "hdparm -d0 -X08 /dev/hda" prior to suspend and that
> seems to work around the problem.  I "hdparm -d1 -X69 /dev/hda" on resume
> to get it back to speedy udma5 mode.  I think the problem is the BIOS doing
> things to the IDE chipset during the suspend, and the driver not properly
> correcting the changes on resume.
> 
> 				-- Gerald
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

