Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129170AbQKRQRt>; Sat, 18 Nov 2000 11:17:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129225AbQKRQRi>; Sat, 18 Nov 2000 11:17:38 -0500
Received: from h24-65-192-120.cg.shawcable.net ([24.65.192.120]:1528 "EHLO
	webber.adilger.net") by vger.kernel.org with ESMTP
	id <S129170AbQKRQRU>; Sat, 18 Nov 2000 11:17:20 -0500
From: Andreas Dilger <adilger@turbolinux.com>
Message-Id: <200011181546.eAIFkwE06889@webber.adilger.net>
Subject: Re: [PATCH] ext2 largefile fixes + [f]truncate() error value fix
In-Reply-To: <Pine.GSO.4.21.0011180503110.19917-100000@weyl.math.psu.edu>
 "from Alexander Viro at Nov 18, 2000 05:28:46 am"
To: Alexander Viro <viro@math.psu.edu>
Date: Sat, 18 Nov 2000 08:46:57 -0700 (MST)
CC: Linus Torvalds <torvalds@transmeta.com>,
        "David S. Miller" <davem@redhat.com>, linux-kernel@vger.kernel.org
X-Mailer: ELM [version 2.4ME+ PL73 (25)]
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alexander Viro writes:
> 	* #include <linux/ext2_fs.h> removed from ksyms.c. It is not
> needed there (hardly a surprise, since ext2 can be modular itself and
> it doesn't export anything). Ditto for <linux/minix_fs.h>
> 	* #include <linux/ext2_fs.h> removed from fs/nfsd/vfs.c

I've been trying to get these fixed a couple of times myself....

>  static int ext2_get_block(struct inode *inode, long iblock, struct buffer_head *bh_result, int create)

Would you be willing to accept a patch for this function which reorganizes
it to be sane - i.e. exit at the bottom and not the middle, no jumps into
the middle of "if" blocks, etc?

Cheers, Andreas
-- 
Andreas Dilger  \ "If a man ate a pound of pasta and a pound of antipasto,
                 \  would they cancel out, leaving him still hungry?"
http://www-mddsp.enel.ucalgary.ca/People/adilger/               -- Dogbert
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
