Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290871AbSASCZf>; Fri, 18 Jan 2002 21:25:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290900AbSASCZ0>; Fri, 18 Jan 2002 21:25:26 -0500
Received: from kwur.wustl.edu ([128.252.23.167]:6528 "EHLO kwur.wustl.edu")
	by vger.kernel.org with ESMTP id <S290871AbSASCZH>;
	Fri, 18 Jan 2002 21:25:07 -0500
Subject: [OOPS] 2.4.18-pre3+preempt, AthlonXP/KT266A
From: Tom Joseph <ttjoseph@cs.wustl.edu>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0.1 
Date: 18 Jan 2002 20:25:17 -0600
Message-Id: <1011407117.25086.12.camel@idiot>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The below oops seems to happen randomly while in XFree86 (4.1.0),
generally after several hours of X running.  I have a VIA KT266A
motherboard + Athlon XP.  I'm running Debian sid with 2.4.18-pre3 +
Robert Love's preempt patch.

I'd be happy to provide any other pertinent information.  Please CC me
in replies as I'm not subscribed.  Thanks!

--Tom Joseph

Unable to handle kernel paging request at virtual address ff9ebfd8
c013613c
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0010:[<c013613c>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010283
eax: cb4bb9c0   ebx: cb4bb9c0   ecx: cadd0000   edx: cd562978
esi: c7dbd000   edi: ff335062   ebp: ff9ebfd0   esp: cadd1f20
ds: 0018   es: 0018   ss: 0018
Process XFree86 (pid: 18196, stackpage=cadd1000)
Stack: c7dbd038 c7dbd000 c7dbd008 cadd1f74 c0143c3b 00000001 c3b97a40
00000304 
       c0143f9b cadd1f6c 00000020 00000008 cfaf5740 00000001 00000002
cadd0000 
       00002e9e 00000022 00000000 00000000 c7dbd000 00000000 c014431a
00000022 
Call Trace: [<c0143c3b>] [<c0143f9b>] [<c014431a>] [<c0106e4b>] 
Code: 8b 75 08 ff 4b 14 0f 94 c0 84 c0 0f 84 cb 00 00 00 53 e8 4d 

>>EIP; c013613c <fput+c/f0>   <=====
Trace; c0143c3a <poll_freewait+2a/50>
Trace; c0143f9a <do_select+1fa/220>
Trace; c014431a <sys_select+32a/470>
Trace; c0106e4a <system_call+32/38>
Code;  c013613c <fput+c/f0>
00000000 <_EIP>:
Code;  c013613c <fput+c/f0>   <=====
   0:   8b 75 08                  mov    0x8(%ebp),%esi   <=====
Code;  c013613e <fput+e/f0>
   3:   ff 4b 14                  decl   0x14(%ebx)
Code;  c0136142 <fput+12/f0>
   6:   0f 94 c0                  sete   %al
Code;  c0136144 <fput+14/f0>
   9:   84 c0                     test   %al,%al
Code;  c0136146 <fput+16/f0>
   b:   0f 84 cb 00 00 00         je     dc <_EIP+0xdc> c0136218
<fput+e8/f0>
Code;  c013614c <fput+1c/f0>
  11:   53                        push   %ebx
Code;  c013614e <fput+1e/f0>
  12:   e8 4d 00 00 00            call   64 <_EIP+0x64> c01361a0
<fput+70/f0>




