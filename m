Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263407AbREXH6h>; Thu, 24 May 2001 03:58:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263408AbREXH61>; Thu, 24 May 2001 03:58:27 -0400
Received: from zeus.kernel.org ([209.10.41.242]:63630 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S263407AbREXH6Q>;
	Thu, 24 May 2001 03:58:16 -0400
From: Andreas Dilger <adilger@turbolinux.com>
Message-Id: <200105240658.f4O6wEWq031945@webber.adilger.int>
Subject: Re: Dying disk and filesystem choice.
In-Reply-To: <m3bsoj2zsw.fsf@kloof.cr.au> "from monkeyiq at May 24, 2001 01:25:51
 pm"
To: monkeyiq <monkeyiq@users.sourceforge.net>
Date: Thu, 24 May 2001 00:58:14 -0600 (MDT)
CC: linux-kernel@vger.kernel.org
X-Mailer: ELM [version 2.4ME+ PL87 (25)]
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

It was written:
>   To keep it short and sweet, I have a 45Gb IBM drive that
> is slowly dying by getting more bad sectors. I have already
> returned my first one to get the current disk, so would like
> to use the current one for a while before returning it for 
> another disk that will prolly just start dying again.
> 
> I am using reiserfs at the moment, which doesn't really like 
> to work on a dying drive. for example, doing a make fails to
> work even though it is *creating* files on the disk, it fails
> to do so because it hits new bad sectors and doesn't seem to
> remap them. 
> 
> I am wondering what advise on filesystem choice the list as
> and any other options I can use to get the kernel to remap
> bad blocks.

Well reiserfs is probably a very bad choice at this point.  It
does not have any bad blocks support (yet), so as soon as you have
a bad block you are stuck.

You should probably use ext2, along with the badblocks program to
check which blocks in the disk are bad.  It will do a read-write
test, and either your disk will remap the bad blocks, or they will
be detected.

Even so, keep your backups current...

Cheers, Andreas
-- 
Andreas Dilger  \ "If a man ate a pound of pasta and a pound of antipasto,
                 \  would they cancel out, leaving him still hungry?"
http://www-mddsp.enel.ucalgary.ca/People/adilger/               -- Dogbert
