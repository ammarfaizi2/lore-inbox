Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130151AbQKUTCu>; Tue, 21 Nov 2000 14:02:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130083AbQKUTCl>; Tue, 21 Nov 2000 14:02:41 -0500
Received: from h24-65-192-120.cg.shawcable.net ([24.65.192.120]:25841 "EHLO
	webber.adilger.net") by vger.kernel.org with ESMTP
	id <S129700AbQKUTCd>; Tue, 21 Nov 2000 14:02:33 -0500
From: Andreas Dilger <adilger@turbolinux.com>
Message-Id: <200011211832.eALIWDD20416@webber.adilger.net>
Subject: Re: Ext2 & Performances
In-Reply-To: <4.3.2.7.2.20001121190033.00d23bc0@mail.tekno-soft.it>
 "from Roberto Fichera at Nov 21, 2000 07:16:19 pm"
To: Roberto Fichera <kernel@tekno-soft.it>
Date: Tue, 21 Nov 2000 11:32:13 -0700 (MST)
CC: Jakob Østergaard <jakob@unthought.net>,
        linux-kernel@vger.kernel.org
X-Mailer: ELM [version 2.4ME+ PL73 (25)]
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Roberto Fichera writes:
> I'm configuring a Compaq ML350 2x800PIII, 1Gb RAM, 5x36Gb UWS3 RAID 5
> with Smart Array 4300, as database SQL server. So I need to chose 
> between a single partition of 130Gb or multiple small partitions,
> depending by the performance.

It is usually better to have multiple small partitions for performance and
reliability, but this is more work to administer.

> Yes! I know :-((!!! I'm looking for other fs that are journaled like ext3 
> or raiserfs but I don't know which are a good choice for stability and
> performances.

The current (0.0.5b) ext3 code is doing pretty good, and if you use
metadata-only journalling it is about as fast as ext2.  I still wouldn't
use this on a production system where data loss is fatal, although I
have never had any data loss or filesystem corruption because of ext3.

Cheers, Andreas
-- 
Andreas Dilger  \ "If a man ate a pound of pasta and a pound of antipasto,
                 \  would they cancel out, leaving him still hungry?"
http://www-mddsp.enel.ucalgary.ca/People/adilger/               -- Dogbert
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
