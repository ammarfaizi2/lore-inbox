Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270707AbTHFK7X (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Aug 2003 06:59:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270712AbTHFK7X
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Aug 2003 06:59:23 -0400
Received: from [66.212.224.118] ([66.212.224.118]:16909 "EHLO
	hemi.commfireservices.com") by vger.kernel.org with ESMTP
	id S270707AbTHFK7U (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Aug 2003 06:59:20 -0400
Date: Wed, 6 Aug 2003 06:47:35 -0400 (EDT)
From: Zwane Mwaikambo <zwane@arm.linux.org.uk>
X-X-Sender: zwane@montezuma.mastecende.com
To: Linux Kernel <linux-kernel@vger.kernel.org>
Cc: William Lee Irwin III <wli@holomorphy.com>
Subject: Oops 2.6.0-test2-mm4 in pmd_dtor
Message-ID: <Pine.LNX.4.53.0308060644280.7244@montezuma.mastecende.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hey Bill i thought you had a fix for this? Box has 16G of RAM.

INIT: version 2.84 booting
Unable to handle kernel NULL pointer dereference at virtual address 00000000
 printing eip:
c011df3d
*pde = 35e7a001
Oops: 0000 [#1]
PREEMPT SMP DEBUG_PAGEALLOC
CPU:    3
EIP:    0060:[<c011df3d>]    Not tainted VLI
EFLAGS: 00010002
EIP is at pgd_dtor+0x6d/0xe0
eax: c1000000   ebx: c19468cc   ecx: c19468e4   edx: 00000000
esi: f5e58000   edi: 00000046   ebp: f5f791e0   esp: f5e59afc
ds: 007b   es: 007b   ss: 0068
Process init (pid: 60, threadinfo=f5e58000 task=f5e8b000)
Stack: 00000000 f7ffde48 f5f79380 c014bd82 f5f79380 f7ffde48 00000000 c011e0ba
       f5f79000 cc3eb004 f5f79380 00000286 cc12d1c4 00000246 f5f5f6d4 c01561e7
       c0322374 00000000 00000000 f7ffd8ec 00000003 f5f79380 f5e88004 00000000
Call Trace:
 [<c014bd82>] kmem_cache_free+0x212/0x2c0
 [<c011e0ba>] pgd_free+0x3a/0x3f
 [<c01561e7>] remove_shared_vm_struct+0x27/0x80
 [<c011e0ba>] pgd_free+0x3a/0x3f
 [<c0125d3f>] __mmdrop+0x1f/0x38
 [<c012450e>] mmput+0xae/0xd0
 [<c01704de>] exec_mmap+0x1de/0x200
 [<c0170dd5>] flush_old_exec+0x8d5/0xb50
 [<c0170275>] open_exec+0x75/0xb0
 [<c01702ed>] kernel_read+0x3d/0x50
 [<c0190aa2>] load_elf_binary+0x442/0xa20
 [<c0124230>] autoremove_wake_function+0x0/0x40
 [<c01aa010>] ext3_lookup+0x90/0xb0
 [<c011f175>] change_page_attr+0x75/0xe0
 [<c0190660>] load_elf_binary+0x0/0xa20
 [<c01713d5>] search_binary_handler+0xc5/0x230
 [<c018fe1b>] load_script+0x19b/0x1b0
 [<c01519bd>] page_address+0x3d/0xf0
 [<c01519bd>] page_address+0x3d/0xf0
 [<c018fc80>] load_script+0x0/0x1b0
 [<c01713d5>] search_binary_handler+0xc5/0x230
 [<c01716c6>] do_execve+0x186/0x1e0
 [<c010b3f0>] sys_execve+0x30/0x70
 [<c031861b>] syscall_call+0x7/0xb

Code: 0d a4 34 37 c0 0f 88 a2 01 00 00 8b 44 24 10 05 00 00 00 40 c1 e8 0c 
8d 14 80 8d 14 50 a1 8c 3e 44 c0 8d 1c 90 8d 4b 18 8b 51 04 <39> 0a 74 08 
0f 0b 94 00 98 26 32 c0 8b 43 18 39 48 04 74 08 0f
 <6>note: init[60] exited with preempt_count 1
