Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277005AbRJCWAL>; Wed, 3 Oct 2001 18:00:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277007AbRJCWAC>; Wed, 3 Oct 2001 18:00:02 -0400
Received: from ns.caldera.de ([212.34.180.1]:7651 "EHLO ns.caldera.de")
	by vger.kernel.org with ESMTP id <S277006AbRJCV7z>;
	Wed, 3 Oct 2001 17:59:55 -0400
Date: Wed, 3 Oct 2001 23:56:19 +0200
Message-Id: <200110032156.f93LuJb01378@ns.caldera.de>
From: Christoph Hellwig <hch@ns.caldera.de>
To: viro@math.psu.edu (Alexander Viro)
Cc: "Vladimir V. Saveliev" <vs@namesys.com>, linux-kernel@vger.kernel.org,
        reiserfs-list@namesys.com, Linus Torvalds <torvalds@transmeta.com>
Subject: Re: [PATCH] Re: bug? in using generic read/write functions to read/write block devices  in 2.4.11-pre2
X-Newsgroups: caldera.lists.linux.kernel
In-Reply-To: <Pine.GSO.4.21.0110031643130.23558-100000@weyl.math.psu.edu>
User-Agent: tin/1.4.4-20000803 ("Vet for the Insane") (UNIX) (Linux/2.4.2 (i686))
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Al,

In article <Pine.GSO.4.21.0110031643130.23558-100000@weyl.math.psu.edu> you wrote:
> Moreover, ->release() for block_device also doesn't care for the junk
> we pass - it only uses inode->i_rdev.  In all cases.  And I'd rather
> see it them as
> 	int (*open)(struct block_device *bdev, int flags, int mode);
> 	int (*release)(struct block_device *bdev);
> 	int (*check_media_change)(struct block_device *bdev);
> 	int (*revalidate)(struct block_device *bdev);
> - that would make more sense than the current variant.  They are block_device
> methods, not file or inode ones, after all.

How about starting 2.5 with that patch ones 2.4.11 is done?  Linus?

	Christoph

-- 
Of course it doesn't work. We've performed a software upgrade.
