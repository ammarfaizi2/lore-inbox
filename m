Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129387AbRAEIAx>; Fri, 5 Jan 2001 03:00:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129777AbRAEIAo>; Fri, 5 Jan 2001 03:00:44 -0500
Received: from [24.65.192.120] ([24.65.192.120]:65526 "EHLO webber.adilger.net")
	by vger.kernel.org with ESMTP id <S129387AbRAEIAd>;
	Fri, 5 Jan 2001 03:00:33 -0500
From: Andreas Dilger <adilger@turbolinux.com>
Message-Id: <200101050800.f0580He12396@webber.adilger.net>
Subject: Re: Journaling: Surviving or allowing unclean shutdown?
In-Reply-To: <3A5515D0.7F21E668@innominate.de> "from Daniel Phillips at Jan 5,
 2001 01:31:12 am"
To: Daniel Phillips <phillips@innominate.de>
Date: Fri, 5 Jan 2001 01:00:17 -0700 (MST)
CC: "Stephen C. Tweedie" <sct@redhat.com>, linux-kernel@vger.kernel.org
X-Mailer: ELM [version 2.4ME+ PL73 (25)]
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Daniel writes:
> Yes, and so long as your journal is not on another partition/disk things
> will eventually be set right.  The combination of a partially updated
> filesystem and its journal is in some sense a complete, consistent
> filesystem.
> 
> I'm curious - how does ext3 handle the possibility of a crash during
> journal recovery?

Unless Stephen says otherwise, my understanding is that a crash during
journal recovery will just mean the journal is replayed again at the next
recovery.  Because the ext3 journal is just a series of data blocks to
be copied into the filesystem (rather than "actions" to be done), it
doesn't matter how many times it is done.  The recovery flags are not
reset until after the journal replay is completed.

Cheers, Andreas
-- 
Andreas Dilger  \ "If a man ate a pound of pasta and a pound of antipasto,
                 \  would they cancel out, leaving him still hungry?"
http://www-mddsp.enel.ucalgary.ca/People/adilger/               -- Dogbert
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
