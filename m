Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265560AbSKFDpd>; Tue, 5 Nov 2002 22:45:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265558AbSKFDpd>; Tue, 5 Nov 2002 22:45:33 -0500
Received: from 12-237-16-92.client.attbi.com ([12.237.16.92]:7296 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id <S265560AbSKFDpb>; Tue, 5 Nov 2002 22:45:31 -0500
Message-ID: <3DC891E2.3020006@attbi.com>
Date: Tue, 05 Nov 2002 21:52:02 -0600
From: Jordan Breeding <jordan.breeding@attbi.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20021003
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: buffer layer error at fs/buffer.c:1166
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

   I get these errors while using 2.5.46-bk:

VFS: brelse: Trying to free free buffer
buffer layer error at fs/buffer.c:1166
Pass this trace through ksymoops for reporting
Call Trace:
  [<c01585b6>] __brelse+0x36/0x40
  [<c01587d7>] bh_lru_install+0xc7/0x100
  [<c0158875>] __find_get_block+0x65/0x70
  [<c0158443>] __getblk_slow+0x23/0x110
  [<c01588db>] __getblk+0x5b/0x70
  [<c01943a8>] ext3_getblk+0xa8/0x300
  [<c0194633>] ext3_bread+0x33/0xb0
  [<c0197c5f>] dx_probe+0x4f/0x310
  [<c0194633>] ext3_bread+0x33/0xb0
  [<c01980fd>] ext3_htree_fill_tree+0x9d/0x1d0
  [<c0191572>] ext3_dx_readdir+0x92/0x1fa
  [<c019114c>] ext3_readdir+0x4bc/0x4f0
  [<c01685b0>] filldir64+0x0/0x110
  [<c013a8f6>] handle_mm_fault+0x86/0xc0
  [<c011c3cc>] do_page_fault+0x22c/0x45c
  [<c01682b2>] vfs_readdir+0xb2/0xc0
  [<c01685b0>] filldir64+0x0/0x110
  [<c016871b>] sys_getdents64+0x5b/0x140
  [<c01685b0>] filldir64+0x0/0x110
  [<c013b0a3>] sys_brk+0x103/0x130
  [<c010af93>] syscall_call+0x7/0xb

VFS: brelse: Trying to free free buffer
buffer layer error at fs/buffer.c:1166
Pass this trace through ksymoops for reporting
Call Trace:
  [<c01585b6>] __brelse+0x36/0x40
  [<c01587d7>] bh_lru_install+0xc7/0x100
  [<c0158875>] __find_get_block+0x65/0x70
  [<c0158443>] __getblk_slow+0x23/0x110
  [<c01588db>] __getblk+0x5b/0x70
  [<c015891f>] __bread+0x2f/0x80
  [<c0196523>] ext3_get_inode_loc+0xf3/0x190
  [<c016e941>] alloc_inode+0x181/0x1b0
  [<c01965de>] ext3_read_inode+0x1e/0x360
  [<c016f77e>] iget_locked+0x6e/0x70
  [<c0198bf2>] ext3_lookup+0xf2/0x100
  [<c0162ab6>] real_lookup+0xd6/0x110
  [<c0162d3d>] do_lookup+0x10d/0x170
  [<c01631a6>] link_path_walk+0x406/0x7c0
  [<c0163ab9>] __user_walk+0x49/0x60
  [<c015ebcf>] vfs_stat+0x1f/0x60
  [<c015f21b>] sys_stat64+0x1b/0x40
  [<c013046c>] sys_rt_sigprocmask+0x12c/0x1f0
  [<c010af93>] syscall_call+0x7/0xb

Thanks.

Jordan

