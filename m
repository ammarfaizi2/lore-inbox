Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131307AbRCNFUu>; Wed, 14 Mar 2001 00:20:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131305AbRCNFUl>; Wed, 14 Mar 2001 00:20:41 -0500
Received: from h24-65-192-120.cg.shawcable.net ([24.65.192.120]:11771 "EHLO
	webber.adilger.int") by vger.kernel.org with ESMTP
	id <S131297AbRCNFUb>; Wed, 14 Mar 2001 00:20:31 -0500
From: Andreas Dilger <adilger@turbolinux.com>
Message-Id: <200103140519.f2E5JD606622@webber.adilger.int>
Subject: Re: (struct dentry *)->vfsmnt;
In-Reply-To: <Pine.GSO.4.21.0103140010050.2506-100000@weyl.math.psu.edu> from
 Alexander Viro at "Mar 14, 2001 00:11:06 am"
To: Alexander Viro <viro@math.psu.edu>
Date: Tue, 13 Mar 2001 22:19:13 -0700 (MST)
CC: Linux kernel development list <linux-kernel@vger.kernel.org>,
        Linux FS development list <linux-fsdevel@vger.kernel.org>
X-Mailer: ELM [version 2.4ME+ PL66 (25)]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Al writes:
> > How about the first one?  The one that calls the "read_super" method.
> > AFAICT, only the first mount calls down to the FS anyways (the rest
> > is VFS internal).
> 
> And what should that be after
> 
> mount -t ext2 /dev/sda1 /mnt
> mount --bind /mnt /tmp/foo
> umount /mnt

Yes, I know you _can_ do all sorts of tricks like this, but most people
don't really do it.  In any case, I would be happy if I could even get
"/mnt" from the first mount.  If it comes to the point where I can get
that, then I will start to worry about "mount --bind".

This is to store in the ext2 on-disk superblock, which is currently always
(from dumpe2fs -h /dev/hdX):

Last mounted on:          <not available>

To be able to put _something_ there will suit my needs.

Cheers, Andreas
-- 
Andreas Dilger  \ "If a man ate a pound of pasta and a pound of antipasto,
                 \  would they cancel out, leaving him still hungry?"
http://www-mddsp.enel.ucalgary.ca/People/adilger/               -- Dogbert
