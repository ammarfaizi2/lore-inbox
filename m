Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130880AbRARKCi>; Thu, 18 Jan 2001 05:02:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132011AbRARKC2>; Thu, 18 Jan 2001 05:02:28 -0500
Received: from [24.65.192.120] ([24.65.192.120]:15090 "EHLO webber.adilger.net")
	by vger.kernel.org with ESMTP id <S130880AbRARKCS>;
	Thu, 18 Jan 2001 05:02:18 -0500
From: Andreas Dilger <adilger@turbolinux.com>
Message-Id: <200101181001.f0IA11I25258@webber.adilger.net>
Subject: Re: Is sendfile all that sexy?
In-Reply-To: <200101180823.JAA18205@cave.bitwizard.nl> "from Rogier Wolff at
 Jan 18, 2001 09:23:15 am"
To: Rogier Wolff <R.E.Wolff@bitwizard.nl>
Date: Thu, 18 Jan 2001 03:01:01 -0700 (MST)
CC: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
X-Mailer: ELM [version 2.4ME+ PL73 (25)]
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Roger Wolff writes:
> I'd prefer an interface that says "copy this fd to that one, and
> optimize that if you can".
> 
> For example, copying a file from one disk to another. I'm pretty sure
> that some efficiency can be gained if you don't need to handle the
> possibility of the userspace program accessing the data in between the
> read and the write. Sure this may not qualify as a "trivial
> optimization, that can be done with the existing infrastructure" right
> now, but programs that want to indicate "kernel, please optimize this
> if you can" can say so.

Actually, this is a great example, because at one point I was working
on a device interface which would offload all of the disk-disk copying
overhead to the disks themselves, and not involve the CPU/RAM at all.

I seem to recall that I2O promised something along these lines as well
(i.e. direct device-device communication).

Cheers, Andreas
-- 
Andreas Dilger  \ "If a man ate a pound of pasta and a pound of antipasto,
                 \  would they cancel out, leaving him still hungry?"
http://www-mddsp.enel.ucalgary.ca/People/adilger/               -- Dogbert
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
