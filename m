Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129643AbRBXWFR>; Sat, 24 Feb 2001 17:05:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129649AbRBXWFI>; Sat, 24 Feb 2001 17:05:08 -0500
Received: from [209.53.18.145] ([209.53.18.145]:20352 "EHLO continuum.cm.nu")
	by vger.kernel.org with ESMTP id <S129643AbRBXWFC>;
	Sat, 24 Feb 2001 17:05:02 -0500
Date: Sat, 24 Feb 2001 14:04:59 -0800
From: Shane Wegner <shane@cm.nu>
To: linux-kernel@vger.kernel.org
Subject: ext2 errors under 2.4.2
Message-ID: <20010224140459.A3313@cm.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
Organization: Continuum Systems, Vancouver, Canada
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I received the following errors while trying out 2.4.2. 
After going back to 2.2.19prexx and doing an fsck, it works
fine.  They came up after about six hours or so of running
time.

EXT2-fs warning (device md(9,5)): ext2_unlink: Deleting nonexistent file (7635227), 0
EXT2-fs error (device md(9,5)): ext2_free_blocks: Freeing blocks not in datazone - block = 982921785, count = 1
EXT2-fs error (device md(9,5)): ext2_free_blocks: Freeing blocks not in datazone - block = 982921785, count = 1
EXT2-fs error (device md(9,5)): ext2_free_blocks: Freeing blocks in system zones - Block = 65536, count = 1
EXT2-fs error (device md(9,5)): ext2_free_blocks: Freeing blocks in system zones - Block = 8, count = 1
EXT2-fs warning (device md(9,5)): ext2_unlink: Deleting nonexistent file (7635226), 0
EXT2-fs error (device md(9,5)): ext2_free_blocks: Freeing blocks not in datazone - block = 982921785, count = 1
EXT2-fs error (device md(9,5)): ext2_free_blocks: Freeing blocks not in datazone - block = 982921785, count = 1
EXT2-fs error (device md(9,5)): ext2_free_blocks: Freeing blocks in system zones - Block = 65536, count = 1
EXT2-fs error (device md(9,5)): ext2_free_blocks: bit already cleared for block 65536
EXT2-fs error (device md(9,5)): ext2_free_blocks: Freeing blocks in system zones - Block = 8, count = 1
EXT2-fs error (device md(9,5)): ext2_free_blocks: bit already cleared for block 8
init_special_inode: bogus imode (1011)
init_special_inode: bogus imode (1012)
init_special_inode: bogus imode (1013)
init_special_inode: bogus imode (1026)

I'm not sure if those init_special_inode errors are
related.  /dev/md5 is an md linear array composed of two
IDE hard disks on an HPT370 IDE controler.  Both Maxtor
disks.  DMA was enabled on both disks when the errors
occurred.

Regards,
Shane

-- 
Shane Wegner: shane@cm.nu
              http://www.cm.nu/~shane/
PGP:          1024D/FFE3035D
              A0ED DAC4 77EC D674 5487
              5B5C 4F89 9A4E FFE3 035D
