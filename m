Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269693AbRISXkV>; Wed, 19 Sep 2001 19:40:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274273AbRISXkK>; Wed, 19 Sep 2001 19:40:10 -0400
Received: from [195.223.140.107] ([195.223.140.107]:36081 "EHLO athlon.random")
	by vger.kernel.org with ESMTP id <S269693AbRISXjz>;
	Wed, 19 Sep 2001 19:39:55 -0400
Date: Thu, 20 Sep 2001 01:40:17 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Alexander Viro <viro@math.psu.edu>
Cc: Linus Torvalds <torvalds@transmeta.com>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.4.10-pre11
Message-ID: <20010920014017.E720@athlon.random>
In-Reply-To: <20010920010338.B720@athlon.random> <Pine.GSO.4.21.0109191915120.901-100000@weyl.math.psu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.GSO.4.21.0109191915120.901-100000@weyl.math.psu.edu>; from viro@math.psu.edu on Wed, Sep 19, 2001 at 07:30:55PM -0400
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 19, 2001 at 07:30:55PM -0400, Alexander Viro wrote:
> "swapon() messing with block_size when accidentially called for mounted

swap should never change softblocksize etc.. the concept of
softblocksize will die as soon as we make the buffercache - physically
address space backed.

> Umm... Not doing unnecessary work?  Semantics of releasing a block device
> depends on the kind of use.  BTW, I'm less than sure that fsync_dev() is
> the right thing for file access now that you've got that in pagecache -
> __block_fsync() seems to be more correct thing to do.

Not really, blkdev isn't a filesystem. It will never have a superblock
and its own inodes and we also need to filemap_fdatasync/wait the
physical address space.

> /me goes to get some sleep.

night.

Andrea
