Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130575AbRAZTZn>; Fri, 26 Jan 2001 14:25:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131388AbRAZTZd>; Fri, 26 Jan 2001 14:25:33 -0500
Received: from h24-65-192-120.cg.shawcable.net ([24.65.192.120]:59638 "EHLO
	webber.adilger.net") by vger.kernel.org with ESMTP
	id <S130575AbRAZTZS>; Fri, 26 Jan 2001 14:25:18 -0500
From: Andreas Dilger <adilger@turbolinux.com>
Message-Id: <200101261924.f0QJOWH15609@webber.adilger.net>
Subject: Re: Renaming lost+found
In-Reply-To: <20010126141350.Q6979@capsi.com> from Rob Kaper at "Jan 26, 2001
 02:13:50 pm"
To: Rob Kaper <cap@capsi.com>
Date: Fri, 26 Jan 2001 12:24:32 -0700 (MST)
CC: linux-kernel@vger.kernel.org
X-Mailer: ELM [version 2.4ME+ PL66 (25)]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rob Kaper writes:
> Is there a way to rename lost+found ?? It bothers me to see it in ls all the
> time because 99.9% of my time it's just useless and I really think
> .lost+found (a hidden file) would make much more sense for daily use. I
> assume this would require some ext2 changes as well as a patch to e2fsck
> etc. (with backwards compatibility of course)

You could also just delete it, but then you run into problems when e2fsck
is run on a broken filesystem.  Use ext3 instead.  The lost+found dir is
in many (most?) Unix filesystems, for use when things go bad.

You _could_ change it to be a hidden file, but then you would have to
remember where it was after e2fsck moves half of your files into it
after a crash.  It probably wouldn't be too much work to change e2fsck.
You also need to change mke2fs and mklost+found as well.

Cheers, Andreas
-- 
Andreas Dilger  \ "If a man ate a pound of pasta and a pound of antipasto,
                 \  would they cancel out, leaving him still hungry?"
http://www-mddsp.enel.ucalgary.ca/People/adilger/               -- Dogbert
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
