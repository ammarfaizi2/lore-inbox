Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262564AbVFVDhF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262564AbVFVDhF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Jun 2005 23:37:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262566AbVFVDhF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Jun 2005 23:37:05 -0400
Received: from mx.freeshell.org ([192.94.73.21]:18917 "EHLO sdf.lonestar.org")
	by vger.kernel.org with ESMTP id S262564AbVFVDba (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Jun 2005 23:31:30 -0400
Date: Wed, 22 Jun 2005 03:31:15 +0000
From: Brian Minton <bminton@freeshell.org>
To: linux-kernel@vger.kernel.org
Subject: oops while booting
Message-ID: <20050622033115.GA22543@SDF.LONESTAR.ORG>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
X-Operating-System: NetBSD norge 2.0.2_STABLE NetBSD 2.0.2_STABLE (sdf)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I captured these using serial console.

Unable to handle kernel paging request at virtual address d8000000
 printing eip:
c02130fd
*pde = 00000000
Oops: 0000 [#1]
PREEMPT SMP 
Modules linked in:
CPU:    0
EIP:    0060:[<c02130fd>]    Not tainted VLI
EFLAGS: 00010202   (2.6.12) 
EIP is at memcpy+0x1d/0x40
eax: ffffffd0   ebx: d534df68   ecx: 3f4d37f4   edx: d534df68
esi: d8000000   edi: d7ffff68   ebp: 00000000   esp: d46a7790
ds: 007b   es: 007b   ss: 0068
Process bind (pid: 1482, threadinfo=d46a6000 task=d479a540)
Stack: 00000fd0 d4c42800 c0213190 d534df68 d534e000 ffffffd0 d534d048 00000fd0 
       d4c42800 c01b2e3c d534df68 d534e000 ffffffd0 ffffffff d4c42800 00000001 
       d534d000 00000fe8 00000000 d4c42800 d5102000 d46a7b84 00000002 d46a78d0 
Call Trace:
 [<c0213190>] memmove+0x50/0x54
 [<c01b2e3c>] leaf_insert_into_buf+0xac/0x270
 [<c019b4b4>] balance_leaf+0x1554/0x3090
 [<c01aaad7>] ip_check_balance+0x2d7/0xbb0
 [<c01aa1b5>] get_empty_nodes+0x155/0x1a0
 [<c019d375>] do_balance+0x95/0x110
 [<c01ac522>] fix_nodes+0x1c2/0x3e0
 [<c01b9414>] reiserfs_insert_item+0x204/0x2d0
 [<c01ba477>] indirect2direct+0x1d7/0x2d0
 [<c01b88f3>] reiserfs_cut_from_item+0x483/0x560
 [<c01b8d3e>] reiserfs_do_truncate+0x2be/0x5b0
 [<c01a3d01>] reiserfs_truncate_file+0xf1/0x230
 [<c01a58a1>] reiserfs_file_release+0x261/0x4a0
 [<c016ff16>] open_namei+0xa6/0x630
 [<c0126d95>] update_wall_time+0x15/0x40
 [<c0160f4b>] __fput+0x11b/0x130
 [<c015f589>] filp_close+0x59/0x90
 [<c01724f8>] sys_dup2+0xc8/0x100
 [<c0102f45>] syscall_call+0x7/0xb
Code: 50 fd 31 c0 c3 31 d2 b8 f2 ff ff ff c3 90 83 ec 08 8b 44 24 14 89 34 24 8b 54 24 0c 89 7c 24 04 8b 74 24 10 89 c1 c1 e9 02 89 d7 <f3> a5 89 c1 83 e1 03 74 02 f3 a4 8b 34 24 89 d0 8b 7c 24 04 83 
 <1>Unable to handle kernel paging request at virtual address ffffffef
 printing eip:
c01539a3
*pde = 00003067
*pte = 00000000
Oops: 0000 [#2]
PREEMPT SMP 
Modules linked in:
CPU:    0
EIP:    0060:[<c01539a3>]    Not tainted VLI
EFLAGS: 00010286   (2.6.12) 
EIP is at find_vma+0x43/0x70
eax: ffffffe7   ebx: 7376de7c   ecx: c7104573   edx: ffffffff
esi: d4071800   edi: c036aef3   ebp: d479a540   esp: d46a7500
ds: 007b   es: 007b   ss: 0068
Process bind (pid: 1482, threadinfo=d46a6000 task=d479a540)
Stack: d4071800 d407182c c0115310 d4071800 7376de7c d46a752c c02643a4 c1408000 
       7376de7c 00000000 d46a75e0 d46a75e0 c036aef3 00000000 0000000e 0000000b 
       00000206 c01266f9 c1303ee0 c04bdce0 00000000 00030001 00000000 00000206 
Call Trace:
 [<c0115310>] do_page_fault+0xf0/0x5d5
 [<c02643a4>] set_cursor+0x64/0x80
 [<c01266f9>] __mod_timer+0xf9/0x140
 [<c026c847>] i8042_interrupt+0x237/0x270
 [<c013fc66>] __do_IRQ+0xf6/0x120
 [<c026c9f0>] i8042_timer_func+0x0/0x20
 [<c0127026>] run_timer_softirq+0x126/0x1c0
 [<c0115220>] do_page_fault+0x0/0x5d5
 [<c0103a5b>] error_code+0x4f/0x54
 [<c027fbea>] exit_io_context+0x2a/0x60
 [<c0120390>] do_exit+0x360/0x390
 [<c011007b>] apm_enable_power_management+0xb/0x90
 [<c0104248>] die+0x188/0x190
 [<c01154fa>] do_page_fault+0x2da/0x5d5
 [<c01188bf>] rebalance_tick+0xcf/0xe0
 [<c0118b96>] scheduler_tick+0xb6/0x400
 [<c0127026>] run_timer_softirq+0x126/0x1c0
 [<c0122a46>] __do_softirq+0xd6/0xf0
 [<c0115220>] do_page_fault+0x0/0x5d5
 [<c0103a5b>] error_code+0x4f/0x54
 [<c02130fd>] memcpy+0x1d/0x40
 [<c0213190>] memmove+0x50/0x54
 [<c01b2e3c>] leaf_insert_into_buf+0xac/0x270
 [<c019b4b4>] balance_leaf+0x1554/0x3090
 [<c01aaad7>] ip_check_balance+0x2d7/0xbb0
 [<c01aa1b5>] get_empty_nodes+0x155/0x1a0
 [<c019d375>] do_balance+0x95/0x110
 [<c01ac522>] fix_nodes+0x1c2/0x3e0
 [<c01b9414>] reiserfs_insert_item+0x204/0x2d0
 [<c01ba477>] indirect2direct+0x1d7/0x2d0
 [<c01b88f3>] reiserfs_cut_from_item+0x483/0x560
 [<c01b8d3e>] reiserfs_do_truncate+0x2be/0x5b0
 [<c01a3d01>] reiserfs_truncate_file+0xf1/0x230
 [<c01a58a1>] reiserfs_file_release+0x261/0x4a0
 [<c016ff16>] open_namei+0xa6/0x630
 [<c0126d95>] update_wall_time+0x15/0x40
 [<c0160f4b>] __fput+0x11b/0x130
 [<c015f589>] filp_close+0x59/0x90
 [<c01724f8>] sys_dup2+0xc8/0x100
 [<c0102f45>] syscall_call+0x7/0xb
Code: 59 08 76 14 39 59 04 76 3c eb 0d 90 90 90 90 90 90 90 90 90 90 90 90 90 8b 56 04 31 c9 85 d2 74 24 8d b4 26 00 00 00 00 8d 42 e8 <39> 58 08 76 1a 39 58 04 89 c1 76 07 8b 52 0c 85 d2 75 ea 85 c9 
 mm/memory.c:105: bad pgd 000001e3.
mm/memory.c:105: bad pgd 004001e3.
mm/memory.c:105: bad pgd 008001e3.
mm/memory.c:105: bad pgd 00c001e3.
mm/memory.c:105: bad pgd 010001e3.
mm/memory.c:105: bad pgd 014001e3.
mm/memory.c:105: bad pgd 018001e3.
mm/memory.c:105: bad pgd 01c001e3.
mm/memory.c:105: bad pgd 020001e3.
mm/memory.c:105: bad pgd 024001e3.
mm/memory.c:105: bad pgd 028001e3.
mm/memory.c:105: bad pgd 02c001e3.
mm/memory.c:105: bad pgd 030001e3.
mm/memory.c:105: bad pgd 034001e3.
mm/memory.c:105: bad pgd 038001e3.
mm/memory.c:105: bad pgd 03c001e3.
mm/memory.c:105: bad pgd 040001e3.
mm/memory.c:105: bad pgd 044001e3.
mm/memory.c:105: bad pgd 048001e3.
mm/memory.c:105: bad pgd 04c001e3.
mm/memory.c:105: bad pgd 050001e3.
mm/memory.c:105: bad pgd 054001e3.
mm/memory.c:105: bad pgd 058001e3.
mm/memory.c:105: bad pgd 05c001e3.
mm/memory.c:105: bad pgd 060001e3.
mm/memory.c:105: bad pgd 064001e3.
mm/memory.c:105: bad pgd 068001e3.
mm/memory.c:105: bad pgd 06c001e3.
mm/memory.c:105: bad pgd 070001e3.
mm/memory.c:105: bad pgd 074001e3.
mm/memory.c:105: bad pgd 078001e3.
mm/memory.c:105: bad pgd 07c001e3.
mm/memory.c:105: bad pgd 080001e3.
mm/memory.c:105: bad pgd 084001e3.
mm/memory.c:105: bad pgd 088001e3.
mm/memory.c:105: bad pgd 08c001e3.
mm/memory.c:105: bad pgd 090001e3.
mm/memory.c:105: bad pgd 094001e3.
mm/memory.c:105: bad pgd 098001e3.
mm/memory.c:105: bad pgd 09c001e3.
mm/memory.c:105: bad pgd 0a0001e3.
mm/memory.c:105: bad pgd 0a4001e3.
mm/memory.c:105: bad pgd 0a8001e3.
mm/memory.c:105: bad pgd 0ac001e3.
mm/memory.c:105: bad pgd 0b0001e3.
mm/memory.c:105: bad pgd 0b4001e3.
mm/memory.c:105: bad pgd 0b8001e3.
mm/memory.c:105: bad pgd 0bc001e3.
mm/memory.c:105: bad pgd 0c0001e3.
mm/memory.c:105: bad pgd 0c4001e3.
mm/memory.c:105: bad pgd 0c8001e3.
mm/memory.c:105: bad pgd 0cc001e3.
mm/memory.c:105: bad pgd 0d0001e3.
mm/memory.c:105: bad pgd 0d4001e3.
mm/memory.c:105: bad pgd 0d8001e3.
mm/memory.c:105: bad pgd 0dc001e3.
mm/memory.c:105: bad pgd 0e0001e3.
mm/memory.c:105: bad pgd 0e4001e3.
mm/memory.c:105: bad pgd 0e8001e3.
mm/memory.c:105: bad pgd 0ec001e3.
mm/memory.c:105: bad pgd 0f0001e3.


and here is the second one.


Unable to handle kernel paging request at virtual address d8000000
 printing eip:
c02130fd
*pde = 00000000
Oops: 0000 [#1]
PREEMPT SMP 
Modules linked in:
CPU:    0
EIP:    0060:[<c02130fd>]    Not tainted VLI
EFLAGS: 00010202   (2.6.12) 
EIP is at memcpy+0x1d/0x40
eax: ffffffd0   ebx: d5105f68   ecx: 3f4417f4   edx: d5105f68
esi: d8000000   edi: d7ffff68   ebp: 00000000   esp: d4a99790
ds: 007b   es: 007b   ss: 0068
Process bind (pid: 1496, threadinfo=d4a98000 task=d49ac540)
Stack: 00000fd0 d6c93458 c0213190 d5105f68 d5106000 ffffffd0 d5105048 00000fd0 
       d6c93458 c01b2e3c d5105f68 d5106000 ffffffd0 ffffffff d6c93458 00000001 
       d5105000 00000fe8 00000000 d6c93458 d5269000 d4a99b84 00000002 d4a998d0 
Call Trace:
 [<c0213190>] memmove+0x50/0x54
 [<c01b2e3c>] leaf_insert_into_buf+0xac/0x270
 [<c019b4b4>] balance_leaf+0x1554/0x3090
 [<c01aaad7>] ip_check_balance+0x2d7/0xbb0
 [<c01aa1b5>] get_empty_nodes+0x155/0x1a0
 [<c019d375>] do_balance+0x95/0x110
 [<c01ac522>] fix_nodes+0x1c2/0x3e0
 [<c01b9414>] reiserfs_insert_item+0x204/0x2d0
 [<c01ba477>] indirect2direct+0x1d7/0x2d0
 [<c01b88f3>] reiserfs_cut_from_item+0x483/0x560
 [<c01b8d3e>] reiserfs_do_truncate+0x2be/0x5b0
 [<c01a3d01>] reiserfs_truncate_file+0xf1/0x230
 [<c01a58a1>] reiserfs_file_release+0x261/0x4a0
 [<c016ff16>] open_namei+0xa6/0x630
 [<c0126d95>] update_wall_time+0x15/0x40
 [<c0160f4b>] __fput+0x11b/0x130
 [<c015f589>] filp_close+0x59/0x90
 [<c01724f8>] sys_dup2+0xc8/0x100
 [<c0102f45>] syscall_call+0x7/0xb
Code: 50 fd 31 c0 c3 31 d2 b8 f2 ff ff ff c3 90 83 ec 08 8b 44 24 14 89 34 24 8b 54 24 0c 89 7c 24 04 8b 74 24 10 89 c1 c1 e9 02 89 d7 <f3> a5 89 c1 83 e1 03 74 02 f3 a4 8b 34 24 89 d0 8b 7c 24 04 83 
 <1>Unable to handle kernel paging request at virtual address 00768de8
 printing eip:
c01510fd
*pde = 00000000
Oops: 0000 [#2]
PREEMPT SMP 
Modules linked in:
CPU:    0
EIP:    0060:[<c01510fd>]    Not tainted VLI
EFLAGS: 00010202   (2.6.12) 
EIP is at do_no_page+0x2d/0x250
eax: 00768de0   ebx: d4f44020   ecx: 00000000   edx: d557e154
esi: 00000000   edi: 02055e63   ebp: b7dddfe8   esp: d4a9949c
ds: 007b   es: 007b   ss: 0068
Process bind (pid: 1496, threadinfo=d4a98000 task=d49ac540)
Stack: 00000000 c04a55be d496e5c0 02055e63 d496e580 00000202 00000001 c014f294 
       00000000 00000000 00000001 d4f44020 d496e580 02055e63 d496e5c0 c015154b 
       d496e580 b7dddfe8 02055e63 00000000 d557e154 d4f44020 00000002 d496e580 
Call Trace:
 [<c014f294>] pte_alloc_map+0x94/0xd0
 [<c015154b>] handle_mm_fault+0x11b/0x1a0
 [<c01153bc>] do_page_fault+0x19c/0x5d5
 [<c01266f9>] __mod_timer+0xf9/0x140
 [<c026c847>] i8042_interrupt+0x237/0x270
 [<c0126e51>] update_process_times+0x91/0x120
 [<c026c9f0>] i8042_timer_func+0x0/0x20
 [<c0127026>] run_timer_softirq+0x126/0x1c0
 [<c0115220>] do_page_fault+0x0/0x5d5
 [<c0103a5b>] error_code+0x4f/0x54
 [<c027fbea>] exit_io_context+0x2a/0x60
 [<c0120390>] do_exit+0x360/0x390
 [<c011007b>] apm_enable_power_management+0xb/0x90
 [<c0104248>] die+0x188/0x190
 [<c01154fa>] do_page_fault+0x2da/0x5d5
 [<c0118b96>] scheduler_tick+0xb6/0x400
 [<c0127026>] run_timer_softirq+0x126/0x1c0
 [<c0122a46>] __do_softirq+0xd6/0xf0
 [<c0115220>] do_page_fault+0x0/0x5d5
 [<c0103a5b>] error_code+0x4f/0x54
 [<c02130fd>] memcpy+0x1d/0x40
 [<c0213190>] memmove+0x50/0x54
 [<c01b2e3c>] leaf_insert_into_buf+0xac/0x270
 [<c019b4b4>] balance_leaf+0x1554/0x3090
 [<c01aaad7>] ip_check_balance+0x2d7/0xbb0
 [<c01aa1b5>] get_empty_nodes+0x155/0x1a0
 [<c019d375>] do_balance+0x95/0x110
 [<c01ac522>] fix_nodes+0x1c2/0x3e0
 [<c01b9414>] reiserfs_insert_item+0x204/0x2d0
 [<c01ba477>] indirect2direct+0x1d7/0x2d0
 [<c01b88f3>] reiserfs_cut_from_item+0x483/0x560
 [<c01b8d3e>] reiserfs_do_truncate+0x2be/0x5b0
 [<c01a3d01>] reiserfs_truncate_file+0xf1/0x230
 [<c01a58a1>] reiserfs_file_release+0x261/0x4a0
 [<c016ff16>] open_namei+0xa6/0x630
 [<c0126d95>] update_wall_time+0x15/0x40
 [<c0160f4b>] __fput+0x11b/0x130
 [<c015f589>] filp_close+0x59/0x90
 [<c01724f8>] sys_dup2+0xc8/0x100
 [<c0102f45>] syscall_call+0x7/0xb
Code: c0 57 56 31 f6 53 83 ec 2c 8b 6c 24 44 89 44 24 24 8b 54 24 50 31 c0 89 44 24 20 b8 01 00 00 00 89 44 24 28 8b 45 44 85 c0 74 07 <8b> 40 08 85 c0 75 34 89 54 24 08 8b 44 24 48 8b 54 24 40 89 6c 
 <6>note: bind[1496] exited with preempt_count 1


-- 
SDF Public Access UNIX System - http://sdf.lonestar.org
