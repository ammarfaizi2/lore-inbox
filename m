Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268850AbRHBHwV>; Thu, 2 Aug 2001 03:52:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268849AbRHBHwM>; Thu, 2 Aug 2001 03:52:12 -0400
Received: from h24-64-71-161.cg.shawcable.net ([24.64.71.161]:25083 "EHLO
	webber.adilger.int") by vger.kernel.org with ESMTP
	id <S268847AbRHBHwA>; Thu, 2 Aug 2001 03:52:00 -0400
From: Andreas Dilger <adilger@turbolinux.com>
Message-Id: <200108020751.f727pnMf010874@webber.adilger.int>
Subject: Re: [RFT] #2 Support for ~2144 SCSI discs
In-Reply-To: <200108020642.f726g0L15715@mobilix.ras.ucalgary.ca>
 "from Richard Gooch at Aug 2, 2001 00:42:00 am"
To: Richard Gooch <rgooch@ras.ucalgary.ca>
Date: Thu, 2 Aug 2001 01:51:48 -0600 (MDT)
CC: linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
        devfs-announce-list@mobilix.ras.ucalgary.ca
X-Mailer: ELM [version 2.4ME+ PL87 (25)]
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Richard writes:
>   Hi, all. Below is my second cut of a patch that adds support for
> large numbers of SCSI discs (approximately 2144). I'd like people to
> try this out. I've fixed a couple of "minor" typos that happened to
> disable sd detection. I've also tested this patch: it works fine on my
> 3 drive system. In addition, I've switched to using vmalloc() for key
> data structures, so the kmalloc() limitations shouldn't hit us. I've
> added an in_interrupt() test to sd_init() just in case.

The real question is whether this code is limited to adding only SCSI
major numbers, or if it could be used to assign major numbers to
other subsystems (sorry I haven't looked at the code yet)?

 From our discussion last week, it _should_ be able to assign major
numbers to other systems like EVMS, which you would probably want to
use on top of those 2144 SCSI disks anyways.  However, since you are
billing this as the "2144 SCSI disk patch", I thought I would confirm.

Cheers, Andreas
-- 
Andreas Dilger  \ "If a man ate a pound of pasta and a pound of antipasto,
                 \  would they cancel out, leaving him still hungry?"
http://www-mddsp.enel.ucalgary.ca/People/adilger/               -- Dogbert

