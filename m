Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282968AbRK0Vy6>; Tue, 27 Nov 2001 16:54:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282973AbRK0Vyt>; Tue, 27 Nov 2001 16:54:49 -0500
Received: from astound-64-85-224-253.ca.astound.net ([64.85.224.253]:60166
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S282968AbRK0Vyk>; Tue, 27 Nov 2001 16:54:40 -0500
Date: Tue, 27 Nov 2001 13:52:23 -0800 (PST)
From: Andre Hedrick <andre@linux-ide.org>
To: Wayne Whitney <whitney@math.berkeley.edu>
cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: Journaling pointless with today's hard disks?
In-Reply-To: <200111272128.fARLS6k02556@adsl-209-76-109-63.dsl.snfc21.pacbell.net>
Message-ID: <Pine.LNX.4.10.10111271342450.12581-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I strongly suggest you execute the extend tests in the smart-suite
authored by a friend of mine that I have listed on my www.linux-ide.org.

What you have done is trigger a process to have the device go into a
selftest mode to perform a block test.  I would tell you more but I may
have exposed myself already.

Regards, you need to execute an extend smart offline test.
Also be sure to query the smart logs.

Respectfully,

Andre Hedrick
CEO/President, LAD Storage Consulting Group
Linux ATA Development
Linux Disk Certification Project
 
On Tue, 27 Nov 2001, Wayne Whitney wrote:

> In mailing-lists.linux-kernel, Andre Hedrick wrote:
> 
> > By the time an ATA device gets to generating this message, either the bad
> > block list is full or all reallocation sectors are used.  Unlike SCSI
> > which has to be hand held, 90% of all errors are handle by the device.
> 
> Perhaps you or one of the other gurus could explain the following
> observations, which I am sure that I and many other readers would find
> very enlightening:
> 
> I have an IBM-DTLA-307045 drive connected to a PDC20265 controller on
> an ia32 machine running 2.4.16.  After reading this discussion and
> hearing about the problems that others have had with the IBM 75GXP
> series, I thought that I should test out my drive to see if it is OK.
> So I ran 'dd if=/dev/hde of=/dev/null bs=128k'.  Every thing went
> fine, except for about five seconds in the middle, when the disk made
> a lot of grinding sounds and the system was unresponsive.  That
> generated the log messages messages appended below.
> 
> However, running the dd command again (after a reboot) produced no
> errors.  So the drive remapped some bad sectors the first time
> through?  The common wisdom here is that once you get to the point
> where the drive reports a bad sector, you are in trouble.  If so, why
> did the second dd command work OK?  I have had no other problems with
> this drive.
> 
> Thanks, Wayne
> 
> hde: dma_intr: status=0x51 { DriveReady SeekComplete Error }
> hde: dma_intr: error=0x40 { UncorrectableError }, LBAsect=12939888, sector=12939804
> end_request: I/O error, dev 21:00 (hde), sector 12939804
> hde: dma_intr: status=0x51 { DriveReady SeekComplete Error }
> hde: dma_intr: error=0x40 { UncorrectableError }, LBAsect=12939888, sector=12939806
> end_request: I/O error, dev 21:00 (hde), sector 12939806
> hde: dma_intr: status=0x51 { DriveReady SeekComplete Error }
> hde: dma_intr: error=0x40 { UncorrectableError }, LBAsect=12939888, sector=12939808
> end_request: I/O error, dev 21:00 (hde), sector 12939808
> hde: dma_intr: status=0x51 { DriveReady SeekComplete Error }
> hde: dma_intr: error=0x40 { UncorrectableError }, LBAsect=12939888, sector=12939810
> end_request: I/O error, dev 21:00 (hde), sector 12939810
> hde: dma_intr: status=0x51 { DriveReady SeekComplete Error }
> hde: dma_intr: error=0x40 { UncorrectableError }, LBAsect=12939888, sector=12939812
> end_request: I/O error, dev 21:00 (hde), sector 12939812
> 

