Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262469AbTIPVkr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Sep 2003 17:40:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262474AbTIPVkr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Sep 2003 17:40:47 -0400
Received: from adsl-63-194-239-202.dsl.lsan03.pacbell.net ([63.194.239.202]:13833
	"EHLO mmp-linux.matchmail.com") by vger.kernel.org with ESMTP
	id S262469AbTIPVko (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Sep 2003 17:40:44 -0400
Date: Tue, 16 Sep 2003 14:41:05 -0700
From: Mike Fedyk <mfedyk@matchmail.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: OOps in HFS was: 2.6.0-test4-mm3
Message-ID: <20030916214105.GA3490@matchmail.com>
Mail-Followup-To: Andrew Morton <akpm@osdl.org>,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <20030828235649.61074690.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030828235649.61074690.akpm@osdl.org>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Just reading a hfs floppy...

Sep 15 10:10:49 mis-mike-wstn kernel: inserting floppy driver for 2.6.0-test4-mm3-1-mdfail
Sep 15 10:10:49 mis-mike-wstn kernel: Floppy drive(s): fd0 is 1.44M
Sep 15 10:10:49 mis-mike-wstn kernel: FDC 0 is a post-1991 82077
Sep 15 10:10:49 mis-mike-wstn kernel: PM: Adding info for platform:floppy0
Sep 15 10:11:14 mis-mike-wstn kernel: Debug: sleeping function called from invalid context at mm/slab.c:1833
Sep 15 10:11:14 mis-mike-wstn kernel: Call Trace:
Sep 15 10:11:14 mis-mike-wstn kernel:  [__might_sleep+99/104] __might_sleep+0x63/0x68
Sep 15 10:11:15 mis-mike-wstn kernel:  [kmem_cache_alloc+37/324] kmem_cache_alloc+0x25/0x144
Sep 15 10:11:15 mis-mike-wstn kernel:  [_end+340461616/1068932160] grow_entries+0x24/0xa0 [hfs]
Sep 15 10:11:15 mis-mike-wstn kernel:  [_end+340462938/1068932160] get_new_entry+0x1e/0x460 [hfs]
Sep 15 10:11:15 mis-mike-wstn kernel:  [_end+340463557/1068932160] get_new_entry+0x289/0x460 [hfs]
Sep 15 10:11:15 mis-mike-wstn kernel:  [queue_work+256/268] queue_work+0x100/0x10c
Sep 15 10:11:15 mis-mike-wstn kernel:  [recalc_task_prio+377/392] recalc_task_prio+0x179/0x188
Sep 15 10:11:15 mis-mike-wstn kernel:  [schedule+1404/1760] schedule+0x57c/0x6e0
Sep 15 10:11:15 mis-mike-wstn kernel:  [__wait_on_buffer_wq+212/224] __wait_on_buffer_wq+0xd4/0xe0
Sep 15 10:11:15 mis-mike-wstn kernel:  [autoremove_wake_function+0/64] autoremove_wake_function+0x0/0x40
Sep 15 10:11:15 mis-mike-wstn kernel:  [_end+340462806/1068932160] find_entry+0x1a/0x80 [hfs]
Sep 15 10:11:15 mis-mike-wstn kernel:  [_end+340464113/1068932160] get_entry+0x55/0xc0 [hfs]
Sep 15 10:11:15 mis-mike-wstn kernel:  [_end+340465538/1068932160] hfs_cat_get+0x12/0x18 [hfs]
Sep 15 10:11:15 mis-mike-wstn kernel:  [_end+340506273/1068932160] hfs_fill_super+0x13d/0x1c7 [hfs]
Sep 15 10:11:15 mis-mike-wstn kernel:  [disk_name+36/116] disk_name+0x24/0x74
Sep 15 10:11:15 mis-mike-wstn kernel:  [get_sb_bdev+232/308] get_sb_bdev+0xe8/0x134
Sep 15 10:11:15 mis-mike-wstn kernel:  [_end+340503342/1068932160] hfs_get_sb+0x1e/0x28 [hfs]
Sep 15 10:11:15 mis-mike-wstn kernel:  [_end+340505956/1068932160] hfs_fill_super+0x0/0x1c7 [hfs]
Sep 15 10:11:15 mis-mike-wstn kernel:  [do_kern_mount+87/252] do_kern_mount+0x57/0xfc
Sep 15 10:11:15 mis-mike-wstn kernel:  [do_add_mount+90/332] do_add_mount+0x5a/0x14c
Sep 15 10:11:15 mis-mike-wstn kernel:  [do_mount+329/352] do_mount+0x149/0x160
Sep 15 10:11:15 mis-mike-wstn kernel:  [copy_mount_options+144/264] copy_mount_options+0x90/0x108
Sep 15 10:11:15 mis-mike-wstn kernel:  [sys_mount+193/360] sys_mount+0xc1/0x168
Sep 15 10:11:15 mis-mike-wstn kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
Sep 15 10:11:15 mis-mike-wstn kernel: 
Sep 15 10:11:48 mis-mike-wstn kernel: Debug: sleeping function called from invalid context at mm/slab.c:1833
Sep 15 10:11:48 mis-mike-wstn kernel: Call Trace:
Sep 15 10:11:48 mis-mike-wstn kernel:  [__might_sleep+99/104] __might_sleep+0x63/0x68
Sep 15 10:11:48 mis-mike-wstn kernel:  [kmem_cache_alloc+37/324] kmem_cache_alloc+0x25/0x144
Sep 15 10:11:48 mis-mike-wstn kernel:  [__find_get_block+185/200] __find_get_block+0xb9/0xc8
Sep 15 10:11:48 mis-mike-wstn kernel:  [_end+340461616/1068932160] grow_entries+0x24/0xa0 [hfs]
Sep 15 10:11:48 mis-mike-wstn kernel:  [_end+340462938/1068932160] get_new_entry+0x1e/0x460 [hfs]
Sep 15 10:11:48 mis-mike-wstn kernel:  [_end+340463557/1068932160] get_new_entry+0x289/0x460 [hfs]
Sep 15 10:11:48 mis-mike-wstn kernel:  [__wake_up+93/176] __wake_up+0x5d/0xb0
Sep 15 10:11:48 mis-mike-wstn kernel:  [_end+340458195/1068932160] hfs_bnode_read+0x20b/0x218 [hfs]
Sep 15 10:11:48 mis-mike-wstn kernel:  [_end+340458960/1068932160] hfs_bnode_find+0xe4/0x114 [hfs]
Sep 15 10:11:48 mis-mike-wstn kernel:  [kfree+615/696] kfree+0x267/0x2b8
Sep 15 10:11:48 mis-mike-wstn kernel:  [_end+340462806/1068932160] find_entry+0x1a/0x80 [hfs]
Sep 15 10:11:48 mis-mike-wstn kernel:  [_end+340464113/1068932160] get_entry+0x55/0xc0 [hfs]
Sep 15 10:11:48 mis-mike-wstn kernel:  [_end+340465538/1068932160] hfs_cat_get+0x12/0x18 [hfs]
Sep 15 10:11:48 mis-mike-wstn kernel:  [_end+340474963/1068932160] cap_lookup+0x153/0x20c [hfs]
Sep 15 10:11:48 mis-mike-wstn kernel:  [real_lookup+108/220] real_lookup+0x6c/0xdc
Sep 15 10:11:48 mis-mike-wstn kernel:  [do_lookup+71/132] do_lookup+0x47/0x84
Sep 15 10:11:48 mis-mike-wstn kernel:  [link_path_walk+1927/2684] link_path_walk+0x787/0xa7c
Sep 15 10:11:48 mis-mike-wstn kernel:  [path_lookup+449/460] path_lookup+0x1c1/0x1cc
Sep 15 10:11:48 mis-mike-wstn kernel:  [__user_walk+47/76] __user_walk+0x2f/0x4c
Sep 15 10:11:48 mis-mike-wstn kernel:  [vfs_lstat+23/68] vfs_lstat+0x17/0x44
Sep 15 10:11:48 mis-mike-wstn kernel:  [sys_lstat64+20/44] sys_lstat64+0x14/0x2c
Sep 15 10:11:48 mis-mike-wstn kernel:  [filldir64+0/308] filldir64+0x0/0x134
Sep 15 10:11:48 mis-mike-wstn kernel:  [sys_getdents64+97/166] sys_getdents64+0x61/0xa6
Sep 15 10:11:48 mis-mike-wstn kernel:  [sys_getdents64+154/166] sys_getdents64+0x9a/0xa6
Sep 15 10:11:48 mis-mike-wstn kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
Sep 15 10:11:48 mis-mike-wstn kernel: 
Sep 15 10:21:11 mis-mike-wstn kernel: hfs_cat_put: trying to free free entry: c261451c
Sep 15 10:21:11 mis-mike-wstn kernel: hfs_cat_put: trying to free free entry: cc08f104
Sep 15 10:21:11 mis-mike-wstn kernel: hfs_cat_put: trying to free free entry: c7997ccc
Sep 15 10:21:11 mis-mike-wstn kernel: hfs_cat_put: trying to free free entry: c6cb9728
Sep 15 10:21:11 mis-mike-wstn kernel: hfs_cat_put: trying to free free entry: d21deac0
Sep 15 10:21:11 mis-mike-wstn kernel: hfs_cat_put: trying to free free entry: d2a1b310
Sep 15 10:21:11 mis-mike-wstn kernel: hfs_cat_put: trying to free free entry: c8a226a8
Sep 15 10:21:11 mis-mike-wstn kernel: hfs_cat_put: trying to free free entry: c8592084
Sep 15 10:21:11 mis-mike-wstn kernel: hfs_cat_put: trying to free free entry: c3aaa290
Sep 15 10:21:11 mis-mike-wstn kernel: hfs_cat_put: trying to free free entry: c50bcccc
Sep 15 10:21:11 mis-mike-wstn kernel: hfs_cat_put: trying to free free entry: d29e3b40
Sep 15 10:21:11 mis-mike-wstn kernel: hfs_cat_put: trying to free free entry: cc08f934
Sep 15 10:35:34 mis-mike-wstn kernel: hfs_cat_put: trying to free free entry: c6cb9934
Sep 15 10:35:34 mis-mike-wstn kernel: hfs_cat_put: trying to free free entry: d2a1b728
Sep 15 10:35:34 mis-mike-wstn kernel: hfs_cat_put: trying to free free entry: c1cbf51c
Sep 15 10:46:04 mis-mike-wstn kernel: hfs_cat_put: trying to free free entry: c85926a8
Sep 15 17:02:56 mis-mike-wstn kernel: hfs_cat_put: trying to free free entry: c2686728
Sep 15 20:04:48 mis-mike-wstn kernel: hfs_cat_put: trying to free free entry: c7997ccc
Sep 15 20:04:48 mis-mike-wstn kernel: hfs_cat_put: trying to free free entry: c6cb9728
Sep 15 20:04:48 mis-mike-wstn kernel: hfs_cat_put: trying to free free entry: d21deac0
Sep 15 20:04:48 mis-mike-wstn kernel: hfs_cat_put: trying to free free entry: d2a1b310
Sep 15 20:04:48 mis-mike-wstn kernel: hfs_cat_put: trying to free free entry: c8a226a8
Sep 15 20:04:48 mis-mike-wstn kernel: hfs_cat_put: trying to free free entry: c261451c
Sep 15 20:04:48 mis-mike-wstn kernel: hfs_cat_put: trying to free free entry: cc08f104
Sep 15 20:04:48 mis-mike-wstn kernel: hfs_cat_put: trying to free free entry: c85926a8
Sep 15 20:04:48 mis-mike-wstn kernel: hfs_cat_put: trying to free free entry: c6cb9934
Sep 15 20:04:48 mis-mike-wstn kernel: hfs_cat_put: trying to free free entry: c50bcccc
Sep 15 20:04:58 mis-mike-wstn kernel: hfs_cat_put: trying to free free entry: d29e3b40
Sep 15 20:04:58 mis-mike-wstn kernel: hfs_cat_put: trying to free free entry: c2686728
Sep 16 04:14:49 mis-mike-wstn kernel: nfs: server fs not responding, still trying
Sep 16 04:15:01 mis-mike-wstn kernel: nfs: server fs not responding, still trying
Sep 16 04:15:16 mis-mike-wstn kernel: nfs: server fs OK
Sep 16 04:15:16 mis-mike-wstn kernel: nfs: server fs OK
Sep 16 06:25:16 mis-mike-wstn kernel: hfs_cat_put: trying to free free entry: c3aaa290
Sep 16 06:25:16 mis-mike-wstn kernel: hfs_cat_put: trying to free free entry: c8592084
Sep 16 06:25:16 mis-mike-wstn kernel: hfs_cat_put: trying to free free entry: cc08f934
Sep 16 06:25:46 mis-mike-wstn kernel: hfs_cat_put: trying to free free entry: d2a1b728
