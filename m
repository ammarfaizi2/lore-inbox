Return-Path: <owner-linux-kernel-outgoing@vger.rutgers.edu>
Received: by vger.rutgers.edu via listexpand id <S157001AbPJQEdd>; Sun, 17 Oct 1999 00:33:33 -0400
Received: by vger.rutgers.edu id <S156965AbPJQEdZ>; Sun, 17 Oct 1999 00:33:25 -0400
Received: from 24.65.233.117.ab.wave.home.com ([24.65.233.117]:5220 "EHLO webber.adilger.net") by vger.rutgers.edu with ESMTP id <S156962AbPJQEdO>; Sun, 17 Oct 1999 00:33:14 -0400
From: Andreas Dilger <adilger@enel.ucalgary.ca>
Message-Id: <199910170419.WAA26043@webber.adilger.net>
Subject: ext2 online resizer available
To: linux-fsdevel@vger.rutgers.edu (Linux FS development list), linux-lvm@msede.com (Linux LVM mailing list), linux-kernel@vger.rutgers.edu (Linux kernel development list)
Date: Sat, 16 Oct 1999 22:19:23 -0600 (MDT)
X-Mailer: ELM [version 2.4 PL25]
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: owner-linux-kernel@vger.rutgers.edu

Hello all,
my online ext2 resizer is now available in a fully functional state.  If
the underlying partition supports it, it is possible to resize an ext2
filesystem while it is mounted and in use by applications.

This capability is provided by a kernel patch (2.2/2.3 and 2.0 versions
available - should apply cleanly to most versions as that part of the
kernel code hasn't changed much in a long time) and some user-space tools.
The amount that you can resize a filesystem depends on the block size and
whether or not you have "prepared" the filesystem for large resizes.  The
ext2 filesystem is maintained as a normal filesystem at all times, and it
can be used by a non-patched kernel at any time, and with one exception
(if you have an old e2fsck) will fsck clean after a resize.

Note that you need some way to resize the underlying partition (via LVM
probably) in order to resize the filesystem.  For testing purposes you
can also create a small filesystem on a large partition, and then resize
to fill the partition.

Patches are available at my web site:
http://www-mddsp.enel.ucalgary.ca/People/adilger/online-ext2/

The user-space tools are now part of Lennert Buytenhek's ext2resize suite:
http://www.dsv.nl/~buytenh/ext2resize/
for which a patch is required from my site.

Please give it a good testing, as I haven't been able to find any problems
while putting a hundred copies of an 11MB filesystem tree into a filesystem
while doing thousands of resizes to the same mounted filesystem.

Cheers, Andreas
-- 
Andreas Dilger  \ "If a man ate a pound of pasta and a pound of antipasto,
                 \  would they cancel out, leaving him still hungry?"
http://www-mddsp.enel.ucalgary.ca/People/adilger/               -- Dogbert

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.rutgers.edu
Please read the FAQ at http://www.tux.org/lkml/
