Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262360AbTEKF12 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 May 2003 01:27:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262369AbTEKF12
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 May 2003 01:27:28 -0400
Received: from franka.aracnet.com ([216.99.193.44]:26550 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP id S262360AbTEKF11
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 May 2003 01:27:27 -0400
Date: Sat, 10 May 2003 20:25:48 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Andrew Morton <akpm@digeo.com>
cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: bug on shutdown from 68-mm4
Message-ID: <8570000.1052623548@[10.10.2.4]>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry if this is old news, haven't been paying attention for a week.
Bug on shutdown (just after it says "Power Down") from 68-mm4.
(the NUMA-Q).

Power down.
------------[ cut here ]------------
kernel BUG at arch/i386/kernel/smp.c:354!
invalid operand: 0000 [#1]
CPU:    0
EIP:    0060:[<c0113250>]    Not tainted VLI
EFLAGS: 00010293
EIP is at flush_tlb_others+0x20/0xa8
eax: 00000000   ebx: 00000000   ecx: eeb43220   edx: 00000002
esi: eeb43220   edi: eeb43220   ebp: 00000000   esp: ed3e1e58
ds: 007b   es: 007b   ss: 0068
Process halt (pid: 23618, threadinfo=ed3e0000 task=ef1d00c0)
Stack: c0113376 00000002 eeb43220 ffffffff c032c740 00000000 c013e16c eeb43220 
       eeb43220 ef1d00c0 fee1dead c032c740 0000000c c011a53f eeb43220 eeb43220 
       c011ddfe eeb43220 fee1dead ed3e0000 fee1dead ed3e0000 c0126dea 00000000 
Call Trace:
 [<c0113376>] flush_tlb_mm+0x6a/0x70
 [<c013e16c>] exit_mmap+0x148/0x1e4
 [<c011a53f>] mmput+0x5b/0x74
 [<c011ddfe>] do_exit+0x172/0x338
 [<c0126dea>] sys_reboot+0x1e2/0x2e8
 [<c011750d>] wake_up_process+0xd/0x14
 [<c012458f>] kill_proc_info+0x37/0x48
 [<c0124670>] kill_something_info+0xd0/0xd8
 [<c0125c35>] sys_kill+0x51/0x5c
 [<c01473c3>] filp_open+0x3b/0x5c
 [<c01187d2>] schedule+0x43a/0x500
 [<c0147799>] sys_open+0x59/0x74
 [<c0108c97>] syscall_call+0x7/0xb

Code: 0f b3 0d e0 94 32 c0 c3 8d 76 00 8b 54 24 04 8b 4c 24 08 85 d2 75 08 0f 0b 60 01 ea 73 23 c0 89 d0 23 05 a0 95 32 c0 39 d0 74 08 <0f> 0b 62 01 ea 73 23 c0 b8 00 e0 ff ff 21 e0 8b 40 10 0f a3 c2 

