Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131402AbRAaBHF>; Tue, 30 Jan 2001 20:07:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131374AbRAaBGp>; Tue, 30 Jan 2001 20:06:45 -0500
Received: from h24-65-192-120.cg.shawcable.net ([24.65.192.120]:29424 "EHLO
	webber.adilger.net") by vger.kernel.org with ESMTP
	id <S131124AbRAaBGf>; Tue, 30 Jan 2001 20:06:35 -0500
From: Andreas Dilger <adilger@turbolinux.com>
Message-Id: <200101310105.f0V15qi03324@webber.adilger.net>
Subject: Re: Multiple SCSI host adapters, naming of attached devices
In-Reply-To: <20010130224912.A388@kermit.wd21.co.uk> from Michael Pacey at "Jan
 30, 2001 10:49:12 pm"
To: Michael Pacey <michael@wd21.co.uk>
Date: Tue, 30 Jan 2001 18:05:51 -0700 (MST)
CC: linux-kernel@vger.kernel.org
X-Mailer: ELM [version 2.4ME+ PL66 (25)]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Michael Pacey writes:
> Given two host adapters each with 1 disk of ID 0, how do I tell Linux which
> is sda and which sdb?

You can't - you need to make sure either the cards are different and check
the SCSI host probe order, or the detection order in the PCI bus.  You
should only need to do this once, and simply use the order you get.

> After this I'll be filling the 2nd SCSI chain completely, so assigning a
> different ID is not an option.

If you are using ext2 filesystems, you don't care which is which, because
you can mount by filesystem UUID or LABEL, so just ignore the device names.
The same is true with LVM.

Cheers, Andreas
-- 
Andreas Dilger  \ "If a man ate a pound of pasta and a pound of antipasto,
                 \  would they cancel out, leaving him still hungry?"
http://www-mddsp.enel.ucalgary.ca/People/adilger/               -- Dogbert
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
