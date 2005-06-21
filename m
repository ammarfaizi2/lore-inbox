Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261663AbVFUISF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261663AbVFUISF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Jun 2005 04:18:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261629AbVFUIQ2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Jun 2005 04:16:28 -0400
Received: from postfix3-2.free.fr ([213.228.0.169]:64912 "EHLO
	postfix3-2.free.fr") by vger.kernel.org with ESMTP id S261989AbVFUHZt
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Jun 2005 03:25:49 -0400
Message-ID: <42B7C0FA.8070409@unice.fr>
Date: Tue, 21 Jun 2005 09:25:46 +0200
From: XIAO Gang <xiao@unice.fr>
Organization: =?ISO-8859-1?Q?Universit=E9_de_Nice_-_Sophia_Anti?=
 =?ISO-8859-1?Q?polis?=
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20030225
X-Accept-Language: en, fr, zh-CN, zh-TW
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: UML mode panick under 2.6.12
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I am unable to run UML mode (i386) under 2.6.12: the execution gives the 
following messages.

---------------------------------------------------------------------------------------------
Checking for /proc/mm...not found
Checking PROT_EXEC mmap in /tmp...OK
tracing thread pid = 26236
<5>Linux version 2.6.12 (xiao@cim06-1-82-234-179-206.fbx.proxad.net) 
(gcc version 3.2.2 20030222 (Red Hat Linux 3.2.2-5)) #22 Tue Jun 21 
09:21:30 CEST 2005
<7>On node 0 totalpages: 8192
<7>  DMA zone: 8192 pages, LIFO batch:3
<7>  Normal zone: 0 pages, LIFO batch:1
<7>  HighMem zone: 0 pages, LIFO batch:1
Built 1 zonelists
<5>Kernel command line: root=98:0
PID hash table entries: 256 (order: 8, 4096 bytes)
Dentry cache hash table entries: 8192 (order: 3, 32768 bytes)
Inode-cache hash table entries: 4096 (order: 2, 16384 bytes)
<6>Memory: 29500k available
<7>Calibrating delay loop... 1802.24 BogoMIPS (lpj=9011200)
Mount-cache hash table entries: 512
Checking for host processor cmov support...Yes
Checking for host processor xmm support...No
Checking that ptrace can change system call numbers...<0>Kernel panic - 
not syncing: Segfault with no mm

EIP: 0023:[<00000000>] CPU: 0 Not tainted ESP: 002b:a01a7f58 EFLAGS: 
00010207
    Not tainted
EAX: 00000000 EBX: a01a7f60 ECX: 00000000 EDX: a01d4a00
ESI: 00000000 EDI: 00000000 EBP: 00000002 DS: 002b ES: 002b
a01a7a38:  [<a002db01>] show_regs+0x1dd/0x1e8
a01a7a68:  [<a0018e37>] panic_exit+0x27/0x48
a01a7a88:  [<a004215e>] notifier_call_chain+0x22/0x40
a01a7ab8:  [<a0031a66>] panic+0x56/0x104
a01a7ad8:  [<a00182ee>] segv+0x1be/0x254
a01a7bb8:  [<a00186a8>] segv_handler+0x11c/0x180
a01a7bf8:  [<a001b7fd>] sig_handler_common_tt+0xa9/0x124
a01a7c58:  [<a002965f>] sig_handler+0x1f/0x34
a01a7c78:  [<a012b4e8>] __restore+0x0/0x8

---------------------------------------------------------------------------------------------

By the way, the output beyond the first three lines has to be printed 
out after a hack of printk(), as the latter usually failed to print out 
anything.

The kernel is compiled with a ported config from 2.6.10-um, and is run 
under exactly the same condition as the 2.6.10 counterpart which works 
fine. The host is under Linux-2.4.31.

-- 

XIAO Gang (~{P$8U~})                          xiao@unice.fr
          home page: pcmath126.unice.fr/xiao.html 



