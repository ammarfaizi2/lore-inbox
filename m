Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262378AbTJIS0Y (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Oct 2003 14:26:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262375AbTJIS0Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Oct 2003 14:26:24 -0400
Received: from e3.ny.us.ibm.com ([32.97.182.103]:48350 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S262378AbTJIS0W (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Oct 2003 14:26:22 -0400
Date: Thu, 09 Oct 2003 11:26:38 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Andrew Morton <akpm@digeo.com>
cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: ext3 panic 
Message-ID: <34930000.1065723998@flay>
X-Mailer: Mulberry/2.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This was actually on test6-mjb1, but I seem to recall the same panic 
occuring on test6 (but it garbled by syslog last time). Running tiobench.

This time I'm running a 2/2 split, which is why the addresses all start in 8.
EIP is ... odd ;-)

M.

invalid operand: 0000 [#1]
CPU:    5
EIP:    0060:[<b4539c59>]    Not tainted
EFLAGS: 00010282
EIP is at 0xb4539c59
eax: d8b9cce0   ebx: 00000002   ecx: 8be3f000   edx: b4539c4c
esi: 00000000   edi: d7e78ae0   ebp: b38c8870   esp: b4539c68
ds: 007b   es: 007b   ss: 0068
Process tiotest (pid: 11173, threadinfo=b4538000 task=d8b9cce0)
Stack: d859e6e0 00000000 d7e78ae0 b4539d04 caffba00 d8b52180 00000000 00000000 
       00000006 caffba00 00000000 d7865d10 d859e6e0 8018294f d9418100 8018c689 
       d859e6e0 d7e78ae0 00000000 00000000 b38c8870 00000000 b38c8870 d859e6e0 
Call Trace:
 [<8018294f>] ext3_get_inode_loc+0x57/0x23c
 [<8018c689>] journal_get_write_access+0x21/0x34
 [<8018348c>] ext3_reserve_inode_write+0x34/0x98
 [<8018350a>] ext3_mark_inode_dirty+0x1a/0x34
 [<80183577>] ext3_dirty_inode+0x53/0x68
 [<80168e99>] __mark_inode_dirty+0x29/0xcc
 [<80150676>] generic_commit_write+0x76/0x84
 [<801812f0>] ext3_ordered_commit_write+0x90/0xb4
 [<8013386f>] generic_file_aio_write_nolock+0x85b/0xa40
 [<80121a3c>] do_softirq+0x6c/0xcc
 [<80133b47>] generic_file_aio_write+0x67/0x80
 [<8017ef1f>] ext3_file_write+0x2b/0xb7
 [<8014d0dd>] do_sync_write+0x81/0xb0
 [<8011a5a3>] scheduler_tick+0x6b7/0x6c4
 [<8011a5a3>] scheduler_tick+0x6b7/0x6c4
 [<8011529d>] smp_apic_timer_interrupt+0x149/0x154
 [<8011a62b>] schedule+0x73/0x720
 [<8014d1ac>] vfs_write+0xa0/0xd0
 [<8014d259>] sys_write+0x31/0x4c
 [<8010a64f>] syscall_call+0x7/0xb

Code: ff ff ff 59 9c 53 b4 60 00 00 00 82 02 01 00 e0 e6 59 d8 00 

