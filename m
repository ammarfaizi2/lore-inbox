Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129228AbQLPDfd>; Fri, 15 Dec 2000 22:35:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130688AbQLPDfY>; Fri, 15 Dec 2000 22:35:24 -0500
Received: from ginaz2.justnet.com ([64.245.23.10]:45832 "EHLO
	ginaz2.justnet.com") by vger.kernel.org with ESMTP
	id <S129228AbQLPDfN>; Fri, 15 Dec 2000 22:35:13 -0500
Message-Id: <5.0.0.25.2.20001215205029.00a8a688@mail.ricis.com>
X-Mailer: QUALCOMM Windows Eudora Version 5.0
Date: Fri, 15 Dec 2000 21:04:31 -0600
To: linux-kernel@vger.kernel.org
From: Lee Leahu <lee@ricis.com>
Subject: Kernel panic: VFS: LRU block list corrupted
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello all,

One of my linux servers crash with a 'kernal panic: VFS: LRU block list 
corrupted' message on my screen.
I reboot with a boot disk - it was find, then rebooted of the hard drive 
and it was fine.  The systems is runing fine
now, but i thought maybe someone on this list could explain to me what 
exactly happend there.

My /var/log/messages files displays this:

Dec 14 18:55:48 cache2 kernel: kmem_free: Bad obj addr (objp=cf103ba0, 
name=buffer_head)
Dec 14 18:55:48 cache2 kernel: Unable to handle kernel NULL pointer 
dereference at virtual address 00000000
Dec 14 18:55:48 cache2 kernel: current->tss.cr3 = 00101000, %%cr3 = 00101000
Dec 14 18:55:48 cache2 kernel: *pde = 00000000
Dec 14 18:55:48 cache2 kernel: Oops: 0002
Dec 14 18:55:48 cache2 kernel: CPU:    0
Dec 14 18:55:48 cache2 kernel: EIP:    0010:[kmem_cache_free+320/360]
Dec 14 18:55:48 cache2 kernel: EFLAGS: 00010286
Dec 14 18:55:48 cache2 kernel: eax: 0000003d   ebx: cf103ba0   ecx: 
00000001   edx: 0000003a
Dec 14 18:55:48 cache2 kernel: esi: cffaf740   edi: 00000286   ebp: 
c0546a68   esp: cff93ecc
Dec 14 18:55:48 cache2 kernel: ds: 0018   es: 0018   ss: 0018
Dec 14 18:55:48 cache2 kernel: Process kswapd (pid: 5, process nr: 5, 
stackpage=cff93000)
Dec 14 18:55:48 cache2 kernel: Stack: cf103ba0 c0546a68 cf103ba0 00000030 
cff93f38 0000000e cff93f30 cffa9320
Dec 14 18:55:48 cache2 kernel:        c010a582 c0128026 cffaf740 cf103ba0 
cf100018 0000001f cf103ba0 c0546a68
Dec 14 18:55:48 cache2 kernel:        c010a198 c0546a68 cf103ba0 cf103ba0 
cf103ba0 c0128dd5 cf103ba0 002283f0
Dec 14 18:55:48 cache2 kernel: Call Trace: [do_IRQ+42/72] 
[put_unused_buffer_head+38/84] [common_interrupt+24/32] 
[try_to_free_buffers+65/144] [try_to_free_buffers+56/144] 
[try_to_free_buffers+20/144] [shrink_mmap+225/312]
Dec 14 18:55:48 cache2 kernel:        [shrink_mmap+12/312] 
[shrink_mmap+0/312] [do_try_to_free_pages+49/148] [tvecs+7662/14432] 
[tvecs+7662/14432] [kswapd+106/160] [kswapd+124/160] [kernel_thread+31/56]
Dec 14 18:55:48 cache2 kernel:        [kernel_thread+40/56]
Dec 14 18:55:48 cache2 kernel: Code: c7 05 00 00 00 00 00 00 00 00 eb 12 83 
c4 fc 56 53 68 3e d0
Dec 14 18:56:31 cache2 kernel: Kernel panic: VFS: LRU block list corrupted


My boss and I looked over it and it looks like something to do with virtual 
memory.

I was logged in remotely ussing SSH and was using LAME to convert some 
wav's to mp3's
my boss suggested that one of the wav files might have been corrupted.

What can you guys suggest?

Lee Leahu
System Administrator
lee@ricis.com

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
