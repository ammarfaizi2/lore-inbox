Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131310AbRCNGIH>; Wed, 14 Mar 2001 01:08:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131312AbRCNGH5>; Wed, 14 Mar 2001 01:07:57 -0500
Received: from h24-65-192-120.cg.shawcable.net ([24.65.192.120]:16635 "EHLO
	webber.adilger.int") by vger.kernel.org with ESMTP
	id <S131238AbRCNGHt>; Wed, 14 Mar 2001 01:07:49 -0500
From: Andreas Dilger <adilger@turbolinux.com>
Message-Id: <200103140605.f2E65tS06714@webber.adilger.int>
Subject: Re: (struct dentry *)->vfsmnt;
In-Reply-To: <Pine.GSO.4.21.0103140041140.2506-100000@weyl.math.psu.edu> from
 Alexander Viro at "Mar 14, 2001 00:49:48 am"
To: Alexander Viro <viro@math.psu.edu>
Date: Tue, 13 Mar 2001 23:05:55 -0700 (MST)
CC: Andreas Dilger <adilger@turbolinux.com>,
        Linux kernel development list <linux-kernel@vger.kernel.org>,
        Linux FS development list <linux-fsdevel@vger.kernel.org>
X-Mailer: ELM [version 2.4ME+ PL66 (25)]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Al, you write:
> On Tue, 13 Mar 2001, Andreas Dilger wrote:
> > "/mnt" from the first mount.  If it comes to the point where I can get
> > that, then I will start to worry about "mount --bind".
> > 
> > This is to store in the ext2 on-disk superblock, which is currently always
> > (from dumpe2fs -h /dev/hdX):
> > 
> > Last mounted on:          <not available>
> > 
> > To be able to put _something_ there will suit my needs.
> 
> OK... I don't like the idea of passing a vfsmount to read_super (for obvious
> reasons - ->mnt_count, for one thing), but there may be other ways to do that.
> What kind of use (aside of getting rid of <not available> in dumpe2fs
> output) do you have in mind?

On AIX, it is possible to import a volume group, and it automatically
builds /etc/fstab entries from information stored in the fs.  Having the
"last mounted on" would have the mount point info, and of course LVM
would hold the device names.

Cheers, Andreas
-- 
Andreas Dilger  \ "If a man ate a pound of pasta and a pound of antipasto,
                 \  would they cancel out, leaving him still hungry?"
http://www-mddsp.enel.ucalgary.ca/People/adilger/               -- Dogbert
