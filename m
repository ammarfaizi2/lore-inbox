Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266700AbUBGJ3u (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Feb 2004 04:29:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266702AbUBGJ3u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Feb 2004 04:29:50 -0500
Received: from postfix3-1.free.fr ([213.228.0.44]:19092 "EHLO
	postfix3-1.free.fr") by vger.kernel.org with ESMTP id S266700AbUBGJ3r
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Feb 2004 04:29:47 -0500
Message-ID: <4024B074.4070704@free.fr>
Date: Sat, 07 Feb 2004 10:31:32 +0100
From: Johann Lombardi <johann.lombardi@free.fr>
Reply-To: johann.lombardi@free.fr
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20031107 Debian/1.5-3
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: 2.6.2-mm1+XFS
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Folks,

I've just upgraded my kernel from 2.6.1 to 2.6.2-mm1 and I have a call 
trace related to XFS in my logs.
Here is the message:

XFS mounting filesystem hde5
i_size_write() called without i_sem
Call Trace:
[<c013e4db>] i_size_write_check+0x5b/0x60
[<c0228a6e>] xfs_initialize_vnode+0xce/0x300
[<c0229e0c>] vfs_init_vnode+0x3c/0x40
[<c01f7111>] xfs_iget_core+0x331/0x570
[<c01f7469>] xfs_iget+0x119/0x150
[<c020d31d>] xfs_mountfs+0x7ed/0xfd0
[<c0228ed0>] xfs_setsize_buftarg+0x40/0x80
[<c020c868>] xfs_readsb+0x1c8/0x230
[<c01fe03e>] xfs_ioinit+0x1e/0x40
[<c021536f>] xfs_mount+0x33f/0x5e0
[<c0229b74>] vfs_mount+0x34/0x40
[<c022995b>] linvfs_fill_super+0x9b/0x220
[<c0236107>] snprintf+0x27/0x30
[<c018c8a2>] disk_name+0x62/0xb0
[<c015eef5>] sb_set_blocksize+0x25/0x60
[<c015e8d4>] get_sb_bdev+0x124/0x160
[<c0229b0f>] linvfs_get_sb+0x2f/0x60
[<c02298c0>] linvfs_fill_super+0x0/0x220
[<c015eb3f>] do_kern_mount+0x5f/0xe0
[<c0174988>] do_add_mount+0x78/0x150
[<c0174c94>] do_mount+0x144/0x190
[<c0174ae0>] copy_mount_options+0x80/0xf0
[<c017507f>] sys_mount+0xbf/0x140
[<c0378a83>] syscall_call+0x7/0xb
Ending clean XFS mount for filesystem: hde5


And several times:

i_size_write() called without i_sem
Call Trace:
[<c013e4db>] i_size_write_check+0x5b/0x60
[<c0228a6e>] xfs_initialize_vnode+0xce/0x300
[<c0229e0c>] vfs_init_vnode+0x3c/0x40
[<c01f7111>] xfs_iget_core+0x331/0x570
[<c01f7469>] xfs_iget+0x119/0x150
[<c02141a4>] xfs_dir_lookup_int+0xb4/0x130
[<c0219c50>] xfs_lookup+0x50/0x90
[<c0226947>] linvfs_lookup+0x67/0xa0
[<c016518b>] real_lookup+0xcb/0xf0
[<c0165416>] do_lookup+0x96/0xb0
[<c016590b>] link_path_walk+0x4db/0x960
[<c0166289>] __user_walk+0x49/0x60
[<c016113c>] vfs_lstat+0x1c/0x60
[<c016188b>] sys_lstat64+0x1b/0x40
[<c0378a83>] syscall_call+0x7/0xb


Howerver, the filesystem seems to be OK.
Is it something to worry about?

Johann

