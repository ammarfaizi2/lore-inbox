Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265243AbSLVULo>; Sun, 22 Dec 2002 15:11:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265250AbSLVULo>; Sun, 22 Dec 2002 15:11:44 -0500
Received: from franka.aracnet.com ([216.99.193.44]:7406 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP
	id <S265243AbSLVULm>; Sun, 22 Dec 2002 15:11:42 -0500
Date: Sun, 22 Dec 2002 12:19:46 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Panic on shutdown
Message-ID: <63340000.1040588386@titus>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Does this look familiar to anyone? Virgin 2.5.52 on NUMA-Q.

Saving random seed... done.
Unmounting remote filesystems... Unable to handle kernel NULL pointer 
dereferenc
e at virtual address 00000504
 printing eip:
c012e5d0
*pde = 00104001
*pte = 00000000
Oops: 0002
CPU:    15
EIP:    0060:[<c012e5d0>]    Not tainted
EFLAGS: 00010046
EIP is at __pdflush+0x30/0x1e8
eax: 00000000   ebx: ede14000   ecx: eeff2d64   edx: eeff2cc0
esi: c020bcf4   edi: eeff2fae   ebp: ede15fd8   esp: ede15fc0
ds: 0068   es: 0068   ss: 0068
Process pdflush (pid: 4033, threadinfo=ede14000 task=eeff2cc0)
Stack: c012e788 00000000 00000000 00000000 c012e793 ede15fd8 00000000 
00000000
       00000068 00000068 ffffffff c0106e7c c0106e81 00000000 00000000 
00000000
Call Trace:
 [<c012e788>] pdflush+0x0/0x14
 [<c012e793>] pdflush+0xb/0x14
 [<c0106e7c>] kernel_thread_helper+0x0/0xc
 [<c0106e81>] kernel_thread_helper+0x5/0xc

Code: f0 fe 88 04 05 00 00 0f 88 60 02 00 00 8b 03 c7 80 a0 05 00
 <1>Unable to handle kernel NULL pointer dereference at virtual address 
0000051c
 printing eip:
c011c3e3
*pde = 2f664001
*pte = 00000000
Oops: 0000
CPU:    10
EIP:    0060:[<c011c3e3>]    Not tainted
EFLAGS: 00010286
EIP is at sys_wait4+0x23b/0x418
eax: 00000008   ebx: 00000000   ecx: 00000000   edx: 00000008
esi: eeff2cc0   edi: f018e0dc   ebp: f0198000   esp: f0199f7c
ds: 0068   es: 0068   ss: 0068
Process init (pid: 1, threadinfo=f0198000 task=f018e040)
Stack: f0198000 00000000 bffff750 bffff714 f0198000 00000001 f018e040 
00000000
       f018e040 c0116d88 00000000 00000000 00000000 f018e040 c0116d88 
f018e194
       f018e194 c0108a27 ffffffff bffff750 00000001 00000000 bffff750 
bffff714
Call Trace:
 [<c0116d88>] default_wake_function+0x0/0x34
 [<c0116d88>] default_wake_function+0x0/0x34
 [<c0108a27>] syscall_call+0x7/0xb

Code: 83 b9 1c 05 00 00 00 74 2a 8b 54 24 4c 83 c2 04 19 c0 39 55
 <0>Kernel panic: Attempted to kill init!

