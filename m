Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282963AbRK0V3K>; Tue, 27 Nov 2001 16:29:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282956AbRK0V3B>; Tue, 27 Nov 2001 16:29:01 -0500
Received: from c2105947-a.pinol1.sfba.home.com ([24.11.139.90]:8577 "EHLO
	adsl-209-76-109-63.dsl.snfc21.pacbell.net") by vger.kernel.org
	with ESMTP id <S282963AbRK0V2t>; Tue, 27 Nov 2001 16:28:49 -0500
Date: Tue, 27 Nov 2001 13:28:06 -0800
From: Wayne Whitney <whitney@math.berkeley.edu>
Message-Id: <200111272128.fARLS6k02556@adsl-209-76-109-63.dsl.snfc21.pacbell.net>
To: Andre Hedrick <andre@linux-ide.org>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: Journaling pointless with today's hard disks?
In-Reply-To: <Pine.LNX.4.10.10111261323270.9208-100000@master.linux-ide.org>
In-Reply-To: <b0b50u0s566g9fusmrfs275lsjvr0dd0hu@4ax.com> <Pine.LNX.4.10.10111261323270.9208-100000@master.linux-ide.org>
Reply-To: whitney@math.berkeley.edu
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In mailing-lists.linux-kernel, Andre Hedrick wrote:

> By the time an ATA device gets to generating this message, either the bad
> block list is full or all reallocation sectors are used.  Unlike SCSI
> which has to be hand held, 90% of all errors are handle by the device.

Perhaps you or one of the other gurus could explain the following
observations, which I am sure that I and many other readers would find
very enlightening:

I have an IBM-DTLA-307045 drive connected to a PDC20265 controller on
an ia32 machine running 2.4.16.  After reading this discussion and
hearing about the problems that others have had with the IBM 75GXP
series, I thought that I should test out my drive to see if it is OK.
So I ran 'dd if=/dev/hde of=/dev/null bs=128k'.  Every thing went
fine, except for about five seconds in the middle, when the disk made
a lot of grinding sounds and the system was unresponsive.  That
generated the log messages messages appended below.

However, running the dd command again (after a reboot) produced no
errors.  So the drive remapped some bad sectors the first time
through?  The common wisdom here is that once you get to the point
where the drive reports a bad sector, you are in trouble.  If so, why
did the second dd command work OK?  I have had no other problems with
this drive.

Thanks, Wayne

hde: dma_intr: status=0x51 { DriveReady SeekComplete Error }
hde: dma_intr: error=0x40 { UncorrectableError }, LBAsect=12939888, sector=12939804
end_request: I/O error, dev 21:00 (hde), sector 12939804
hde: dma_intr: status=0x51 { DriveReady SeekComplete Error }
hde: dma_intr: error=0x40 { UncorrectableError }, LBAsect=12939888, sector=12939806
end_request: I/O error, dev 21:00 (hde), sector 12939806
hde: dma_intr: status=0x51 { DriveReady SeekComplete Error }
hde: dma_intr: error=0x40 { UncorrectableError }, LBAsect=12939888, sector=12939808
end_request: I/O error, dev 21:00 (hde), sector 12939808
hde: dma_intr: status=0x51 { DriveReady SeekComplete Error }
hde: dma_intr: error=0x40 { UncorrectableError }, LBAsect=12939888, sector=12939810
end_request: I/O error, dev 21:00 (hde), sector 12939810
hde: dma_intr: status=0x51 { DriveReady SeekComplete Error }
hde: dma_intr: error=0x40 { UncorrectableError }, LBAsect=12939888, sector=12939812
end_request: I/O error, dev 21:00 (hde), sector 12939812
