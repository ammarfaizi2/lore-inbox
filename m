Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271324AbTHME46 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Aug 2003 00:56:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271357AbTHME46
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Aug 2003 00:56:58 -0400
Received: from smtpzilla3.xs4all.nl ([194.109.127.139]:21265 "EHLO
	smtpzilla3.xs4all.nl") by vger.kernel.org with ESMTP
	id S271324AbTHME44 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Aug 2003 00:56:56 -0400
Date: Wed, 13 Aug 2003 06:56:38 +0200
From: Jurriaan <thunder7@xs4all.nl>
To: linux-kernel@vger.kernel.org
Subject: 2.6.0-test3-mm1: scheduling while atomic (ext3?)
Message-ID: <20030813045638.GA9713@middle.of.nowhere>
Reply-To: thunder7@xs4all.nl
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Message-Flag: Still using Outlook? Please Upgrade to real software!
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Aug 13 06:47:48 middle -- MARK --
Aug 13 06:53:03 middle kernel:  printing eip:
Aug 13 06:53:03 middle kernel: c016c14a
Aug 13 06:53:03 middle kernel: Oops: 0000 [#1]
Aug 13 06:53:03 middle kernel: PREEMPT 
Aug 13 06:53:03 middle kernel: CPU:    0
Aug 13 06:53:03 middle kernel: EIP:    0060:[<c016c14a>]    Not tainted VLI
Aug 13 06:53:03 middle kernel: EFLAGS: 00010286
Aug 13 06:53:03 middle kernel: EIP is at find_inode_fast+0x1a/0x60
Aug 13 06:53:03 middle kernel: eax: f7b7e000   ebx: 000d5ff4   ecx: e68e9a48   edx: 00000000
Aug 13 06:53:03 middle kernel: esi: f7b7e000   edi: c1a50d80   ebp: f2f41e14   esp: f2f41e04
Aug 13 06:53:03 middle kernel: ds: 007b   es: 007b   ss: 0068
Aug 13 06:53:03 middle kernel: Process make (pid: 9500, threadinfo=f2f40000 task=eb0966a0)
Aug 13 06:53:03 middle kernel: Stack: f0c05cc0 f2f40000 f0271cc0 000d5ff4 f2f41e38 c016c7c0 f7b7e000 c1a50d80 
Aug 13 06:53:03 middle kernel:        000d5ff4 c1a50d80 000d5ff4 f0271cc0 f7b7e000 f2f41e58 c018fc92 f7b7e000 
Aug 13 06:53:03 middle kernel:        000d5ff4 c3600234 fffffff4 dddd2a74 dddd2a08 f2f41e7c c0160b10 dddd2a08 
Aug 13 06:53:03 middle kernel: Call Trace:
Aug 13 06:53:03 middle kernel:  [<c016c7c0>] iget_locked+0x50/0xc0
Aug 13 06:53:03 middle kernel:  [<c018fc92>] ext3_lookup+0x62/0xd0
Aug 13 06:53:03 middle kernel:  [<c0160b10>] real_lookup+0xc0/0xf0
Aug 13 06:53:03 middle kernel:  [<c0160d84>] do_lookup+0x84/0x90
Aug 13 06:53:03 middle kernel:  [<c0161211>] link_path_walk+0x481/0x870
Aug 13 06:53:03 middle kernel:  [<c0161abe>] __user_walk+0x3e/0x60
Aug 13 06:53:03 middle kernel:  [<c015cdce>] vfs_stat+0x1e/0x60
Aug 13 06:53:03 middle kernel:  [<c015d43b>] sys_stat64+0x1b/0x40
Aug 13 06:53:03 middle kernel:  [<c03ca78f>] syscall_call+0x7/0xb
Aug 13 06:53:03 middle kernel: 
Aug 13 06:53:03 middle kernel: Code: 75 ca eb c6 8d b6 00 00 00 00 8d bc 27 00 00 00 00 55 89 e5 57 56 53 83 ec 04 8b 5d 10 8b 7d 0c 8b 75 08 8b 0f 85 c9 74 13 8b 11 <0f> 18 02 90 39 59 18 89 c8 74 10 85 d2 89 d1 75 ed 31 c0 83 c4 
Aug 13 06:53:03 middle kernel:  <6>note: make[9500] exited with preempt_count 1
Aug 13 06:53:03 middle kernel: Call Trace:
Aug 13 06:53:03 middle kernel:  [<c011c29e>] schedule+0x58e/0x5a0
Aug 13 06:53:03 middle kernel:  [<c0143f31>] unmap_page_range+0x41/0x70
Aug 13 06:53:03 middle kernel:  [<c014411f>] unmap_vmas+0x1bf/0x220
Aug 13 06:53:03 middle kernel:  [<c0147e39>] exit_mmap+0x79/0x190
Aug 13 06:53:03 middle kernel:  [<c011dd9a>] mmput+0x7a/0xe0
Aug 13 06:53:03 middle kernel:  [<c0121a88>] do_exit+0x118/0x3f0
Aug 13 06:53:03 middle kernel:  [<c011a1e0>] do_page_fault+0x0/0x46b
Aug 13 06:53:03 middle kernel:  [<c010b6c9>] die+0xf9/0x100
Aug 13 06:53:03 middle kernel:  [<c011a30d>] do_page_fault+0x12d/0x46b
Aug 13 06:53:03 middle kernel:  [<c0155b38>] __getblk+0x28/0x50
Aug 13 06:53:03 middle kernel:  [<c018b8e2>] ext3_getblk+0x92/0x290
Aug 13 06:53:03 middle kernel:  [<c01542b1>] wake_up_buffer+0x11/0x30
Aug 13 06:53:03 middle kernel:  [<c01542fe>] unlock_buffer+0x2e/0x50
Aug 13 06:53:03 middle kernel:  [<c0157afd>] ll_rw_block+0x4d/0x80
Aug 13 06:53:03 middle kernel:  [<c018f957>] ext3_find_entry+0x307/0x3c0
Aug 13 06:53:03 middle kernel:  [<c011a1e0>] do_page_fault+0x0/0x46b
Aug 13 06:53:03 middle kernel:  [<c03cb19b>] error_code+0x2f/0x38
Aug 13 06:53:03 middle kernel:  [<c016c14a>] find_inode_fast+0x1a/0x60
Aug 13 06:53:03 middle kernel:  [<c016c7c0>] iget_locked+0x50/0xc0
Aug 13 06:53:03 middle kernel:  [<c018fc92>] ext3_lookup+0x62/0xd0
Aug 13 06:53:03 middle kernel:  [<c0160b10>] real_lookup+0xc0/0xf0
Aug 13 06:53:03 middle kernel:  [<c0160d84>] do_lookup+0x84/0x90
Aug 13 06:53:03 middle kernel:  [<c0161211>] link_path_walk+0x481/0x870
Aug 13 06:53:03 middle kernel:  [<c0161abe>] __user_walk+0x3e/0x60
Aug 13 06:53:03 middle kernel:  [<c015cdce>] vfs_stat+0x1e/0x60
Aug 13 06:53:03 middle kernel:  [<c015d43b>] sys_stat64+0x1b/0x40
Aug 13 06:53:03 middle kernel:  [<c03ca78f>] syscall_call+0x7/0xb
Aug 13 06:53:03 middle kernel: 

Kind regards,
Jurriaan
-- 
All lies all lies all schemes all schemes
Every winner means a loser in the western dream.
	News Model Army - Western Dream
Debian (Unstable) GNU/Linux 2.6.0-test3-mm1 4276 bogomips load av: 0.00 0.26 0.26
