Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266292AbTBCNHn>; Mon, 3 Feb 2003 08:07:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266297AbTBCNHm>; Mon, 3 Feb 2003 08:07:42 -0500
Received: from jive.SoftHome.net ([66.54.152.27]:62090 "HELO jive.SoftHome.net")
	by vger.kernel.org with SMTP id <S266292AbTBCNHl>;
	Mon, 3 Feb 2003 08:07:41 -0500
From: b_adlakha@softhome.net
To: linux-kernel@vger.kernel.org
Subject: [OOPS] 2.5.59
Date: Mon, 03 Feb 2003 06:17:13 -0700
Mime-Version: 1.0
Content-Type: text/plain; format=flowed; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [210.214.82.244]
Message-ID: <courier.3E3E6BD9.00002221@softhome.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I get his _every_ time I boot : 

printing eip:
c012764a
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0060:[<c012764a>]    Not tainted
EFLAGS: 00010093
EIP is at __find_symbol+0x3e/0x84
eax: c0354281   ebx: 000007c2   ecx: 00000000   edx: c0412020
esi: 40c0362e   edi: d0867190   ebp: cf7c5ec4   esp: cf7c5eb8
ds: 007b   es: 007b   ss: 0068
Process modprobe (pid: 42, threadinfo=cf7c4000 task=cf94b280)
Stack: cf7c4000 d0866f14 d0867580 cf7c5ee8 c012809f d0867190 cf7c5ee4 
00000001
       d0866cd4 d0866f14 0000004b 0000035c cf7c5f18 c01282de d0861f50 
00000019
       d0866f14 d0867190 d0867580 d0861f50 0000000f d0867580 00000000 
0000006f
Call Trace:
 [<c012809f>] resolve_symbol+0x2b/0x6c
 [<c01282de>] simplify_symbols+0x7e/0xe4
 [<c0128b44>] load_module+0x594/0x7ac
 [<c0128dd1>] sys_init_module+0x75/0x1c8
 [<c0108ca3>] syscall_call+0x7/0xb 

Code: ac ae 75 08 84 c0 75 f8 31 c0 eb 04 19 c0 0c 01 85 c0 75 12
 <6>note: modprobe[42] exited with preempt_count 1
Debug: sleeping function called from illegal context at 
include/asm/semaphore.h:119
Call Trace:
 [<c0117038>] __might_sleep+0x54/0x5c
 [<c0136c5b>] remove_shared_vm_struct+0x2b/0x7c
 [<c013808c>] exit_mmap+0x118/0x15c
 [<c011750d>] mmput+0x55/0x70
 [<c011aafb>] do_exit+0x157/0x3e0
 [<c0109ba7>] die+0x73/0x74
[<c0114adc>] do_page_fault+0x2dc/0x40e
[<c0114800>] do_page_fault+0x0/0x40e
[<c01571b8>] update_atime+0x14/0x98
[<c012b68f>] do_generic_mapping_read+0x34b/0x358
[<c012b98b>] __generic_file_aio_read+0x1af/0x1cc
[<c012b6dc>] file_read_actor+0x0/0x100
[<c01096cd>] error_code+0x2d/0x38
[<c013007b>] kmem_cache_create+0xd3/0x454
[<c012764a>] __find_symbol+0x3e/0x84
[<c012809f>] resolve_symbol+0x2b/0x6c
[<c01282de>] simplify_symbols+0x7e/0xe4
[<c0128b44>] load_module+0x594/0x7ac
[<c0128dd1>] sys_init_module+0x75/0x1c8
[<c0108ca3>] syscall_call+0x7/0xb 

