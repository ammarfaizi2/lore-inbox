Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129325AbQKBUZ0>; Thu, 2 Nov 2000 15:25:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129379AbQKBUZP>; Thu, 2 Nov 2000 15:25:15 -0500
Received: from mail45-s.fg.online.no ([148.122.161.45]:12765 "EHLO
	mail45.fg.online.no") by vger.kernel.org with ESMTP
	id <S129325AbQKBUZL>; Thu, 2 Nov 2000 15:25:11 -0500
Message-ID: <3A01BF94.B139AA34@iname.com>
Date: Thu, 02 Nov 2000 20:25:08 +0100
From: Håvard Garnes <hhg@iname.com>
X-Mailer: Mozilla 4.74 [en] (X11; U; Linux 2.4.0-test10 i686)
X-Accept-Language: no, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Oops when loading 3c509-module in test10
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This occurs when the 3c509-module is being loaded at startup, and in
/proc/modules it is listed as (initialising). It it worth mentioning
that I have two 3c509-cards in my computer. This worked in test8.





Unable to handle kernel NULL pointer dereference at virtual address
00000070
c6d485a5
*pde = 00000000
Oops: 0002
CPU:    0
EIP:    0010:[<c6d485a5>]
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010282
eax: 9c24a000   ebx: 00000004   ecx: 6b5f6768   edx: 00000070
esi: 00000006   edi: 00000003   ebp: 00000220   esp: c54eff08
ds: 0018   es: 0018   ss: 0018
Process modprobe (pid: 348, stackpage=c54ef000)
Stack: 00000000 00000000 c6d4804e ffffffea 00000070 c54eff3c c54eff2c
00000005 
       00ff0000 c6d4804e ffffffea c1044010 c039a280 9c24a000 ffff6edf
c6d49295 
       00000000 c6d48000 00000000 c011b1d8 c54ee000 0804b17c 08061798
bfffe118 
Call Trace: [<c6d4804e>] [<c6d4804e>] [<c6d49295>] [<c6d48000>]
[<c011b1d8>] [<c6d48048>] [<c6d0f000>] 
       [<c6d48048>] [<c010a7cf>] [<c030002b>] 
Code: 89 02 8b 44 24 38 66 89 42 04 8b 4c 24 40 89 69 20 8b 44 24 

>>EIP; c6d485a5 <[3c509].text.start+545/6e0>   <=====
Trace; c6d4804e <[hisax].bss.end+15ab/15bd>
Trace; c6d4804e <[hisax].bss.end+15ab/15bd>
Trace; c6d49295 <[3c509]init_module+59/74>
Trace; c6d48000 <[hisax].bss.end+155d/15bd>
Trace; c011b1d8 <sys_init_module+3f8/4a0>
Trace; c6d48048 <[hisax].bss.end+15a5/15bd>
Trace; c6d0f000 <[isdn].bss.end+19b79/19bd9>
Trace; c6d48048 <[hisax].bss.end+15a5/15bd>
Trace; c010a7cf <system_call+33/38>
Trace; c030002b <stext_lock+809f/aff4>
Code;  c6d485a5 <[3c509].text.start+545/6e0>
00000000 <_EIP>:
Code;  c6d485a5 <[3c509].text.start+545/6e0>   <=====
   0:   89 02                     mov    %eax,(%edx)   <=====
Code;  c6d485a7 <[3c509].text.start+547/6e0>
   2:   8b 44 24 38               mov    0x38(%esp,1),%eax
Code;  c6d485ab <[3c509].text.start+54b/6e0>
   6:   66 89 42 04               mov    %ax,0x4(%edx)
Code;  c6d485af <[3c509].text.start+54f/6e0>
   a:   8b 4c 24 40               mov    0x40(%esp,1),%ecx
Code;  c6d485b3 <[3c509].text.start+553/6e0>
   e:   89 69 20                  mov    %ebp,0x20(%ecx)
Code;  c6d485b6 <[3c509].text.start+556/6e0>
  11:   8b 44 24 00               mov    0x0(%esp,1),%eax


1 warning issued.  Results may not be reliable.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
