Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266116AbTBCHwl>; Mon, 3 Feb 2003 02:52:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266120AbTBCHwl>; Mon, 3 Feb 2003 02:52:41 -0500
Received: from mailout02.sul.t-online.com ([194.25.134.17]:14747 "EHLO
	mailout02.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S266116AbTBCHwf>; Mon, 3 Feb 2003 02:52:35 -0500
Message-ID: <000901c2cb5a$8921bce0$6800a8c0@silicea>
From: "Robert Oschwald" <robertoschwald@yahoo.de>
To: <linux-kernel@vger.kernel.org>
Subject: Oops after 60 days uptime
Date: Mon, 3 Feb 2003 09:02:02 +0100
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1106
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1106
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi folks,

we got a strange problem.
After approx 60 days uptime, we get an oops.

Seems it is in low memory...

Any ideas?


Robert

Here it is:

mymachine:/var/log # ksymoops < messages
ksymoops 2.4.3 on i686 2.4.18-4GB.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.18-4GB/ (default)
     -m /boot/System.map-2.4.18-4GB (default)

Feb  3 06:24:13 mymachine kernel: Unable to handle kernel NULL pointer
dereference at
 virtual address 000001c4
Feb  3 06:24:13 mymachine kernel: c0130ac0
Feb  3 06:24:13 mymachine kernel: *pde = 00000000
Feb  3 06:24:13 mymachine kernel: Oops: 0002
Feb  3 06:24:13 mymachine kernel: CPU:    0
Feb  3 06:24:13 mymachine kernel: EIP:    0010:[rmqueue+212/668]    Not
tainted
Feb  3 06:24:13 mymachine kernel: EFLAGS: 00010016
Feb  3 06:24:13 mymachine kernel: eax: 00000e27   ebx: 0000389c   ecx:
c02b1618   edx
: 00000000
Feb  3 06:24:13 mymachine kernel: esi: c10d9d60   edi: 00000001   ebp:
c02b15d0   esp
: ce6a7efc
Feb  3 06:24:13 mymachine kernel: ds: 0018   es: 0018   ss: 0018
Feb  3 06:24:13 mymachine kernel: Process sshd (pid: 537,
stackpage=ce6a7000)
Feb  3 06:24:13 mymachine kernel: Stack: c02b1774 00000001 00000001 00000002
ce6a7f74
 c19391c0 00000296 c02b1618
Feb  3 06:24:13 mymachine kernel:        00000001 c02b15d0 c0130eda 000001f0
00000000
 00000001 00000011 c02b15d0
Feb  3 06:24:13 mymachine kernel:        c63705c0 ce6a7f7f 0000000c c02b15d0
c02b1770
 00000005 c0131103 000001f0
Feb  3 06:24:13 mymachine kernel: Call Trace: [_wrapped_alloc_pages+110/648]
[__alloc
_pages+15/140] [__get_free_pages+29/44] [do_fork+95/1936] [sys_pipe+21/88]
Feb  3 06:24:13 mymachine kernel: Code: 0f bb 02 8b 4c 24 20 8b 6c 24 24 b8
01 00 00
00 d3 e0 29 45
Using defaults from ksymoops -t elf32-i386 -a i386

Code;  00000000 Before first symbol
00000000 <_EIP>:
Code;  00000000 Before first symbol
   0:   0f bb 02                  btc    %eax,(%edx)
Code;  00000002 Before first symbol
   3:   8b 4c 24 20               mov    0x20(%esp,1),%ecx
Code;  00000006 Before first symbol
   7:   8b 6c 24 24               mov    0x24(%esp,1),%ebp
Code;  0000000a Before first symbol
   b:   b8 01 00 00 00            mov    $0x1,%eax
Code;  00000010 Before first symbol
  10:   d3 e0                     shl    %cl,%eax
Code;  00000012 Before first symbol
  12:   29 45 00                  sub    %eax,0x0(%ebp)

Feb  3 06:24:13 mymachine kernel:  <1>Unable to handle kernel NULL pointer
dereferenc
e at virtual address 000006b4
Feb  3 06:24:13 mymachine kernel: c0130946
Feb  3 06:24:13 mymachine kernel: *pde = 00000000
Feb  3 06:24:13 mymachine kernel: Oops: 0002
Feb  3 06:24:13 mymachine kernel: CPU:    0
Feb  3 06:24:13 mymachine kernel: EIP:    0010:[__free_pages_ok+758/924]
Not taint
ed
Feb  3 06:24:13 mymachine kernel: EFLAGS: 00010083
Feb  3 06:24:13 mymachine kernel: eax: c02b1618   ebx: 0000e6a1   ecx:
000035a8   edx
: 00000000
Feb  3 06:24:13 mymachine kernel: esi: 00001000   edi: 0000d6a0   ebp:
c12b3e50   esp
: ce6a7d04
Feb  3 06:24:13 mymachine kernel: ds: 0018   es: 0018   ss: 0018
Feb  3 06:24:13 mymachine kernel: Process sshd (pid: 537,
stackpage=ce6a7000)
Feb  3 06:24:13 mymachine kernel: Stack: c03022a0 c12b3e20 00060400 00060400
0001e7f0
 00001000 c12b3e20 c02b15d0
Feb  3 06:24:13 mymachine kernel:        c1030020 c02b1618 00000216 fffffffe
000035a8
 c0131201 c0131e33 00005000
Feb  3 06:24:13 mymachine kernel:        ce6a490c 00007000 c012571a 00060400
ce00d620
 c185c800 4023e000 00007000
Feb  3 06:24:13 mymachine kernel: Call Trace: [__free_pages+29/32]
[free_swap_and_cac
he+99/104] [zap_page_range+506/732] [exit_mmap+181/280] [mmput+57/80]
Feb  3 06:24:13 mymachine kernel: Code: 0f bb 0a 19 c0 85 c0 0f 85 cd fe ff
ff 8b 4c
24 24 8d 04 7f

Code;  00000000 Before first symbol
00000000 <_EIP>:
Code;  00000000 Before first symbol
   0:   0f bb 0a                  btc    %ecx,(%edx)
Code;  00000002 Before first symbol
   3:   19 c0                     sbb    %eax,%eax
Code;  00000004 Before first symbol
   5:   85 c0                     test   %eax,%eax
Code;  00000006 Before first symbol
   7:   0f 85 cd fe ff ff         jne    fffffeda <_EIP+0xfffffeda> fffffeda
<EN
D_OF_CODE+31b012bc/????>
Code;  0000000c Before first symbol
   d:   8b 4c 24 24               mov    0x24(%esp,1),%ecx
Code;  00000010 Before first symbol
  11:   8d 04 7f                  lea    (%edi,%edi,2),%eax

Feb  3 06:24:13 mymachine kernel:  <1>Unable to handle kernel NULL pointer
dereferenc
e at virtual address 000006b4
Feb  3 06:24:13 mymachine kernel: c0130946
Feb  3 06:24:13 mymachine kernel: *pde = 00000000
Feb  3 06:24:13 mymachine kernel: Oops: 0002
Feb  3 06:24:13 mymachine kernel: CPU:    0
Feb  3 06:24:13 mymachine kernel: EIP:    0010:[__free_pages_ok+758/924]
Not taint
ed
Feb  3 06:24:13 mymachine kernel: EFLAGS: 00010083
Feb  3 06:24:13 mymachine kernel: eax: c02b1618   ebx: 00283f20   ecx:
000035a9   edx
: 00000000
Feb  3 06:24:13 mymachine kernel: esi: 00000001   edi: 0000d6a6   ebp:
c15f1f80   esp
: c15f1f3c
Feb  3 06:24:13 mymachine kernel: ds: 0018   es: 0018   ss: 0018
Feb  3 06:24:13 mymachine kernel: Process init (pid: 1, stackpage=c15f1000)
Feb  3 06:24:13 mymachine kernel: Stack: ce6a6000 00000219 c15f0000 c15f1f80
00000219
 00000000 0000000b c02b15d0
Feb  3 06:24:13 mymachine kernel:        c1030020 c02b1618 00000217 fffffffe
000035a9
 c0131201 c0131221 c011b446
Feb  3 06:24:13 mymachine kernel:        ce6a6000 bffff520 c011c046 ce6a6000
c15f0000
 00000000 bffff520 bffff4e4
Feb  3 06:24:13 mymachine kernel: Call Trace: [__free_pages+29/32]
[free_pages+29/32]
 [release_task+342/364] [sys_wait4+790/928] [system_call+51/64]
Feb  3 06:24:13 mymachine kernel: Code: 0f bb 0a 19 c0 85 c0 0f 85 cd fe ff
ff 8b 4c
24 24 8d 04 7f

Code;  00000000 Before first symbol
00000000 <_EIP>:
Code;  00000000 Before first symbol
   0:   0f bb 0a                  btc    %ecx,(%edx)
Code;  00000002 Before first symbol
   3:   19 c0                     sbb    %eax,%eax
Code;  00000004 Before first symbol
   5:   85 c0                     test   %eax,%eax
Code;  00000006 Before first symbol
   7:   0f 85 cd fe ff ff         jne    fffffeda <_EIP+0xfffffeda> fffffeda
<EN
D_OF_CODE+31b012bc/????>
Code;  0000000c Before first symbol
   d:   8b 4c 24 24               mov    0x24(%esp,1),%ecx
Code;  00000010 Before first symbol
  11:   8d 04 7f                  lea    (%edi,%edi,2),%eax

Feb  3 06:24:13 mymachine kernel:  <0>Kernel panic: Attempted to kill init!
Feb  3 08:33:34 mymachine kernel: 8139too Fast Ethernet driver 0.9.24

1 warning issued.  Results may not be reliable.
mymachine:/var/log #

