Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129069AbQKCR03>; Fri, 3 Nov 2000 12:26:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129094AbQKCR0T>; Fri, 3 Nov 2000 12:26:19 -0500
Received: from h24-65-192-120.cg.shawcable.net ([24.65.192.120]:8188 "EHLO
	webber.adilger.net") by vger.kernel.org with ESMTP
	id <S129069AbQKCR0N>; Fri, 3 Nov 2000 12:26:13 -0500
From: Andreas Dilger <adilger@turbolinux.com>
Message-Id: <200011031725.eA3HPwP12932@webber.adilger.net>
Subject: Re: ext3 vs. JFS file locations...
In-Reply-To: <3A02D150.E7E87398@usa.net> "from Michael Boman at Nov 3, 2000 10:53:04
 pm"
To: Michael Boman <michael.boman@usa.net>
Date: Fri, 3 Nov 2000 10:25:58 -0700 (MST)
CC: linux-kernel@vger.kernel.org
X-Mailer: ELM [version 2.4ME+ PL73 (25)]
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Michael Boman writes:
> It seems like both IBM's JFS and ext3 wants to use fs/jfs .. IMHO that
> is like asking for problem.. A more logic location for ext3 should be
> fs/ext3, no?

Actually, if you would look in linux/fs, you will see that ext3 IS in
linux/fs/ext3.  However, there is a second component to ext3, which is
a generic block journalling layer which is called jfs.  This journal
layer is designed so that it isn't ext3 specific, so it would be
_possible_ for other journalling filesystems to use it.  Whether non-ext3
filesystems will actually use it is another question (actually the
InterMezzo distributed filesystem uses the ext3-jfs functionality to
do compound transactions on disk to ensure cluster coherency).

I think that Stephen at one time said he would change the name, but I
guess he has not done so yet.

Cheers, Andreas
-- 
Andreas Dilger  \ "If a man ate a pound of pasta and a pound of antipasto,
                 \  would they cancel out, leaving him still hungry?"
http://www-mddsp.enel.ucalgary.ca/People/adilger/               -- Dogbert
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
