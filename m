Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129556AbRBBHkD>; Fri, 2 Feb 2001 02:40:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129652AbRBBHjn>; Fri, 2 Feb 2001 02:39:43 -0500
Received: from edtn006530.hs.telusplanet.net ([161.184.137.180]:35590 "EHLO
	mail.harddata.com") by vger.kernel.org with ESMTP
	id <S129556AbRBBHjk>; Fri, 2 Feb 2001 02:39:40 -0500
Date: Fri, 2 Feb 2001 00:39:35 -0700
From: Michal Jaegermann <michal@harddata.com>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.4.1 not fully sane on Alpha - file systems
Message-ID: <20010202003933.A29458@mail.harddata.com>
In-Reply-To: <20010131234925.A14300@ellpspace.math.ualberta.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.95.5us
In-Reply-To: <20010131234925.A14300@ellpspace.math.ualberta.ca>; from Michal Jaegermann on Wed, Jan 31, 2001 at 11:49:25PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

To follow my own message about lockups on UP1100.  This time I tried
to boot 2.4.1-ac1.  Results are really the same but this time
an attempt to copy kernel source from a partition on a SCSI drive
to another one on an IDE drive brought different message.  I include
it below.

When trying to immediatly reboot with this kernel a machine locks
up in the middle of fsck.  Luckily 2.2.18 does not have problems with
that or other disk operations for that matter.

Here is what I collected in logs this time before a machine went "poof".


kernel: EXT2-fs error (device ide0(3,1)): ext2_new_block: Allocating block in system zone - block = 753664
kernel: EXT2-fs error (device ide0(3,1)): ext2_new_block: Allocating block in system zone - block = 753664
kernel: EXT2-fs error (device ide0(3,1)): ext2_free_blocks: Freeing blocks in system zones - Block = 753665, count = 1
kernel: EXT2-fs error (device ide0(3,1)): ext2_new_block: Allocating block in system zone - block = 753683
kernel: EXT2-fs error (device ide0(3,1)): ext2_free_blocks: Freeing blocks in system zones - Block = 753686, count = 5
kernel: EXT2-fs error (device ide0(3,1)): ext2_add_entry: bad entry in directory #379108: inode out of bounds - offset=0, inode=4049125, rec_len=12, name_len=1
last message repeated 10 times
kernel: EXT2-fs error (device ide0(3,1)): ext2_new_block: Allocating block in system zone - block = 753686
kernel: EXT2-fs error (device ide0(3,1)): ext2_new_block: Allocating block in system zone - block = 753687
kernel: EXT2-fs error (device ide0(3,1)): ext2_free_blocks: Freeing blocks in system zones - Block = 753688, count = 7
kernel: EXT2-fs error (device ide0(3,1)): ext2_new_block: Allocating block in system zone - block = 753688
kernel: EXT2-fs error (device ide0(3,1)): ext2_free_blocks: Freeing blocks in system zones - Block = 753689, count = 7
kernel: EXT2-fs error (device ide0(3,1)): ext2_new_block: Allocating block in system zone - block = 753700
kernel: EXT2-fs error (device ide0(3,1)): ext2_free_blocks: Freeing blocks in system zones - Block = 753702, count = 6
kernel: EXT2-fs error (device ide0(3,1)): ext2_new_block: Allocating block in system zone - block = 753702
kernel: EXT2-fs error (device ide0(3,1)): ext2_free_blocks: Freeing blocks in system zones - Block = 753705, count = 5
kernel: EXT2-fs error (device ide0(3,1)): ext2_new_block: Allocating block in system zone - block = 753734
kernel: EXT2-fs error (device ide0(3,1)): ext2_free_blocks: Freeing blocks in system zones - Block = 753739, count = 3
kernel: EXT2-fs error (device ide0(3,1)): ext2_new_block: Allocating block in system zone - block = 753739
kernel: EXT2-fs error (device ide0(3,1)): ext2_free_blocks: Freeing blocks in system zones - Block = 753746, count = 1
kernel: EXT2-fs error (device ide0(3,1)): ext2_new_block: Allocating block in system zone - block = 753746
kernel: EXT2-fs error (device ide0(3,1)): ext2_free_blocks: Freeing blocks in system zones - Block = 753747, count = 7
kernel: EXT2-fs error (device ide0(3,1)): ext2_new_block: Allocating block in system zone - block = 753747

BTW - on a target disk there are no traces that somebody attempted to
copy something.

  Michal
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
