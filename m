Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273833AbRIREzR>; Tue, 18 Sep 2001 00:55:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273834AbRIREy6>; Tue, 18 Sep 2001 00:54:58 -0400
Received: from dialup312.canberra.net.au ([203.33.188.184]:16644 "EHLO
	didi.local.net") by vger.kernel.org with ESMTP id <S273833AbRIREyn>;
	Tue, 18 Sep 2001 00:54:43 -0400
Message-ID: <000701c13ffb$785126d0$0200a8c0@W2K>
From: "Nick Piggin" <s3293115@student.anu.edu.au>
To: "Linux-Kernel" <linux-kernel@vger.kernel.org>
Subject: [2.4.10-pre11 OOPS] in do_generic_file_read
Date: Tue, 18 Sep 2001 14:36:16 +1000
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4133.2400
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I got the following oops on startup while mounting the root filesystem.
Unfortunately there was no "Code" because of a bad EIP value. If anyone
would like more information or anything for me to test, please CC me.

I would like to remind some people that preX kernels aren't exactly
considered stable - _these_ are the kernel's Linus releases for public
_testing_. While a large change to the VM is pretty drastic, its pretty
clear that Linus is under a lot of pressure to "fix" it. Maybe if we can
think of a way to improve the vm without changing any code or add a
/proc/sys/vm/bugs interface, we should!

Cheers, Nick

ksymoops 2.4.2 on i686 2.4.10-pre9. Options used
-v usr/src/linux/vmlinux (specified)
-K (specified)
-l /proc/modules (default)
-o /lib/modules/2.4.10-pre11/ (specified)
-m usr/src/linux/System.map (specified)
No modules in ksyms, skipping objects
No ksyms, skipping lsmod
Unable to handle kernel NULL pointer dereference at virtual address 00000000
00000000
*pde = 00000000
Oops: 0000
CPU: 0
EIP: 0010:[<00000000>]
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010206
eax: c0258960 ebx: c3c9c340 ecx: c10dd6c0 edx: c3fc7208
esi: c10dd6c0 edi: c3bdd520 ebp: 00000000 esp: c3b41ed8
ds: 0018 es: 0018 ss: 0018
Process fsck.ext2 (pid: 33, stackpage=c3b41000)
Stack: c0125554 c3c9c340 c10dd6c0 00000c00 00000001 00000000 00000400
c3bdd480
c3b40000 c3f5d420 c3cffd20 c3b40000 c0111ddc c3f5d420 c3cffd20 080640d4
00000000 c3c9c340 c3b41f4c 00000400 c0125b9f c3c9c340 c3c9c360 c3b41f4c
Call Trace: [<c0125554>] [<c0111ddc>] [<c0125b9f>] [<c01259a0>] [<c0131910>]
[<c0138a00>] [<c013176e>] [<c0106d2b>]
Code: Bad EIP value.

>>EIP; 00000000 Before first symbol
Trace; c0125554 <do_generic_file_read+2c4/500>
Trace; c0111ddc <do_page_fault+2fc/4e0>
Trace; c0125b9e <generic_file_read+19e/1c0>
Trace; c01259a0 <file_read_actor+0/60>
Trace; c0131910 <sys_read+b0/d0>
Trace; c0138a00 <block_llseek+0/a0>
Trace; c013176e <sys_lseek+6e/80>
Trace; c0106d2a <system_call+32/38>


