Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129259AbRBZIDi>; Mon, 26 Feb 2001 03:03:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130197AbRBZID2>; Mon, 26 Feb 2001 03:03:28 -0500
Received: from c1386196-a.eugene1.or.home.com ([65.4.49.182]:59527 "EHLO
	JTLinux.jdthomas.net") by vger.kernel.org with ESMTP
	id <S129259AbRBZIDO>; Mon, 26 Feb 2001 03:03:14 -0500
Message-ID: <3A9A10B4.70106@jdthomas.net>
Date: Mon, 26 Feb 2001 00:15:48 -0800
From: Justin Thomas <justin@jdthomas.net>
User-Agent: Mozilla/5.0 (X11; U; Linux 2.4.1 i586; en-US; m18) Gecko/20010131 Netscape6/6.01
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Pottential Problem
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've been receiving messages in my logs regarding a reiserfs partition I 
have on my system.  At first, I thought that one of my drives was going 
bad, so I really didn't pay it much attention.  Now that I look closer, 
however, I notice this:

Feb 26 00:02:39 JTLinux kernel: hdb: drive not ready for command
Feb 26 00:02:52 JTLinux kernel: hdb: lost interrupt
Feb 26 00:02:53 JTLinux kernel: hdb: status error: status=0x58 { 
DriveReady SeekComplete DataRequest }
Feb 26 00:02:53 JTLinux kernel: hdb: drive not ready for command
Feb 26 00:02:54 JTLinux kernel: attempt to access beyond end of device
Feb 26 00:02:54 JTLinux kernel: 03:41: rw=0, want=584642676, limit=8255488
Feb 26 00:02:54 JTLinux kernel: attempt to access beyond end of device
Feb 26 00:03:05 JTLinux kernel: 03:41: rw=0, want=596901940, limit=8255488
Feb 26 00:03:05 JTLinux kernel: attempt to access beyond end of device
Feb 26 00:03:05 JTLinux kernel: 03:41: rw=0, want=584642676, limit=8255488
. . . These messages are repeated a whole lot . . 
^^^^^^^^^^^^^^^^^^^^^^^^^^^
Feb 26 00:06:07 JTLinux kernel: hdb: lost interrupt
Feb 26 00:06:08 JTLinux kernel: is_tree_node: node level 30742 does not 
match to the expected one 1
Feb 26 00:06:08 JTLinux kernel: vs-5150: search_by_key: invalid format 
found in block 8899. Fsck?
Feb 26 00:06:08 JTLinux kernel: vs-13070: reiserfs_read_inode2: i/o 
failure occurred trying to find stat data of [10 168 0x0 SD]
Feb 26 00:06:08 JTLinux kernel: vs-13048: reiserfs_iget: bad_inode. Stat 
data of (10 168) not found
Feb 26 00:06:08 JTLinux last message repeated 5 times
Feb 26 00:06:08 JTLinux kernel: hdb: status error: status=0x58 { 
DriveReady SeekComplete DataRequest }
Feb 26 00:06:08 JTLinux kernel: hdb: drive not ready for command
Feb 26 00:06:08 JTLinux kernel: is_tree_node: node level 30742 does not 
match to the expected one 1
Feb 26 00:06:08 JTLinux kernel: vs-5150: search_by_key: invalid format 
found in block 8899. Fsck?
Feb 26 00:06:08 JTLinux kernel: vs-13070: reiserfs_read_inode2: i/o 
failure occurred trying to find stat data of [10 169 0x0 SD]
Feb 26 00:06:08 JTLinux kernel: vs-13048: reiserfs_iget: bad_inode. Stat 
data of (10 169) not found
Feb 26 00:06:08 JTLinux last message repeated 5 times
Feb 26 00:06:08 JTLinux kernel: is_tree_node: node level 30742 does not 
match to the expected one 1
Feb 26 00:06:08 JTLinux kernel: vs-5150: search_by_key: invalid format 
found in block 8899. Fsck?
Feb 26 00:06:09 JTLinux kernel: vs-13070: reiserfs_read_inode2: i/o 
failure occurred trying to find stat data of [10 170 0x0 SD]
Feb 26 00:06:09 JTLinux kernel: vs-13048: reiserfs_iget: bad_inode. Stat 
data of (10 170) not found
_________________

Now, the statement that says: want=596901940, limit=8255488 worries me.  
This is an 8.4gig Western Digital drive, so the number, 8255488 seems 
reasonable enough.  The number 596901940 seems totally unreasonable.  Do 
you think I am looking at a hardware problem, or do you think it could 
be kernel related?  I am using kernel 2.4.1 on a SuSE Linux 7.0 system.

Thanks in advance,
Justin

