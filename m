Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265444AbTLSEjs (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Dec 2003 23:39:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265445AbTLSEjs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Dec 2003 23:39:48 -0500
Received: from bgp01038448bgs.sothwt01.mi.comcast.net ([68.43.98.24]:39296
	"EHLO fire-eyes.dynup.net") by vger.kernel.org with ESMTP
	id S265444AbTLSEjq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Dec 2003 23:39:46 -0500
Message-ID: <3FE28116.3000406@fire-eyes.dynup.net>
Date: Thu, 18 Dec 2003 23:39:50 -0500
From: fire-eyes <sgtphou@fire-eyes.dynup.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6b) Gecko/20031208 Thunderbird/0.4
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: 2.6.0: reiserfs errors: reiserfs_read_locked_inode and friends
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, thanks for taking the time to read this.

I have been experimenting between 2.4.23 and 2.6.0-test{5,6,7,8,9,10,11} 
and now 2.6.0.

Starting with -test11, I noticed often that I could not perform a 
startx, and as root got permission denied trying to execute or even list 
some files. I also notice this in 2.6.0. Dropping back to 2.4.23, I can 
perform the mentioned actions.

My motherboard is an Asus A7M266-D, and I run two AMD XP 1800+ CPU's. I 
am using a Seagate ST3120023A IDE disk drive.

Here is what I'm seeing in logs:

Dec 18 22:29:40 localhost kernel: blk: queue dfd8fc00, I/O limit 4095Mb 
(mask 0xffffffff)
Dec 18 22:29:40 localhost kernel: hda: dma_intr: status=0x58 { 
DriveReady SeekComplete DataRequest }
Dec 18 22:29:40 localhost kernel:
Dec 18 22:29:40 localhost kernel: hda: set_drive_speed_status: 
status=0x58 { DriveReady SeekComplete DataRequest }
Dec 18 22:29:40 localhost kernel: ide0: Drive 0 didn't accept speed 
setting. Oh, well.
Dec 18 22:29:40 localhost kernel: blk: queue dfd8f800, I/O limit 4095Mb 
(mask 0xffffffff)
Dec 18 22:29:40 localhost kernel: is_tree_node: node level 0 does not 
match to the expected one 2
Dec 18 22:29:40 localhost kernel: vs-5150: search_by_key: invalid format 
found in block 8397. Fsck?
Dec 18 22:29:40 localhost kernel: vs-13070: reiserfs_read_locked_inode: 
i/o failure occurred trying to find stat data of [373169 373
170 0x0 SD]
Dec 18 22:29:48 localhost kernel: eth0: no IPv6 routers present
Dec 18 22:29:54 localhost kernel: is_tree_node: node level 0 does not 
match to the expected one 2
Dec 18 22:29:54 localhost kernel: vs-5150: search_by_key: invalid format 
found in block 8397. Fsck?
Dec 18 22:29:54 localhost kernel: vs-13070: reiserfs_read_locked_inode: 
i/o failure occurred trying to find stat data of [388986 388
990 0x0 SD]

Here is what i'm passing to 2.6.0 via grub:

root=/dev/hda6 ide0=autotune ide1=autotune

The kernel claims the reiserfs partitions are "3.6" format.

Any other information I can give to assist?
