Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136155AbRAMBnw>; Fri, 12 Jan 2001 20:43:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135606AbRAMBnd>; Fri, 12 Jan 2001 20:43:33 -0500
Received: from [24.65.192.120] ([24.65.192.120]:53486 "EHLO webber.adilger.net")
	by vger.kernel.org with ESMTP id <S132417AbRAMBnb>;
	Fri, 12 Jan 2001 20:43:31 -0500
From: Andreas Dilger <adilger@turbolinux.com>
Message-Id: <200101130143.f0D1hNF19829@webber.adilger.net>
Subject: Re: *** ANNOUNCEMENT *** LVM 0.9.1 beta1 available at www.sistina.com
In-Reply-To: <20010113114507.D15915@linuxcare.com> "from Anton Blanchard at Jan
 13, 2001 11:45:07 am"
To: Anton Blanchard <anton@linuxcare.com.au>
Date: Fri, 12 Jan 2001 18:43:23 -0700 (MST)
CC: Mauelshagen@sistina.com, linux-kernel@vger.kernel.org,
        linux-lvm@sistina.com, lvm@sistina.com
X-Mailer: ELM [version 2.4ME+ PL73 (25)]
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Anton, you write:
> Have a look at 2.4, arch/sparc64/kernel/ioctl32.c

Yuk.

> Would it be possible to clean up the ioctl interface so we dont need
> such large hacks for LVM support? I can do the work but I want to be
> sure you guys will agree to it.

What is the reason for all this?  Alignment/wordsize/other?  If you look
at the IOP10 code, much of the in-core data structs were changed to int
or long, so this sparc code may not be necessary.  It may in fact be
damaging, because I don't know if any of the LVM developers even know it
is there, and surely it will be out of sync...

Cheers, Andreas
-- 
Andreas Dilger  \ "If a man ate a pound of pasta and a pound of antipasto,
                 \  would they cancel out, leaving him still hungry?"
http://www-mddsp.enel.ucalgary.ca/People/adilger/               -- Dogbert
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
