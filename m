Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267239AbTAKO52>; Sat, 11 Jan 2003 09:57:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267241AbTAKO52>; Sat, 11 Jan 2003 09:57:28 -0500
Received: from smtpzilla5.xs4all.nl ([194.109.127.141]:29196 "EHLO
	smtpzilla5.xs4all.nl") by vger.kernel.org with ESMTP
	id <S267239AbTAKO51>; Sat, 11 Jan 2003 09:57:27 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15904.13029.539865.117389@iris.hendrikweg.doorn>
Date: Sat, 11 Jan 2003 16:06:13 +0100
From: Kees Bakker <rnews@altium.nl>
To: linux-kernel@vger.kernel.org
Subject: 2.5.55 - buffer layer error at fs/buffer.c:1182
X-Mailer: VM 7.07 under Emacs 21.2.1
Reply-To: Kees Bakker <kees.bakker@xs4all.nl>
Organisation: The Tardis
X-Bill: Go away
X-Attribution: kb
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here is the call trace:
buffer layer error at fs/buffer.c:1182
Call Trace:
 [__buffer_error+41/48] fs_may_remount_ro+0x29/0x30
 [__brelse+41/48] mark_buffer_dirty+0x29/0x30
 [bh_lru_install+183/208] __bread_slow+0xb7/0xd0
 [__find_get_block+156/176] bh_lru_install+0x9c/0xb0
 [__getblk+29/64] __find_get_block+0x1d/0x40
 [__bread+25/64] __getblk+0x19/0x40
 [ext3_get_inode_loc+225/320] ext3_truncate+0xe1/0x140
 [ext3_read_inode+25/864] ext3_get_inode_loc+0x19/0x360
 [ext3_lookup+84/176] ext3_dx_find_entry+0x54/0xb0
 [ext3_lookup+111/176] ext3_dx_find_entry+0x6f/0xb0
 [real_lookup+80/192] cached_lookup+0x50/0xc0
 [do_lookup+156/464] follow_down+0x9c/0x1d0
 [ext3_follow_link+21/32] ext3_readlink+0x15/0x20
 [link_path_walk+1350/2112] do_lookup+0x546/0x840
 [path_lookup+228/240] set_fs_altroot+0xe4/0xf0
 [__user_walk+40/64] lookup_one_len+0x28/0x40
 [vfs_stat+25/80] vfs_getattr+0x19/0x50
 [sys_stat64+19/48] cp_new_stat64+0x13/0x30
 [sys_open+89/128] fd_install+0x59/0x80
 [syscall_call+7/11] system_call+0x7/0xb

Is this the same as the problem reported by Jordan Breeding?
 Message-ID: <3DC891E2.3020006@attbi.com>
 Date: Wed, 06 Nov 2002 05:00:13 +0100
 From: Jordan Breeding <jordan.breeding@attbi.com>

The suggested patch in the reply from Andrew was never applied, does that
mean the problem is still open?
-- 
============================================================
Kees Bakker
The Tardis
Doorn, The Netherlands                 kees.bakker@xs4all.nl
============================================================
A free society is one where it is safe to be unpopular
