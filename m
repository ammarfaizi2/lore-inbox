Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132872AbRDPIQW>; Mon, 16 Apr 2001 04:16:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132875AbRDPIQM>; Mon, 16 Apr 2001 04:16:12 -0400
Received: from h24-65-193-28.cg.shawcable.net ([24.65.193.28]:252 "EHLO
	webber.adilger.int") by vger.kernel.org with ESMTP
	id <S132872AbRDPIQC>; Mon, 16 Apr 2001 04:16:02 -0400
From: Andreas Dilger <adilger@turbolinux.com>
Message-Id: <200104160815.f3G8Fu9q000746@webber.adilger.int>
Subject: Re: lilo + raid + kernel-2.4.x failure to boot
To: Linux kernel development list <linux-kernel@vger.kernel.org>
Date: Mon, 16 Apr 2001 02:15:56 -0600 (MDT)
X-Mailer: ELM [version 2.4ME+ PL87 (25)]
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linas Vepstas writes:
> BTW, I noticed that oddly, every time I ran lilo, and then ran
> lilo -q -v -v, it reported different sector numbers for the kernel
> images.  This freaked me out at first, but I came to accept it as normal:
> doesn't affect bootability.  But is this really w.a.d? (I was assuming,
> appearently erroneously, that lilo -q -v -v was reporting the physical
> location of the kernel image on the disk; but since the numbers bounce
> around, that can't be right.  Or is this just weird bios head/cyl/sect
> math flakiness?)

No, I noticed this behaviour as well.  You run "lilo -v 5" once you get
one set of numbers, you run it a second time, you get another set of
numbers.  It repeats every 2 lilo runs.  I believe it has something to
do with the map file, and keeping a backup copy thereof.

Sorry, this doesn't help your RAID problem.

Note, can you boot from one of the separate RAID drives with the Debian
LILO directly?  Have you tried CHS, LBA32, and linear options to lilo?

Cheers, Andreas
-- 
Andreas Dilger  \ "If a man ate a pound of pasta and a pound of antipasto,
                 \  would they cancel out, leaving him still hungry?"
http://www-mddsp.enel.ucalgary.ca/People/adilger/               -- Dogbert
