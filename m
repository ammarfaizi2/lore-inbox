Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280773AbRKOIYk>; Thu, 15 Nov 2001 03:24:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280777AbRKOIYb>; Thu, 15 Nov 2001 03:24:31 -0500
Received: from NO-SPAM.it.helsinki.fi ([128.214.205.34]:52710 "EHLO
	no-spam.it.helsinki.fi") by vger.kernel.org with ESMTP
	id <S280773AbRKOIYV>; Thu, 15 Nov 2001 03:24:21 -0500
Subject: [OT] Odd Partition overlapping problem solved.
From: Robert Holmberg <robert.holmberg@helsinki.fi>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.99.0 (Preview Release)
Date: 15 Nov 2001 10:27:52 -0500
Message-Id: <1005838073.1182.0.camel@localhost>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks to everyone for their suggestions.

I didn't use DO FDISK for partitioning since it suggests nice things
like "There is 8 GB of free space left on drive, would you like to
create a 22 GB partition?". I found some information about FDISK not
liking to create partitions after a >8GB non-dos partition.

I deleted my entire extended partition, got a freeware dos partitioning
program (Partition Manager), and created a type 'f' extended (Windows
LBA extended) partition. Now I can happily mount this partition in both
Linux and Windows, write large files (2GB) to it, read the in the other
end and not I'm experiencing corruption. So I guess the problem is
solved. I'm using a swapfile now, but I'm going to create a linux swap
partition *after* the windows partition. So here is the working version:

Device    Boot    Start       End    Blocks   Id  System
/dev/hda1   *         1       523   4200966    c  Win95 FAT32 (LBA)
/dev/hda2           524       525     16065   83  Linux
/dev/hda3           526      2647  17044965   83  Linux
/dev/hda4          2648      3736   8747392+   f  Win95 Ext'd (LBA)
/dev/hda5          2648      3736   8747361    c  Win95 FAT32 (LBA)

Thanks again,

Robert


