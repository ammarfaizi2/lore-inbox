Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131455AbRAPAaL>; Mon, 15 Jan 2001 19:30:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131413AbRAPAaB>; Mon, 15 Jan 2001 19:30:01 -0500
Received: from [24.65.192.120] ([24.65.192.120]:35317 "EHLO webber.adilger.net")
	by vger.kernel.org with ESMTP id <S131394AbRAPA3v>;
	Mon, 15 Jan 2001 19:29:51 -0500
From: Andreas Dilger <adilger@turbolinux.com>
Message-Id: <200101160029.f0G0TkJ30031@webber.adilger.net>
Subject: Re: FS corruption on 2.4.0-ac8
In-Reply-To: <3A637E15.DDC8C38@telemach.net> "from Jure Pecar at Jan 15, 2001
 11:47:49 pm"
To: Jure Pecar <pegasus@telemach.net>
Date: Mon, 15 Jan 2001 17:29:46 -0700 (MST)
CC: linux-kernel@vger.kernel.org
X-Mailer: ELM [version 2.4ME+ PL73 (25)]
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jure, you write:
> I was running 2.4.0test10pre5 happily for months and wanted to see how
> things stand in the 'latest stuff'. Here's what i found:
> 
> I compiled 2.4.0-ac8 with nearly the same .config as test10pre5 (with
> latest gcc on rh7). Then i booted it and used X for some normal browsing
> and mp3s. Performance was poor, responsivness also, even the mouse
> stopped responding for a couple of seconds at a time, a lot of disk
> trashing & so on. I deceided to boot test10 back, and there was a nasty
> suprise: fsck found filesystem with errors, and LOTS of them ... i had
> to hold down 'y' for almost 5 minutes ... :)
> 
> Then i examined the logs for what would be the cause for this ... and
> here's what 2.4.0-ac8 left in the logs:
> 
> Jan 14 16:26:47 open kernel: ee_blocks: Freeing blocks not in datazone -
> block = 979727457, count = 1
> Jan 14 16:26:47 open kernel: EXT2-fs error (device md(9,1)):
> ext2_free_blocks: Freeing blocks not in datazone - block = 1769096736,
> count = 1
> Jan 14 16:26:47 open kernel: EXT2-fs error (device md(9,1)):
> ext2_free_blocks: Freeing blocks not in datazone - block = 842080300,
> count = 1
> Jan 14 16:26:47 open kernel: EXT2-fs error (device md(9,1)):
> ext2_free_blocks: Freeing blocks not in datazone - block = 1851869728,
> count = 1
> Jan 14 16:26:47 open kernel: EXT2-fs error (device md(9,1)):
> ext2_free_blocks: Freeing blocks not in datazone - block = 808464928,
> count = 1
> ...
> and so on for about 150 such lines in 3 seconds.

These block numbers read as "ate: Fri, 12 Jan 200" (i.e. part of an email
header) if you convert to 32-bit hex, then ascii.  There was another report
of corruption like this under 2.4.0 as well.

> Is this a known problem? If it's not, please advise me on how to provide
> more usefull informations.

Actually, I thought there were problems in the test11? through test-13
kernels of this sort.  I'm not sure exactly when it started, but a search
of l-k should locate it.  Depending on when last you fsck'd your filesystem,
you may have already had some of these disk problems.  However, there was
another report recently on 2.4.0 that looked the same, and that user had
just e2fsck'd his filesystem before booting 2.4.0 for the first time after
running only 2.2, so it looks like a 2.4.0 bug.

Cheers, Andreas
-- 
Andreas Dilger  \ "If a man ate a pound of pasta and a pound of antipasto,
                 \  would they cancel out, leaving him still hungry?"
http://www-mddsp.enel.ucalgary.ca/People/adilger/               -- Dogbert
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
