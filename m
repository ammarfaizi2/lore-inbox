Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932177AbWAEXEX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932177AbWAEXEX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jan 2006 18:04:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932252AbWAEXEX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jan 2006 18:04:23 -0500
Received: from pin.if.uz.zgora.pl ([212.109.128.251]:63462 "EHLO
	pin.if.uz.zgora.pl") by vger.kernel.org with ESMTP id S932177AbWAEXEW
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jan 2006 18:04:22 -0500
Message-ID: <43BDA76F.1000906@pin.if.uz.zgora.pl>
Date: Fri, 06 Jan 2006 00:10:39 +0100
From: Jacek Luczak <difrost@pin.if.uz.zgora.pl>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20050923)
X-Accept-Language: pl, en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Oops with 2.6.15
Content-Type: text/plain; charset=ISO-8859-2; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

HI all

I receive this Oops (see below) with kernels from 2.6.15-rc5 to 2.6.15 
(I haven't using earlier versions of 2.6.15-rc). I'm using sk98lin 
driver (version 8.28.1.3) from Syskonnect and ndiswrapper-1.7. Is this 
error caused by sk98lin driver?

--------
CPU: Intel Pentium4 3GHz HT
GCC: 3.4.5
Binutils: 2.16.1
--------

Regards

	Jacek Luczak

-------------------------------

Jan  5 19:25:04 slawek kernel: Unable to handle kernel NULL pointer 
dereference at virtual address 00000003
Jan  5 19:25:04 slawek kernel:  printing eip:
Jan  5 19:25:04 slawek kernel: c0138603
Jan  5 19:25:04 slawek kernel: *pde = 00000000
Jan  5 19:25:04 slawek kernel: Oops: 0002 [#1]
Jan  5 19:25:04 slawek kernel: SMP
Jan  5 19:25:04 slawek kernel: Modules linked in: sk98lin ndiswrapper 
usbhid uhci_hcd i915
Jan  5 19:25:04 slawek kernel: CPU:    0
Jan  5 19:25:04 slawek kernel: EIP:    0060:[<c0138603>]    Tainted: P 
     VLI
Jan  5 19:25:05 slawek kernel: EFLAGS: 00010086   (2.6.15)
Jan  5 19:25:05 slawek kernel: EIP is at free_block+0x45/0xd1
Jan  5 19:25:05 slawek kernel: eax: ffffffff   ebx: df0388c0   ecx: 
de9fbbc0   edx: 00000000
Jan  5 19:25:05 slawek kernel: esi: df7ad340   edi: 00000005   ebp: 
df7af600   esp: df731ef0
Jan  5 19:25:05 slawek kernel: ds: 007b   es: 007b   ss: 0068
Jan  5 19:25:05 slawek kernel: Process events/0 (pid: 6, 
threadinfo=df730000 task=df70ea30)
Jan  5 19:25:05 slawek kernel: Stack: df7ad350 00000002 deabd800 
df7aa194 0000000b df7aa180 00000000 c0138e15
Jan  5 19:25:05 slawek kernel:        df7af600 df7aa194 0000000b 
00000000 df7af600 df7ad340 df7af600 df7af654
Jan  5 19:25:05 slawek kernel:        00000003 c0138ea9 df7af600 
df7aa180 00000000 00000000 c146e418 c13f71a0
Jan  5 19:25:05 slawek kernel: Call Trace:
Jan  5 19:25:05 slawek kernel:  [<c0138e15>] drain_array_locked+0x6a/0x95
Jan  5 19:25:05 slawek kernel:  [<c0138ea9>] cache_reap+0x69/0x155
Jan  5 19:25:05 slawek kernel:  [<c012533e>] worker_thread+0x170/0x1de
Jan  5 19:25:05 slawek kernel:  [<c0138e40>] cache_reap+0x0/0x155
Jan  5 19:25:05 slawek kernel:  [<c01148e2>] default_wake_function+0x0/0x12
Jan  5 19:25:05 slawek kernel:  [<c01148e2>] default_wake_function+0x0/0x12
Jan  5 19:25:05 slawek kernel:  [<c01251ce>] worker_thread+0x0/0x1de
Jan  5 19:25:05 slawek kernel:  [<c01288df>] kthread+0x7c/0xa6
Jan  5 19:25:05 slawek kernel:  [<c0128863>] kthread+0x0/0xa6
Jan  5 19:25:05 slawek kernel:  [<c0100eb5>] kernel_thread_helper+0x5/0xb
Jan  5 19:25:05 slawek kernel: Code: 24 8b 54 24 2c 8b 04 b8 89 44 24 08 
05 00 00 00 40 c1 e8 0c 8b 74 95 18 31 d2 c1 e0 05 03 05 d0 e4 35 c0 8b 
58 1c 8b 03 8b 4b 04 <89> 48 04 89 01 c7 43 04 00 02 20 00 c7 03 00 01 
10 00 8b 43 0c
