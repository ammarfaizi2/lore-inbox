Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751074AbWH0PdQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751074AbWH0PdQ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Aug 2006 11:33:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751075AbWH0PdQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Aug 2006 11:33:16 -0400
Received: from mail.first.fraunhofer.de ([194.95.169.2]:8921 "EHLO
	mail.first.fraunhofer.de") by vger.kernel.org with ESMTP
	id S1751069AbWH0PdP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Aug 2006 11:33:15 -0400
Subject: Re: translated ATA stat/err 0x51/0c to ... PDC20376 (FastTrak 376)
	related cold freezes
From: Soeren Sonnenburg <kernel@nn7.de>
To: Tejun Heo <htejun@gmail.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <44F167C0.6020903@gmail.com>
References: <1156440866.29118.14.camel@localhost>
	 <44F167C0.6020903@gmail.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Sun, 27 Aug 2006 15:33:08 +0000
Message-Id: <1156692788.12244.11.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.3 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2006-08-27 at 18:37 +0900, Tejun Heo wrote:
> Soeren Sonnenburg wrote:
> > Dear all,
> > 
> > I just upgraded to using 2 sata disks (both seagate drives
> > ST3400832AS and ST3750640AS) on this asus a7v8x on-board promise fastrak
> > 376 (PDC20376) controller. However, as soon as I do a lot of io (cp some
> > G of files) I get swamped in 
> > 
> > ata1: translated ATA stat/err 0x51/0c to SCSI SK/ASC/ASCQ 0xb/00/00
> > ata1: status=0x51 { DriveReady SeekComplete Error }
> > ata1: error=0x0c { DriveStatusError }
> > ata2: translated ATA stat/err 0x51/0c to SCSI SK/ASC/ASCQ 0xb/00/00
> > ata2: status=0x51 { DriveReady SeekComplete Error }
> > ata2: error=0x0c { DriveStatusError }
> > ...
> 
> Is the system usable after these messages?

Yes, however I got cold freezes from (time to time) after a while...

> > messages. For that it is enough to do it on a single drive or copy from
> > drive to drive. This is on kernel 2.6.17.4, but I remember (when I was
> > still using a single drive) this very same output to happen on 2.6.15.
> > 
> > Can anyone translate these dubious error messages to me ?
> > 
> > Here are more details about the system:
> > 
> > - the sata_promise driver version 1.04 is used
> 
> Can you give a shot at 2.6.18-rc4?

I will, though I don't see much changes in that driver...

Soeren
-- 
Sometimes, there's a moment as you're waking, when you become aware of
the real world around you, but you're still dreaming.
