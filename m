Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131589AbQKRWij>; Sat, 18 Nov 2000 17:38:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131861AbQKRWia>; Sat, 18 Nov 2000 17:38:30 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:10953 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S131870AbQKRWiS>;
	Sat, 18 Nov 2000 17:38:18 -0500
Date: Sat, 18 Nov 2000 17:08:17 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: Andreas Dilger <adilger@turbolinux.com>
cc: Linus Torvalds <torvalds@transmeta.com>,
        "David S. Miller" <davem@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ext2 largefile fixes + [f]truncate() error value fix
In-Reply-To: <200011181546.eAIFkwE06889@webber.adilger.net>
Message-ID: <Pine.GSO.4.21.0011181655380.21893-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 18 Nov 2000, Andreas Dilger wrote:

> Alexander Viro writes:
> > 	* #include <linux/ext2_fs.h> removed from ksyms.c. It is not
> > needed there (hardly a surprise, since ext2 can be modular itself and
> > it doesn't export anything). Ditto for <linux/minix_fs.h>
> > 	* #include <linux/ext2_fs.h> removed from fs/nfsd/vfs.c
> 
> I've been trying to get these fixed a couple of times myself....
> 
> >  static int ext2_get_block(struct inode *inode, long iblock, struct buffer_head *bh_result, int create)
> 
> Would you be willing to accept a patch for this function which reorganizes

I'm neither Ted nor Stephen, so...

> it to be sane - i.e. exit at the bottom and not the middle, no jumps into
> the middle of "if" blocks, etc?

I certainly have nothing against it. If it doesn't grow the thing too much
and doesn't introduce tons of gotos on the main path... no objections from
me.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
