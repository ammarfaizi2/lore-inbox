Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261823AbTDHO5j (for <rfc822;willy@w.ods.org>); Tue, 8 Apr 2003 10:57:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261824AbTDHO5j (for <rfc822;linux-kernel-outgoing>); Tue, 8 Apr 2003 10:57:39 -0400
Received: from mailrelay2.lanl.gov ([128.165.4.103]:12497 "EHLO
	mailrelay2.lanl.gov") by vger.kernel.org with ESMTP id S261823AbTDHO5i (for <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Apr 2003 10:57:38 -0400
Subject: 2.5.67 buffer layer error at fs/buffer.c:127
From: Steven Cole <elenstev@mesatop.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Organization: 
Message-Id: <1049814538.32665.1115.camel@spc9.esa.lanl.gov>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2-3mdk 
Date: 08 Apr 2003 09:08:58 -0600
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Get this on booting 2.5.67.
This is always logged as the last message to
/var/log/messages on bootup.
 
System is PIII, UP. Kernel PREEMPT. 

>From dmesg:

buffer layer error at fs/buffer.c:127
Call Trace:
 [<c0148170>] __wait_on_buffer+0xe0/0xf0
 [<c0117010>] autoremove_wake_function+0x0/0x50
 [<c0117010>] autoremove_wake_function+0x0/0x50
 [<c014a0dd>] __block_prepare_write+0x13d/0x490
 [<c01821b0>] ext3_mark_inode_dirty+0x50/0x60
 [<c018d1ba>] start_this_handle+0x9a/0x1c0
 [<c014acc4>] block_prepare_write+0x34/0x50
 [<c017f2b0>] ext3_get_block+0x0/0xb0
 [<c017f962>] ext3_prepare_write+0x92/0x1b0
 [<c017f2b0>] ext3_get_block+0x0/0xb0
 [<c012e4d9>] generic_file_aio_write_nolock+0x359/0xa10
 [<c01496bc>] __find_get_block+0x7c/0x120
 [<c01815f3>] ext3_get_inode_loc+0xf3/0x1a0
 [<c0181908>] ext3_read_inode+0x1f8/0x360
 [<c012eca1>] generic_file_aio_write+0x71/0x90
 [<c017cf14>] ext3_file_write+0x44/0xe0
 [<c0146deb>] do_sync_write+0x8b/0xc0
 [<c0154108>] link_path_walk+0x608/0x900
 [<c018c85f>] ext3_permission+0x1f/0x30
 [<c015359a>] permission+0x3a/0x40
 [<c0147b15>] get_empty_filp+0x75/0xf0
 [<c0154d1d>] open_namei+0x9d/0x420
 [<c01460de>] dentry_open+0x16e/0x180
 [<c0145f68>] filp_open+0x68/0x70
 [<c0146ede>] vfs_write+0xbe/0x130
 [<c0146720>] generic_file_llseek+0x0/0xd0
 [<c0146fee>] sys_write+0x3e/0x60
 [<c01092bb>] syscall_call+0x7/0xb



