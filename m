Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316600AbSFDMdw>; Tue, 4 Jun 2002 08:33:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316603AbSFDMdv>; Tue, 4 Jun 2002 08:33:51 -0400
Received: from smtp-send.myrealbox.com ([192.108.102.143]:32023 "EHLO
	smtp-send.myrealbox.com") by vger.kernel.org with ESMTP
	id <S316600AbSFDMdt>; Tue, 4 Jun 2002 08:33:49 -0400
To: linux-kernel@vger.kernel.org
From: Jonathan Hudson <jonathan@daria.co.uk>
Mime-Version: 1.0
X-Newsreader: knews 1.0b.1
x-no-productlinks: yes
Subject: 2.4.19-pre10 Oops at startup
X-Newsgroups: fa.linux.kernel
Content-Type: text/plain; charset=iso-8859-1
NNTP-Posting-Host: daria.co.uk
Message-ID: <b0b.3cfcb3a9.a0d93@trespassersw.daria.co.uk>
Date: Tue, 04 Jun 2002 12:33:45 GMT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

2.4.19-pre10 Oops very early on at startup on my Duron 800 box. It
runs fine on a couple of Celeron boxen. The following occurs
immediately after printing:

Mount-cache hash table entries: 8192 (order: 4, 65536 bytes)

ksymoops 2.4.4 on i686 2.4.19-pre9-ac2.  Options used
     -v /usr/src/linux/vmlinux (specified)
     -K (specified)
     -L (specified)
     -O (specified)
     -m /usr/src/linux/System.map (specified)

Unable to handle kernel NULL pointer dereference at virtual address 00000012
c0149511
*pde = 00000000
Oops: 0002
CPU:    0
EIP:    0010:[<c0149511>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010206
eax: 00000003   ebx: 00000012   ecx: c0267500   edx: c15890c0
esi: 00000012   edi: 00000000   ebp: 0008e000   esp: c0279f98
ds: 0018   es: 0018   ss: 0018
Process    (pid: 0, stackpage=c0279000)
Stack: 0001fff0 c158e140 00000000 00000012 c0281fc0 00000012 000001f0 c023f850
       00000000 0001fff0 00098700 c0105000 c0281cbb 0001fff0 00000080 00000040
       00002000 00000000 00000000 00000000 c027a69f 0001fff0 c0293ae0 00000000
Call Trace: [<c0105000>]
Code: ff 0b 0f 94 c0 84 c0 0f 84 ae 00 00 00 8d 73 18 39 73 18 74

>>EIP; c0149511 <dput+11/140>   <=====
Trace; c0105000 <_stext+0/0>
Code;  c0149511 <dput+11/140>
00000000 <_EIP>:
Code;  c0149511 <dput+11/140>   <=====
   0:   ff 0b                     decl   (%ebx)   <=====
Code;  c0149513 <dput+13/140>
   2:   0f 94 c0                  sete   %al
Code;  c0149516 <dput+16/140>
   5:   84 c0                     test   %al,%al
Code;  c0149518 <dput+18/140>
   7:   0f 84 ae 00 00 00         je     bb <_EIP+0xbb> c01495cc <dput+cc/140>
Code;  c014951e <dput+1e/140>
   d:   8d 73 18                  lea    0x18(%ebx),%esi
Code;  c0149521 <dput+21/140>
  10:   39 73 18                  cmp    %esi,0x18(%ebx)
Code;  c0149524 <dput+24/140>
  13:   74 00                     je     15 <_EIP+0x15> c0149526 <dput+26/140>

 <0>Kernel panic: Attempted to kill the idle task!

