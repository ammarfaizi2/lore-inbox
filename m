Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135931AbRDZVBs>; Thu, 26 Apr 2001 17:01:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135936AbRDZVA4>; Thu, 26 Apr 2001 17:00:56 -0400
Received: from zeus.kernel.org ([209.10.41.242]:128 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S135922AbRDZU7j>;
	Thu, 26 Apr 2001 16:59:39 -0400
Date: Thu, 26 Apr 2001 22:21:44 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Alexander Viro <viro@math.psu.edu>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] SMP race in ext2 - metadata corruption.
Message-ID: <20010426222144.G819@athlon.random>
In-Reply-To: <Pine.GSO.4.21.0104261554050.15385-100000@weyl.math.psu.edu> <Pine.LNX.4.31.0104261303030.1118-100000@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.31.0104261303030.1118-100000@penguin.transmeta.com>; from torvalds@transmeta.com on Thu, Apr 26, 2001 at 01:08:25PM -0700
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 26, 2001 at 01:08:25PM -0700, Linus Torvalds wrote:
> But the fact is that nobody should ever do the thing that could cause
> problems.

dump in 2.4 also gets uncoherent view of the data which make things even
worse than in 2.2 (to change that we should hash in the buffer hashtable
all the bh overlapped in the pagecache and no I'm not suggesting that
relax). The only reason it has a chance to work with ext2 is because
ext2 is very dumb and it misses an inode map and in turn inodes are at a
predictable location on disk so it cannot run totally out of control.

Andrea
