Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263964AbTCWWQ2>; Sun, 23 Mar 2003 17:16:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263968AbTCWWQ2>; Sun, 23 Mar 2003 17:16:28 -0500
Received: from [212.91.234.4] ([212.91.234.4]:16138 "EHLO mail.taytron.net")
	by vger.kernel.org with ESMTP id <S263964AbTCWWQ1> convert rfc822-to-8bit;
	Sun, 23 Mar 2003 17:16:27 -0500
From: "Florian Schirmer" <jolt@tuxbox.org>
To: <linux-kernel@vger.kernel.org>
Subject: 2.5.65: devfs+initrd oops
Date: Sun, 23 Mar 2003 23:27:34 +0100
Message-ID: <002301c2f18b$674330c0$0201a8c0@space.taytron.net>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.4510
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1106
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

i get the following oops while booting 2.5.65 (vanilla and -ac3). More infos
availible on request.

Thanks,
   Florian

RAMDISK: Compressed image found at block 0
Unable to handle kernel NULL pointer dereference at virtual address 00000000
 printing eip:
c010975d
*pde = 00000000
Oops: 0002 [#1]
CPU:    0
EIP:    0060:[<c010975d>]    Not tainted
EFLAGS: 00000002
EIP is at __down+0x5d/0x100
eax: c02fc7c0   ebx: c02fc7b4   ecx: c114fe60   edx: 00000000
esi: c02fc7b4   edi: 00000286   ebp: c7ece040   esp: c114fe54
ds: 007b   es: 007b   ss: 0068
Process swapper (pid: 1, threadinfo=c114e000 task=c7ece040)
Stack: 00000001 c7ece040 c0118fb0 c02fc7c0 00000000 63736964 69642f73
00306373
       c02fc7b4 c02fc7a0
Call Trace:
 [<c0118fb0>] default_wake_function+0x0/0x20
 [<c0109978>] __down_failed+0x8/0xc
 [<c01a1ce1>] .text.lock.util+0x55/0x64
 [<c016ff4a>] devfs_remove_partitions+0x7a/0x80
 [<c01704aa>] del_gendisk+0x8a/0xd0
 [<c0225fa9>] initrd_release+0x49/0x80
 [<c01454c5>] __fput+0x35/0xe0
 [<c010a86f>] syscall_call+0x7/0xb
 [<c0143f18>] filp_close+0x98/0xb0
 [<c0143f89>] sys_close+0x59/0x80
 [<c010a86f>] syscall_call+0x7/0xb
 [<c010509d>] init+0x3d/0x1a0
 [<c0105060>] init+0x0/0x1a0
 [<c0108ae1>] kernel_thread_helper+0x5/0x14

Code: 89 0a 8b 46 04 8d 50 01 89 56 04 eb 3c 8d b6 00 00 00 00 c7
 <0>Kernel panic: Attempted to kill init!


