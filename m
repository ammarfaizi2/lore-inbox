Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265480AbTBPBBP>; Sat, 15 Feb 2003 20:01:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265484AbTBPBBP>; Sat, 15 Feb 2003 20:01:15 -0500
Received: from franka.aracnet.com ([216.99.193.44]:59576 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP
	id <S265480AbTBPBBN>; Sat, 15 Feb 2003 20:01:13 -0500
Date: Sat, 15 Feb 2003 17:11:02 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: 2.5.61 oops running SDET
Message-ID: <33450000.1045357862@[10.10.2.4]>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

SDET on 16-way NUMA-Q.

Unable to handle kernel NULL pointer dereference at virtual address 00000014
 printing eip:
c0118b13
*pde = 2b146001
*pte = 00000000
Oops: 0000
CPU:    10
EIP:    0060:[<c0118b13>]    Not tainted
EFLAGS: 00010207
EIP is at render_sigset_t+0x17/0x7c
eax: 00000010   ebx: ed2fe0a1   ecx: ed2fe099   edx: eddd3980
esi: 0000003c   edi: 00000010   ebp: ec7d7eec   esp: ec7d7ee0
ds: 007b   es: 007b   ss: 0068
Process ps (pid: 10544, threadinfo=ec7d6000 task=ed0a6700)
Stack: ed2fe0a1 00000002 eddd3f3c ed2fe080 c016d893 00000010 ed2fe0a1
ed2fe099 
       c0233f78 eddd3f3c ed2fe088 ed2fe080 c0233f6f ec7ccbd0 eddd3980
eb5caee0 
       ed2fe000 00000000 00000006 00000000 ec7d7f48 eddd3f3c eddd3f24
ec7d7f50 
Call Trace:
 [<c016d893>] proc_pid_status+0x2a3/0x358
 [<c01300f6>] __get_free_pages+0x4e/0x54
 [<c016b517>] proc_info_read+0x53/0x130
 [<c0145295>] vfs_read+0xa5/0x128
 [<c0145522>] sys_read+0x2a/0x3c
 [<c0108b3f>] syscall_call+0x7/0xb

Code: 0f a3 37 19 d2 b8 01 00 00 00 31 c9 85 d2 0f 45 c8 8d 56 01 
 <1>Unable to handle kernel NULL pointer dereference at virtual address
00000014
 printing eip:
c0118b13
*pde = 2cd41001
*pte = 00000000
Oops: 0000
CPU:    7
EIP:    0060:[<c0118b13>]    Not tainted
EFLAGS: 00010207
EIP is at render_sigset_t+0x17/0x7c
eax: 00000010   ebx: ed1280a1   ecx: ed128099   edx: ecdc61e0
esi: 0000003c   edi: 00000010   ebp: edc3feec   esp: edc3fee0
ds: 007b   es: 007b   ss: 0068
Process ps (pid: 12906, threadinfo=edc3e000 task=ee5fcce0)
Stack: ed1280a1 00000002 ecdc679c ed128080 c016d893 00000010 ed1280a1
ed128099 
       c0233f78 ecdc679c ed128088 ed128080 c0233f6f ed9d5e50 ecdc61e0
ec2adaa0 
       ed128000 00000000 00000006 00000000 edc3ff48 ecdc679c ecdc6784
edc3ff50 
Call Trace:
 [<c016d893>] proc_pid_status+0x2a3/0x358
 [<c01300f6>] __get_free_pages+0x4e/0x54
 [<c016b517>] proc_info_read+0x53/0x130
 [<c0145295>] vfs_read+0xa5/0x128
 [<c0145522>] sys_read+0x2a/0x3c
 [<c0108b3f>] syscall_call+0x7/0xb

Code: 0f a3 37 19 d2 b8 01 00 00 00 31 c9 85 d2 0f 45 c8 8d 56 01 
 <1>Unable to handle kernel NULL pointer dereference at virtual address
00000014
 printing eip:
c0118b13
*pde = 2bd20001
*pte = 00000000
Oops: 0000
CPU:    3
EIP:    0060:[<c0118b13>]    Not tainted
EFLAGS: 00010207
EIP is at render_sigset_t+0x17/0x7c
eax: 00000010   ebx: ec2cb09f   ecx: ec2cb097   edx: ec4ef3e0
esi: 0000003c   edi: 00000010   ebp: edf8beec   esp: edf8bee0
ds: 007b   es: 007b   ss: 0068
Process ps (pid: 16814, threadinfo=edf8a000 task=ebdd92e0)
Stack: ec2cb09f 00000002 ec4ef99c ec2cb07e c016d893 00000010 ec2cb09f
ec2cb097 
       c0233f78 ec4ef99c ec2cb086 ec2cb07e c0233f6f ed51a4f0 ec4ef3e0
eeb4eb40 
       ec2cb000 00000000 00000006 00000000 edf8bf48 ec4ef99c ec4ef984
edf8bf50 
Call Trace:
 [<c016d893>] proc_pid_status+0x2a3/0x358
 [<c01300f6>] __get_free_pages+0x4e/0x54
 [<c016b517>] proc_info_read+0x53/0x130
 [<c0145295>] vfs_read+0xa5/0x128
 [<c0145522>] sys_read+0x2a/0x3c
 [<c0108b3f>] syscall_call+0x7/0xb

Code: 0f a3 37 19 d2 b8 01 00 00 00 31 c9 85 d2 0f 45 c8 8d 56 01 

