Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261159AbVBGPi7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261159AbVBGPi7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Feb 2005 10:38:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261157AbVBGPi7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Feb 2005 10:38:59 -0500
Received: from Mail.MNSU.EDU ([134.29.1.12]:4584 "EHLO mail.mnsu.edu")
	by vger.kernel.org with ESMTP id S261159AbVBGPif (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Feb 2005 10:38:35 -0500
Message-ID: <42078B74.2080306@mnsu.edu>
Date: Mon, 07 Feb 2005 09:38:28 -0600
From: "Jeffrey E. Hundstad" <jeffrey.hundstad@mnsu.edu>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8a6) Gecko/20050111
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org, linux-xfs@oss.sgi.com
Subject: linux-2.6.11-rc3: XFS internal error xfs_da_do_buf(1) at line 2176
 of file fs/xfs/xfs_da_btree.c.
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm sorry for this truncated report... but it's all I've got.  If you 
need .config or system configuration, etc. let me know and I'll send'em 
ASAP.  I don't believe this is hardware related; ide-smart shows all fine.

 From dmesg:

xfs_da_do_buf: bno 8388608
dir: inode 117526252
Filesystem "hda4": XFS internal error xfs_da_do_buf(1) at line 2176 of 
file fs/x
fs/xfs_da_btree.c.  Caller 0xc01bda27
 [<c01bd82c>] xfs_da_do_buf+0x65c/0x7b0
 [<c01bda27>] xfs_da_read_buf+0x47/0x60
 [<c0131d7d>] __alloc_pages+0x2ad/0x3d0
 [<c0135202>] cache_grow+0xe2/0x150
 [<c01bda27>] xfs_da_read_buf+0x47/0x60
 [<c01bbb9e>] xfs_da_node_lookup_int+0x7e/0x320
 [<c01bbb9e>] xfs_da_node_lookup_int+0x7e/0x320
 [<c01c74c6>] xfs_dir2_node_lookup+0x36/0xa0
 [<c01bf897>] xfs_dir2_lookup+0xf7/0x110
 [<c01d85d8>] xfs_ichgtime+0xf8/0xfa
 [<c01f1076>] xfs_readlink+0x96/0x2c0
 [<c01ed0d8>] xfs_dir_lookup_int+0x38/0x100
 [<c01d8392>] xfs_iaccess+0xc2/0x1c0
 [<c01f212d>] xfs_lookup+0x4d/0x90
 [<c01fd2be>] linvfs_lookup+0x4e/0x80
 [<c0155f5e>] real_lookup+0xae/0xd0
 [<c01561ae>] do_lookup+0x7e/0x90
 [<c01568e2>] link_path_walk+0x722/0xd50
 [<c015717b>] path_lookup+0x7b/0x130
 [<c015738f>] __user_walk+0x2f/0x60
 [<c015214d>] vfs_stat+0x1d/0x50
 [<c01527d2>] sys_stat64+0x12/0x30
 [<c01024ef>] syscall_call+0x7/0xb
xfs_da_do_buf: bno 8388608
dir: inode 117526252
Filesystem "hda4": XFS internal error xfs_da_do_buf(1) at line 2176 of 
file fs/x
fs/xfs_da_btree.c.  Caller 0xc01bda27
 [<c01bd82c>] xfs_da_do_buf+0x65c/0x7b0
 [<c01bda27>] xfs_da_read_buf+0x47/0x60
 [<c0131d7d>] __alloc_pages+0x2ad/0x3d0
 [<c0135202>] cache_grow+0xe2/0x150
 [<c01bda27>] xfs_da_read_buf+0x47/0x60
 [<c01bbb9e>] xfs_da_node_lookup_int+0x7e/0x320
 [<c01bbb9e>] xfs_da_node_lookup_int+0x7e/0x320
 [<c01c74c6>] xfs_dir2_node_lookup+0x36/0xa0
 [<c01bf897>] xfs_dir2_lookup+0xf7/0x110
 [<c01d85d8>] xfs_ichgtime+0xf8/0xfa
 [<c01f1076>] xfs_readlink+0x96/0x2c0
 [<c01ed0d8>] xfs_dir_lookup_int+0x38/0x100
 [<c01d8392>] xfs_iaccess+0xc2/0x1c0
 [<c01f212d>] xfs_lookup+0x4d/0x90
 [<c01fd2be>] linvfs_lookup+0x4e/0x80
 [<c0155f5e>] real_lookup+0xae/0xd0
 [<c01561ae>] do_lookup+0x7e/0x90
 [<c01568e2>] link_path_walk+0x722/0xd50
 [<c015717b>] path_lookup+0x7b/0x130
 [<c015738f>] __user_walk+0x2f/0x60
 [<c015214d>] vfs_stat+0x1d/0x50
 [<c01527d2>] sys_stat64+0x12/0x30
 [<c01024ef>] syscall_call+0x7/0xb

 From syslog:

[xfs_da_do_buf+1628/1968] xfs_da_do_buf+0x65c/0x7b0
[xfs_da_read_buf+71/96] xfs_da_read_buf+0x47/0x60
[__alloc_pages+685/976] __alloc_pages+0x2ad/0x3d0
[cache_grow+226/336] cache_grow+0xe2/0x150
[xfs_da_read_buf+71/96] xfs_da_read_buf+0x47/0x60
[xfs_da_node_lookup_int+126/800] xfs_da_node_lookup_int+0x7e/0x320
[xfs_da_node_lookup_int+126/800] xfs_da_node_lookup_int+0x7e/0x320
[xfs_dir2_node_lookup+54/160] xfs_dir2_node_lookup+0x36/0xa0
[xfs_dir2_lookup+247/272] xfs_dir2_lookup+0xf7/0x110
[xfs_ichgtime+248/250] xfs_ichgtime+0xf8/0xfa
[xfs_readlink+150/704] xfs_readlink+0x96/0x2c0
[xfs_dir_lookup_int+56/256] xfs_dir_lookup_int+0x38/0x100
[xfs_iaccess+194/448] xfs_iaccess+0xc2/0x1c0
[xfs_lookup+77/144] xfs_lookup+0x4d/0x90
[linvfs_lookup+78/128] linvfs_lookup+0x4e/0x80
[real_lookup+174/208] real_lookup+0xae/0xd0
[do_lookup+126/144] do_lookup+0x7e/0x90
[link_path_walk+1826/3408] link_path_walk+0x722/0xd50
[path_lookup+123/304] path_lookup+0x7b/0x130
[__user_walk+47/96] __user_walk+0x2f/0x60
[vfs_stat+29/80] vfs_stat+0x1d/0x50
[sys_stat64+18/48] sys_stat64+0x12/0x30
[syscall_call+7/11] syscall_call+0x7/0xb
[xfs_da_do_buf+1628/1968] xfs_da_do_buf+0x65c/0x7b0
[xfs_da_read_buf+71/96] xfs_da_read_buf+0x47/0x60
[__alloc_pages+685/976] __alloc_pages+0x2ad/0x3d0
[cache_grow+226/336] cache_grow+0xe2/0x150
[xfs_da_read_buf+71/96] xfs_da_read_buf+0x47/0x60
[xfs_da_node_lookup_int+126/800] xfs_da_node_lookup_int+0x7e/0x320
[xfs_da_node_lookup_int+126/800] xfs_da_node_lookup_int+0x7e/0x320
[xfs_dir2_node_lookup+54/160] xfs_dir2_node_lookup+0x36/0xa0
[xfs_dir2_lookup+247/272] xfs_dir2_lookup+0xf7/0x110
[xfs_ichgtime+248/250] xfs_ichgtime+0xf8/0xfa
[xfs_readlink+150/704] xfs_readlink+0x96/0x2c0
[xfs_dir_lookup_int+56/256] xfs_dir_lookup_int+0x38/0x100
[xfs_iaccess+194/448] xfs_iaccess+0xc2/0x1c0
[xfs_lookup+77/144] xfs_lookup+0x4d/0x90
[linvfs_lookup+78/128] linvfs_lookup+0x4e/0x80
[real_lookup+174/208] real_lookup+0xae/0xd0
[do_lookup+126/144] do_lookup+0x7e/0x90
[link_path_walk+1826/3408] link_path_walk+0x722/0xd50
[path_lookup+123/304] path_lookup+0x7b/0x130
[__user_walk+47/96] __user_walk+0x2f/0x60
[vfs_stat+29/80] vfs_stat+0x1d/0x50
[sys_stat64+18/48] sys_stat64+0x12/0x30
[syscall_call+7/11] syscall_call+0x7/0xb


-- 
jeffrey hundstad
