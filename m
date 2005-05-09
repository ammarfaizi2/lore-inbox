Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261447AbVEIRZW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261447AbVEIRZW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 May 2005 13:25:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261450AbVEIRZW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 May 2005 13:25:22 -0400
Received: from rwcrmhc11.comcast.net ([204.127.198.35]:7822 "EHLO
	rwcrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S261447AbVEIRY7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 May 2005 13:24:59 -0400
Date: Mon, 9 May 2005 13:24:36 -0400
To: linux-kernel@vger.kernel.org
Subject: Two oops reports
Message-ID: <20050509172435.GA6826@dirac.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="8t9RHnE3ZwKMSgU+"
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
From: p@dirac.org (Peter Jay Salzman)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--8t9RHnE3ZwKMSgU+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi all,

For the past 24 hours, my system has been oopsing every so often.  The
problem is not reproducible on command, but it does seem to be inevitable
after a few hours.  I can't seem to get through a kernel compile without it
happening.

In the first oops attachment, the Enlightenment WM was doing something when
the oops happened.

In the second oops attachment, I had rebooted and used WindowMaker instead
of Enlightenment just to make sure there wasn't something about
Enlightenment that was causing the problem.  I downloaded 2.6.11 and was in
the process of making a new kernel when the oops happened.  I believe that
the bash invocation for the make caused the oops.

I never had this problem before.  It appears to have started after a Debian
update (I use Debian/testing), but perhaps the update just coincided with
hardware failure.  The system is an aging dual Celeron PII/333.

I've never sent in an oops report before.  From oops-tracing.txt, man
ksymoops and the ksymoops output, I need /proc/ksyms, but it appears that
file has disappeared from the kernel.  However, judging by the actual text
of the oops report, it appears that the object translation was performed
automatically.  I'm seeing things that look like function names, so perhaps
the man page, oops-tracing.txt, and ksymoops output are all out of date?

Pete

-- 
Every theory is killed sooner or later, but if the theory has good in it,
that good is embodied and continued in the next theory. -- Albert Einstein

GPG Fingerprint: B9F1 6CF3 47C4 7CD8 D33E  70A9 A3B9 1945 67EA 951D

--8t9RHnE3ZwKMSgU+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="oops-1.txt"

May  8 04:01:21 satan kernel: ------------[ cut here ]------------
May  8 04:01:21 satan kernel: PREEMPT SMP 
May  8 04:01:21 satan kernel: Modules linked in: ide_cd
May  8 04:01:21 satan kernel: CPU:    1
May  8 04:01:21 satan kernel: EIP:    0060:[do_get_write_access+224/1760]    Not tainted VLI
May  8 04:01:21 satan kernel: EFLAGS: 00010296   (2.6.10) 
May  8 04:01:21 satan kernel: EIP is at do_get_write_access+0xe0/0x6e0
May  8 04:01:21 satan kernel: eax: 000000a8   ebx: e63d1d1c   ecx: c0481490   edx: 00000286
May  8 04:01:21 satan kernel: esi: 00000000   edi: 00000000   ebp: de03eb0c   esp: de933d04
May  8 04:01:21 satan kernel: ds: 007b   es: 007b   ss: 0068
May  8 04:01:21 satan kernel: Process enlightenment (pid: 11094, threadinfo=de932000 task=e20b3060)
May  8 04:01:21 satan kernel: Stack: c042ce60 c0404117 c04214e6 0000023d c042f740 00000000 00000000 043fb354 
May  8 04:01:21 satan kernel:        e7da6c00 e211d460 c01d2ce8 e211d498 e211d498 00001000 00000012 e7da5580 
May  8 04:01:21 satan kernel:        00000012 c01565bb e7da5580 00000012 00001000 00000000 ce65918c 00000001 
May  8 04:01:21 satan kernel: Call Trace:
May  8 04:01:21 satan kernel:  [__jbd_kmalloc+40/48] __jbd_kmalloc+0x28/0x30
May  8 04:01:21 satan kernel:  [__getblk+43/96] __getblk+0x2b/0x60
May  8 04:01:21 satan kernel:  [ext3_get_inode_loc+90/608] ext3_get_inode_loc+0x5a/0x260
May  8 04:01:21 satan kernel:  [journal_get_write_access+55/80] journal_get_write_access+0x37/0x50
May  8 04:01:21 satan kernel:  [ext3_reserve_inode_write+85/208] ext3_reserve_inode_write+0x55/0xd0
May  8 04:01:21 satan kernel:  [ext3_mark_iloc_dirty+41/64] ext3_mark_iloc_dirty+0x29/0x40
May  8 04:01:21 satan kernel:  [ext3_mark_inode_dirty+43/96] ext3_mark_inode_dirty+0x2b/0x60
May  8 04:01:21 satan kernel:  [ext3_dirty_inode+141/144] ext3_dirty_inode+0x8d/0x90
May  8 04:01:21 satan kernel:  [ext3_dirty_inode+0/144] ext3_dirty_inode+0x0/0x90
May  8 04:01:21 satan kernel:  [__mark_inode_dirty+474/480] __mark_inode_dirty+0x1da/0x1e0
May  8 04:01:21 satan kernel:  [__d_lookup+294/336] __d_lookup+0x126/0x150
May  8 04:01:21 satan kernel:  [update_atime+217/224] update_atime+0xd9/0xe0
May  8 04:01:21 satan kernel:  [link_path_walk+1897/3360] link_path_walk+0x769/0xd20
May  8 04:01:21 satan kernel:  [path_lookup+145/352] path_lookup+0x91/0x160
May  8 04:01:21 satan kernel:  [__user_walk+51/96] __user_walk+0x33/0x60
May  8 04:01:21 satan kernel:  [vfs_stat+31/96] vfs_stat+0x1f/0x60
May  8 04:01:21 satan kernel:  [__pollwait+0/208] __pollwait+0x0/0xd0
May  8 04:01:21 satan kernel:  [sys_stat64+27/64] sys_stat64+0x1b/0x40
May  8 04:01:21 satan kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
May  8 04:01:21 satan kernel: Code: 42 c0 b8 e6 14 42 c0 b9 40 f7 42 c0 89 44 24 08 ba 3d 02 00 00 b8 17 41 40 c0 89 4c 24 10 89 54 24 0c 89 44 24 04 e8 e0 e2 f4 ff <0f> 0b 3d 02 e6 14 42 c0 8b 43 18 85 c0 74 3e 3b 44 24 24 74 38 
May  8 04:01:21 satan kernel:  <6>note: enlightenment[11094] exited with preempt_count 1
May  8 04:01:21 satan kernel:  [schedule+1714/1728] schedule+0x6b2/0x6c0
May  8 04:01:21 satan kernel:  [free_pages_and_swap_cache+113/160] free_pages_and_swap_cache+0x71/0xa0
May  8 04:01:21 satan kernel:  [unmap_vmas+469/544] unmap_vmas+0x1d5/0x220
May  8 04:01:21 satan kernel:  [exit_mmap+159/400] exit_mmap+0x9f/0x190
May  8 04:01:21 satan kernel:  [mmput+56/160] mmput+0x38/0xa0
May  8 04:01:21 satan kernel:  [do_exit+397/1136] do_exit+0x18d/0x470
May  8 04:01:21 satan kernel:  [die+399/400] die+0x18f/0x190
May  8 04:01:21 satan kernel:  [do_invalid_op+0/208] do_invalid_op+0x0/0xd0
May  8 04:01:21 satan kernel:  [do_invalid_op+178/208] do_invalid_op+0xb2/0xd0
May  8 04:01:21 satan kernel:  [do_get_write_access+224/1760] do_get_write_access+0xe0/0x6e0
May  8 04:01:21 satan kernel:  [__wake_up_common+65/112] __wake_up_common+0x41/0x70
May  8 04:01:21 satan kernel:  [__wake_up+62/96] __wake_up+0x3e/0x60
May  8 04:01:21 satan kernel:  [release_console_sem+179/192] release_console_sem+0xb3/0xc0
May  8 04:01:21 satan kernel:  [error_code+43/48] error_code+0x2b/0x30
May  8 04:01:21 satan kernel:  [do_get_write_access+224/1760] do_get_write_access+0xe0/0x6e0
May  8 04:01:21 satan kernel:  [__jbd_kmalloc+40/48] __jbd_kmalloc+0x28/0x30
May  8 04:01:21 satan kernel:  [__getblk+43/96] __getblk+0x2b/0x60
May  8 04:01:21 satan kernel:  [ext3_get_inode_loc+90/608] ext3_get_inode_loc+0x5a/0x260
May  8 04:01:21 satan kernel:  [journal_get_write_access+55/80] journal_get_write_access+0x37/0x50
May  8 04:01:21 satan kernel:  [ext3_reserve_inode_write+85/208] ext3_reserve_inode_write+0x55/0xd0
May  8 04:01:21 satan kernel:  [ext3_mark_iloc_dirty+41/64] ext3_mark_iloc_dirty+0x29/0x40
May  8 04:01:21 satan kernel:  [ext3_mark_inode_dirty+43/96] ext3_mark_inode_dirty+0x2b/0x60
May  8 04:01:21 satan kernel:  [ext3_dirty_inode+141/144] ext3_dirty_inode+0x8d/0x90
May  8 04:01:21 satan kernel:  [ext3_dirty_inode+0/144] ext3_dirty_inode+0x0/0x90
May  8 04:01:21 satan kernel:  [__mark_inode_dirty+474/480] __mark_inode_dirty+0x1da/0x1e0
May  8 04:01:21 satan kernel:  [__d_lookup+294/336] __d_lookup+0x126/0x150
May  8 04:01:21 satan kernel:  [update_atime+217/224] update_atime+0xd9/0xe0
May  8 04:01:21 satan kernel:  [link_path_walk+1897/3360] link_path_walk+0x769/0xd20
May  8 04:01:21 satan kernel:  [path_lookup+145/352] path_lookup+0x91/0x160
May  8 04:01:21 satan kernel:  [__user_walk+51/96] __user_walk+0x33/0x60
May  8 04:01:21 satan kernel:  [vfs_stat+31/96] vfs_stat+0x1f/0x60
May  8 04:01:21 satan kernel:  [__pollwait+0/208] __pollwait+0x0/0xd0
May  8 04:01:21 satan kernel:  [sys_stat64+27/64] sys_stat64+0x1b/0x40
May  8 04:01:21 satan kernel:  [syscall_call+7/11] syscall_call+0x7/0xb

--8t9RHnE3ZwKMSgU+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="oops-2.txt"

May  9 11:24:09 satan kernel: ------------[ cut here ]------------
May  9 11:24:09 satan kernel: PREEMPT SMP 
May  9 11:24:09 satan kernel: Modules linked in: ide_cd
May  9 11:24:09 satan kernel: CPU:    1
May  9 11:24:09 satan kernel: EIP:    0060:[exit_mmap+381/400]    Not tainted VLI
May  9 11:24:09 satan kernel: EFLAGS: 00010282   (2.6.10) 
May  9 11:24:09 satan kernel: EIP is at exit_mmap+0x17d/0x190
May  9 11:24:09 satan kernel: eax: 00000000   ebx: 00000000   ecx: fed2351c   edx: c1515c60
May  9 11:24:09 satan kernel: esi: ffffffff   edi: e7428040   ebp: e742807c   esp: e6201e00
May  9 11:24:09 satan kernel: ds: 007b   es: 007b   ss: 0068
May  9 11:24:09 satan kernel: Process sh (pid: 10839, threadinfo=e6200000 task=c591b580)
May  9 11:24:09 satan kernel: Stack: fc769efb e7428040 dfcc7858 00000000 ffffffff e6201e20 00000000 c1513400 
May  9 11:24:09 satan kernel:        03896105 e7428040 e7428080 e7428040 e6fbb280 c0116e68 e7428040 e7428040 
May  9 11:24:09 satan kernel:        00faef60 c015e698 e7428040 e7428040 c591ba48 e7428040 00000000 e6200000 
May  9 11:24:09 satan kernel: Call Trace:
May  9 11:24:09 satan kernel:  [mmput+56/160] mmput+0x38/0xa0
May  9 11:24:09 satan kernel:  [exec_mmap+200/416] exec_mmap+0xc8/0x1a0
May  9 11:24:09 satan kernel:  [flush_old_exec+250/1920] flush_old_exec+0xfa/0x780
May  9 11:24:09 satan kernel:  [vfs_read+210/304] vfs_read+0xd2/0x130
May  9 11:24:09 satan kernel:  [kernel_read+78/96] kernel_read+0x4e/0x60
May  9 11:24:09 satan kernel:  [load_elf_binary+749/3088] load_elf_binary+0x2ed/0xc10
May  9 11:24:09 satan kernel:  [__alloc_pages+468/880] __alloc_pages+0x1d4/0x370
May  9 11:24:09 satan kernel:  [copy_strings+392/512] copy_strings+0x188/0x200
May  9 11:24:09 satan kernel:  [load_elf_binary+0/3088] load_elf_binary+0x0/0xc10
May  9 11:24:09 satan kernel:  [search_binary_handler+366/688] search_binary_handler+0x16e/0x2b0
May  9 11:24:09 satan kernel:  [do_execve+391/528] do_execve+0x187/0x210
May  9 11:24:09 satan kernel:  [sys_execve+70/160] sys_execve+0x46/0xa0
May  9 11:24:09 satan kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
May  9 11:24:09 satan kernel: Code: 89 04 24 e8 f6 5d fc ff 8b 43 04 83 f8 ff 74 91 89 44 24 04 8d 43 14 89 04 24 e8 8f 39 00 00 c7 43 04 00 00 00 00 e9 76 ff ff ff <0f> 0b 36 07 d6 eb 41 c0 e9 31 ff ff ff 8d b6 00 00 00 00 56 53 
May  9 11:24:09 satan kernel:  <6>note: sh[10839] exited with preempt_count 1

--8t9RHnE3ZwKMSgU+--
