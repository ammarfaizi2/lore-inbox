Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129475AbQKGAJl>; Mon, 6 Nov 2000 19:09:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129802AbQKGAJc>; Mon, 6 Nov 2000 19:09:32 -0500
Received: from 24.68.3.210.on.wave.home.com ([24.68.3.210]:22002 "EHLO
	phlegmish.com") by vger.kernel.org with ESMTP id <S129475AbQKGAJS>;
	Mon, 6 Nov 2000 19:09:18 -0500
From: David Won <phlegm@home.com>
Date: Mon, 6 Nov 2000 19:05:16 -0500
X-Mailer: KMail [version 1.1.99]
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org
Subject: Another Oops with latest kernel
MIME-Version: 1.0
Message-Id: <00110619051600.01241@phlegmish.com>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Any hints on what caused this one?

Nov  6 18:28:53 phlegmish kernel: Unable to handle kernel paging request at 
virt
ual address 00009cca
Nov  6 18:28:53 phlegmish kernel: c012cdd6
Nov  6 18:28:53 phlegmish kernel: *pde = 00000000
Nov  6 18:28:53 phlegmish kernel: Oops: 0000
Nov  6 18:28:53 phlegmish kernel: CPU:    0
Nov  6 18:28:53 phlegmish kernel: EIP:    0010:[<c012cdd6>]
Nov  6 18:28:53 phlegmish kernel: EFLAGS: 00010202
Nov  6 18:28:53 phlegmish kernel: eax: 00009cb6   ebx: 00009cb6   ecx: 
00009cb6 
  edx: 00000400
Nov  6 18:28:53 phlegmish kernel: esi: 00000000   edi: c2d7ba80   ebp: 
00000001 
  esp: c1743f80
Nov  6 18:28:53 phlegmish kernel: ds: 0018   es: 0018   ss: 0018
Nov  6 18:28:53 phlegmish kernel: Process netscape-commun (pid: 889, 
stackpage=c
1743000)
Nov  6 18:28:53 phlegmish kernel: Stack: 069e7fff 00000000 c0118c5a 00009cb6 
c2d
7ba80 c4e4dc80 c1742000 00000000 
Nov  6 18:28:53 phlegmish kernel:        bfffe308 c011925a c2d7ba80 c1742000 
403
148ec 00000000 c01193a2 00000000 
Nov  6 18:28:53 phlegmish kernel:        c010a407 00000000 00000000 40315740 
403
148ec 00000000 bfffe308 00000001 
Nov  6 18:28:53 phlegmish kernel: Call Trace: [<c0118c5a>] [<c011925a>] 
[<c01193
a2>] [<c010a407>] 
Nov  6 18:28:53 phlegmish kernel: Code: 8b 43 14 85 c0 75 13 68 c2 4d 22 c0 
e8 3
5 9f fe ff 31 c0 83 

>>EIP; c012cdd6 <filp_close+6/64>   <=====
Trace; c0118c5a <put_module_symbol+28a/2f8>
Trace; c011925a <exit_mm+31e/cdc>
Trace; c01193a2 <exit_mm+466/cdc>
Trace; c010a407 <__rwsem_wake+1073/2264>
Code;  c012cdd6 <filp_close+6/64>
00000000 <_EIP>:
Code;  c012cdd6 <filp_close+6/64>   <=====
   0:   8b 43 14                  mov    0x14(%ebx),%eax   <=====
Code;  c012cdd9 <filp_close+9/64>
   3:   85 c0                     test   %eax,%eax
Code;  c012cddb <filp_close+b/64>
   5:   75 13                     jne    1a <_EIP+0x1a> c012cdf0 
<filp_close+20/
64>
Code;  c012cddd <filp_close+d/64>
   7:   68 c2 4d 22 c0            push   $0xc0224dc2
Code;  c012cde2 <filp_close+12/64>
   c:   e8 35 9f fe ff            call   fffe9f46 <_EIP+0xfffe9f46> c0116d1c 
<pr
intk+0/180>
Code;  c012cde7 <filp_close+17/64>
  11:   31 c0                     xor    %eax,%eax
Code;  c012cde9 <filp_close+19/64>
  13:   83 00 00                  addl   $0x0,(%eax)


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
