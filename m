Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130379AbRAMX6K>; Sat, 13 Jan 2001 18:58:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131061AbRAMX6A>; Sat, 13 Jan 2001 18:58:00 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:14089 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S130379AbRAMX5t>; Sat, 13 Jan 2001 18:57:49 -0500
Subject: Re: ide-floppy [Fwd: Updated ATAPI FORMAT_UNIT patch.]
To: paul@paulbristow.net (Paul Bristow)
Date: Sat, 13 Jan 2001 23:59:32 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org (linux kernel mailing list),
        alan@lxorguk.ukuu.org.uk (Alan Cox)
In-Reply-To: <3A60DA06.936CE1F2@paulbristow.net> from "Paul Bristow" at Jan 13, 2001 11:43:18 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14Haa7-0006oj-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> One of my concerns is that we don't take the ide-floppy driver in a
> different direction to the other removeable media drives.

In general the others do it raw via scsi commands and sg.

> For Alan Cox, could you back out Sam's patch for now. It will be back
> soon.

When the new one is sorted. I'm not going to feed it to Linus anyhow. For
the moment there are quite a few people glad of it 

> > > > * Ability to open the device even if there's no disk in the drive.  This
> > > > is needed by the userspace app to probe the device.  The open path sends a


Other devices allow this for O_NDELAY only.


> > 1) A separate minor device that will open whether or not there's a
> > formatted disk in the drive.  I don't like this approach.

Ugly. Thats a lot of extra devices.

> > The O_EXCL trick seems the cleanest way to be able to access the device

Use the same O_NDELAY cdroms do

> > Suppose that two months from now the Clik drive gets new firmware that
> > reports a slightly different model ID, say "IOMEGA Clik! 80 CZ ATAPI".
> > Or, perhaps, it's a new model of the Clik drive, that shares the same
> > shortcomings.
> 
> Yep. Looks extremely possible.  

Nod. I've already suggested a seperate blacklist table of device id/flaws
as SCSI does

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
