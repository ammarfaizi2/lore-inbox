Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267197AbTBIKXN>; Sun, 9 Feb 2003 05:23:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267196AbTBIKXN>; Sun, 9 Feb 2003 05:23:13 -0500
Received: from node181b.a2000.nl ([62.108.24.27]:27290 "EHLO ddx.a2000.nu")
	by vger.kernel.org with ESMTP id <S267190AbTBIKXI>;
	Sun, 9 Feb 2003 05:23:08 -0500
Date: Sun, 9 Feb 2003 11:32:22 +0100 (CET)
From: Stephan van Hienen <raid@a2000.nu>
To: Andreas Dilger <adilger@clusterfs.com>
cc: linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org,
       ext2-devel@lists.sourceforge.net, "Theodore Ts'o" <tytso@mit.edu>,
       peter@chubb.wattle.id.au, tbm@a2000.nu
Subject: Re: fsck out of memory
In-Reply-To: <Pine.LNX.4.53.0302090953440.1039@ddx.a2000.nu>
Message-ID: <Pine.LNX.4.53.0302091120280.3114@ddx.a2000.nu>
References: <Pine.LNX.4.53.0302071555110.718@ddx.a2000.nu>
 <Pine.LNX.4.53.0302071800200.1306@ddx.a2000.nu> <20030207102858.P18636@schatzie.adilger.int>
 <Pine.LNX.4.53.0302090953440.1039@ddx.a2000.nu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

and yesterday had another crash (i was using the /dev/md0 mounted without
fsck(running ok for about 24h, only 1 dir was not accessable(was
created at time previous crash)

at this time a bit more info in /var/log/messages :

Feb  8 20:11:27 storage kernel: EXT2-fs error (device md(9,0)):
ext2_new_block: Allocating block in system zone - block = 536871063
Feb  8 20:11:27 storage kernel: EXT2-fs error (device md(9,0)):
ext2_new_block: Allocating block in system zone - block = 536871065
Feb  8 20:11:27 storage kernel: EXT2-fs error (device md(9,0)):
ext2_new_block: Allocating block in system zone - block = 536871071
Feb  8 20:11:27 storage kernel: EXT2-fs error (device md(9,0)):
ext2_new_block: Allocating block in system zone - block = 536871079
Feb  8 20:11:27 storage kernel: EXT2-fs error (device md(9,0)):
ext2_new_block: Allocating block in system zone - block = 536871081
Feb  8 20:11:27 storage kernel: EXT2-fs error (device md(9,0)):
ext2_new_block: Allocating block in system zone - block = 536871083
Feb  8 20:11:27 storage kernel: EXT2-fs error (device md(9,0)):
ext2_new_block: Allocating block in system zone - block = 536871085
Feb  8 20:11:27 storage kernel: EXT2-fs error (device md(9,0)):
ext2_new_block: Allocating block in system zone - block = 536871087
Feb  8 20:11:27 storage kernel: EXT2-fs error (device md(9,0)):
ext2_new_block: Allocating block in system zone - block = 536871095
Feb  8 20:11:27 storage kernel: EXT2-fs error (device md(9,0)):
ext2_new_block: Allocating block in system zone - block = 536871103
Feb  8 20:11:27 storage kernel: EXT2-fs error (device md(9,0)):
ext2_new_block: Allocating block in system zone - block = 536871108
Feb  8 20:11:27 storage kernel: EXT2-fs error (device md(9,0)):
ext2_new_block: Allocating block in system zone - block = 536871114
Feb  8 20:11:27 storage kernel: EXT2-fs error (device md(9,0)):
ext2_new_block: Allocating block in system zone - block = 536871119
Feb  8 20:11:27 storage kernel: EXT2-fs error (device md(9,0)):
ext2_new_block: Allocating block in system zone - block = 536871121
Feb  8 20:11:27 storage kernel: EXT2-fs error (device md(9,0)):
ext2_new_block: Allocating block in system zone - block = 536871123
Feb  8 20:11:27 storage kernel: EXT2-fs error (device md(9,0)):
ext2_new_block: Allocating block in system zone - block = 536871127
Feb  8 20:11:27 storage kernel: EXT2-fs error (device md(9,0)):
ext2_new_block: Allocating block in system zone - block = 536871129
Feb  8 20:11:27 storage kernel: EXT2-fs error (device md(9,0)):
ext2_new_block: Allocating block in system zone - block = 536871135
Feb  8 20:11:27 storage kernel: EXT2-fs error (device md(9,0)):
ext2_new_block: Allocating block in system zone - block = 536871143
..
..(few minutes about the same msg's (only diffent block)
..
Feb  8 20:19:12 storage kernel: EXT2-fs error (device md(9,0)):
ext2_new_block: Allocating block in system zone - block = 540606715
Feb  8 20:19:12 storage kernel: EXT2-fs error (device md(9,0)):
ext2_new_block: Allocating block in system zone - block = 540606717
Feb  8 20:19:36 storage kernel: raid5: multiple 1 requests for sector
2064432
Feb  8 20:22:17 storage kernel: raid5: multiple 0 requests for sector
14094488
Feb  8 20:29:12 storage kernel: raid5: multiple 0 requests for sector
3670152
Feb  8 20:29:12 storage kernel: raid5: multiple 0 requests for sector
306783480
Feb  8 20:29:13 storage last message repeated 4 times
Feb  8 20:29:13 storage kernel: raid5: multiple 0 requests for sector
3670152
Feb  8 20:29:13 storage last message repeated 2 times
Feb  8 20:29:13 storage kernel: raid5: multiple 0 requests for sector
306783480
Feb  8 20:29:13 storage last message repeated 6 times
Feb  8 20:29:13 storage kernel: raid5: multiple 0 requests for sector
3670152
Feb  8 20:29:13 storage kernel: raid5: multiple 0 requests for sector
306783480
Feb  8 20:29:13 storage kernel: raid5: multiple 0 requests for sector 6496
Feb  8 20:29:13 storage last message repeated 5 times
Feb  8 20:29:13 storage kernel: raid5: multiple 0 requests for sector
25792
Feb  8 20:29:13 storage last message repeated 5 times
Feb  8 20:29:14 storage kernel: raid5: multiple 0 requests for sector
306783480
Feb  8 20:29:14 storage kernel: raid5: multiple 0 requests for sector
3670152
Feb  8 20:29:14 storage last message repeated 2 times
Feb  8 20:29:14 storage kernel: raid5: multiple 0 requests for sector
306783480
Feb  8 20:29:14 storage last message repeated 4 times
Feb  8 20:29:15 storage kernel: raid5: multiple 0 requests for sector
3670152
Feb  8 20:29:15 storage kernel: raid5: multiple 0 requests for sector
306783480
Feb  8 20:29:15 storage last message repeated 2 times
Feb  8 20:29:16 storage kernel: raid5: multiple 0 requests for sector
3670152
Feb  8 20:29:16 storage kernel: raid5: multiple 0 requests for sector
306783480
Feb  8 20:29:16 storage last message repeated 2 times
Feb  8 20:29:16 storage kernel: raid5: multiple 0 requests for sector 6496
Feb  8 20:29:16 storage last message repeated 2 times
Feb  8 20:29:16 storage kernel: raid5: multiple 0 requests for sector
25792
Feb  8 20:29:16 storage last message repeated 2 times
Feb  8 20:29:16 storage kernel: raid5: multiple 0 requests for sector
306783480
Feb  8 20:29:16 storage kernel: raid5: multiple 0 requests for sector
306783480
Feb  8 20:29:16 storage kernel: raid5: multiple 0 requests for sector
3670152
Feb  8 20:29:16 storage kernel: raid5: multiple 0 requests for sector
306783480
Feb  8 20:29:16 storage last message repeated 6 times
Feb  8 20:29:17 storage kernel: raid5: multiple 0 requests for sector
3670152
Feb  8 20:29:17 storage kernel: raid5: multiple 0 requests for sector
306783480
Feb  8 20:29:18 storage last message repeated 4 times
Feb  8 20:29:18 storage kernel: raid5: multiple 0 requests for sector
3670152
Feb  8 20:29:18 storage kernel: raid5: multiple 0 requests for sector
3670152
Feb  8 20:29:18 storage kernel: raid5: multiple 0 requests for sector
306783480
Feb  8 20:29:18 storage last message repeated 2 times
Feb  8 20:29:19 storage kernel: raid5: multiple 0 requests for sector
306783232
Feb  8 20:29:19 storage kernel: raid5: multiple 0 requests for sector
306783480
Feb  8 20:29:19 storage last message repeated 2 times
Feb  8 20:29:19 storage kernel: raid5: multiple 0 requests for sector
9587064
Feb  8 20:29:19 storage kernel: raid5: multiple 0 requests for sector
3670152
Feb  8 20:29:19 storage kernel: raid5: multiple 0 requests for sector
306783480
Feb  8 20:29:19 storage last message repeated 8 times
Feb  8 20:29:19 storage kernel: raid5: multiple 0 requests for sector
3670152
Feb  8 20:29:19 storage kernel: raid5: multiple 0 requests for sector
306783480
Feb  8 20:29:19 storage last message repeated 2 times
Feb  8 20:29:21 storage kernel: raid5: multiple 0 requests for sector
3670152
Feb  8 20:29:21 storage kernel: raid5: multiple 0 requests for sector
306783480
Feb  8 20:29:21 storage last message repeated 4 times
Feb  8 20:29:21 storage kernel: raid5: multiple 0 requests for sector
3670152
Feb  8 20:29:31 storage kernel: raid5: multiple 0 requests for sector
3670152
Feb  8 20:29:31 storage kernel: raid5: multiple 0 requests for sector
306783480
Feb  8 20:29:32 storage kernel: raid5: multiple 0 requests for sector
3670152
Feb  8 20:29:32 storage kernel: raid5: multiple 0 requests for sector
306783480
Feb  8 20:29:32 storage kernel: raid5: multiple 0 requests for sector 6496
Feb  8 20:29:32 storage last message repeated 5 times
Feb  8 20:29:32 storage kernel: raid5: multiple 0 requests for sector
25792

(at that time i did a powerdown (reboot was not possible))
