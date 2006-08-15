Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030287AbWHONpy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030287AbWHONpy (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Aug 2006 09:45:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030292AbWHONpy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Aug 2006 09:45:54 -0400
Received: from tower.bj-ig.de ([194.127.182.2]:12712 "EHLO fs.bj-ig.de")
	by vger.kernel.org with ESMTP id S1030291AbWHONpx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Aug 2006 09:45:53 -0400
From: Ralf =?iso-8859-1?q?M=FCller?= <ralf@bj-ig.de>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Daily crashes, incorrect RAID behaviour
Date: Tue, 15 Aug 2006 15:45:49 +0200
User-Agent: KMail/1.9.1
References: <13e988610608150436y6812f623p9919b2d5b1989427@mail.gmail.com>
In-Reply-To: <13e988610608150436y6812f623p9919b2d5b1989427@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200608151545.49345@bj-ig.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 15 August 2006 13:36, you wrote:
> My problems continue, even with a new and good power supply.
> 1) The system loses a disk about every week, only a hard reboot
> solves that 2) In the last three nights the system lost all disk
> access and trashed the file systems
>
> Regarding 1)
> The system works normally and suddenly one disk does not respond.
> After a soft reboot the BIOS does not recognize the disk, here a hard
> reboot helps. Whenever I start my normal system in this situation, my
> file systems get trashed. I think the software raid thinks the failed
> disks (which lost several hours of write accesses) is OK and then
> merges the data. When I delete the disk (or create another raid on
> the partitions) I can add the disk without problems. This might be a
> bug, at least it is _very_ annoying.

> 4x Maxtor 300GB (Sata2)

I have a similar problem with maybe the same type of disk. My analysis 
of the problem is still not that complete so I did not asked on the 
kernel mailing list yet.

The disk type we use here in a ten disk RAID6 is:
Maxtor 7V300F0 300GB Sata2
on Promise Sata 300 TX4 controllers

Once in a week or two a random disk is not responding anymore and needs 
a complete power off/on cycle to recover. After power cycle the disk 
works without problems, doesn't report any SMART problems ...
I'm quite sure it is no problem with power supply, motherboard, 
backplane or controllers. Still open are cabling and disks. Nearly the 
same setup of hardware - just with different disks - is running smooth 
since about 8 month in a different system.

If this is the same disk type we maybe should return the disks to our 
hardware vendors as it may be a disk problem.

The only messages I get are like that:
Aug 13 17:25:10 backup-core kernel: ata7: command timeout
Aug 13 17:25:10 backup-core kernel: ata7: translated ATA stat/err 
0xff/00 to SCSI SK/ASC/ASCQ 0xb/47/00
Aug 13 17:25:10 backup-core kernel: ata7: status=0xff { Busy }
Aug 13 17:25:42 backup-core kernel: ata7: command timeout
Aug 13 17:25:42 backup-core kernel: ata7: translated ATA stat/err 
0xff/00 to SCSI SK/ASC/ASCQ 0xb/47/00
Aug 13 17:25:42 backup-core kernel: ata7: status=0xff { Busy }
Aug 13 17:26:43 backup-core kernel: ata7: command timeout
Aug 13 17:26:43 backup-core kernel: ata7: translated ATA stat/err 
0xff/00 to SCSI SK/ASC/ASCQ 0xb/47/00
Aug 13 17:26:43 backup-core kernel: ata7: status=0xff { Busy }
Aug 13 17:26:43 backup-core kernel: end_request: I/O error, dev sdg, 
sector 2104383

Regards
Ralf

-- 
Van Roy's Law: -------------------------------------------------------
       An unbreakable toy is useful for breaking other toys.
