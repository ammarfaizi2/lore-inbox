Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265298AbRF0IQW>; Wed, 27 Jun 2001 04:16:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265300AbRF0IQL>; Wed, 27 Jun 2001 04:16:11 -0400
Received: from h24-65-193-28.cg.shawcable.net ([24.65.193.28]:52466 "EHLO
	webber.adilger.int") by vger.kernel.org with ESMTP
	id <S265298AbRF0IP7>; Wed, 27 Jun 2001 04:15:59 -0400
From: Andreas Dilger <adilger@turbolinux.com>
Message-Id: <200106270815.f5R8FGT0001788@webber.adilger.int>
Subject: Re: mm and Oops
In-Reply-To: <UTC200106270232.EAA456067.aeb@vlet.cwi.nl> "from Andries.Brouwer@cwi.nl
 at Jun 27, 2001 04:32:16 am"
To: Andries.Brouwer@cwi.nl
Date: Wed, 27 Jun 2001 02:15:16 -0600 (MDT)
CC: linux-kernel@vger.kernel.org
X-Mailer: ELM [version 2.4ME+ PL87 (25)]
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andries writes:
> After sending util-linux out, I booted a kernel that had kdev_t
> a pointer type, to see whether that still works.
> And all (minus md/lvm/nfs that didnt compile)...

Yes, LVM totally abuses kdev_t (assumes = dev_t in user space).
Changing kdev_t should force this to be cleaned up.

> The second one is the use of a special constant B_FREE
> as device value to indicate that the buffer is free.
> I'll look at this tomorrow but perhaps someone knows:
> must the constant B_FREE (used only in fs/buffer.c) be nonzero?
> If so, then we probably need a bitfield to indicate "free".
> Otherwise we can use 0 ("no device") as value.

Isn't a device = 0 used for NFS root?

Cheers, Andreas
-- 
Andreas Dilger  \ "If a man ate a pound of pasta and a pound of antipasto,
                 \  would they cancel out, leaving him still hungry?"
http://www-mddsp.enel.ucalgary.ca/People/adilger/               -- Dogbert
