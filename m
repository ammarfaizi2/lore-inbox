Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317763AbSFLTEr>; Wed, 12 Jun 2002 15:04:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317764AbSFLTEq>; Wed, 12 Jun 2002 15:04:46 -0400
Received: from lachesis.dyadsodality.com ([208.255.179.10]:30088 "HELO
	atropos.dyadsodality.com") by vger.kernel.org with SMTP
	id <S317763AbSFLTEo>; Wed, 12 Jun 2002 15:04:44 -0400
From: "Zbigniew" <zbigniew@starpower.net>
To: <linux-kernel@vger.kernel.org>
Subject: 2.4.9-34smp  Oops on Redhat 7.1, offending process is nautilus
Date: Wed, 12 Jun 2002 15:04:39 -0400
Message-ID: <000b01c21244$0083d0f0$8a00a8c0@Tezcatlipoca>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.3416
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have a Redhat 7.1 SMP server that has been running fine for several
months.  As of late it has been hanging.  I've tried consulting my local
lug and the redhat-enigma list, but to no avail.
I'm very new to the list, so be gentle...  I tried to follow all the
rules.

Nothing has changed except for the occasional  up2date run.  No up2date
run occurred near May 29th, the first panic.  This machine's sole
purpose is to act as a file server for 6 windoze clients.  It runs Samba
and not much else.  I did upgrade the kernel from 2.4.9-31smp to
2.4.9-34smp after the panic's started happening, but as you can see,
they continue.  

Probably stating the obvious, but nautilus is in almost all the panic's.

-Patrick


Version:
Linux version 2.4.9-34smp (bhcompile@daffy.perf.redhat.com) (gcc version
2.96 20000731 (Red Hat Linux 7.2 2.96-108.1)) #1 SMP Sat Jun 1 06:15:25
EDT 2002

[root@server log]# cat /proc/cmdline
ro root=/dev/hda1

May 29 04:40:42 dsihq kernel: Unable to handle kernel paging request at
virtual address eeb0f440
May 29 04:40:42 dsihq kernel:  printing eip:
May 29 04:40:42 dsihq kernel: c014e31b
May 29 04:40:42 dsihq kernel: *pde = 00000000
May 29 04:40:42 dsihq kernel: Oops: 0000
May 29 04:40:42 dsihq kernel: Kernel 2.4.9-31smp
May 29 04:40:42 dsihq kernel: CPU:    0
May 29 04:40:42 dsihq kernel: EIP:    0010:[sys_poll+539/896]    Not
tainted
May 29 04:40:42 dsihq kernel: EIP:    0010:[<c014e31b>]    Not tainted
May 29 04:40:42 dsihq kernel: EFLAGS: 00010202
May 29 04:40:42 dsihq kernel: EIP is at sys_poll [kernel] 0x21b
May 29 04:40:42 dsihq kernel: eax: c9569740   ebx: 00000001   ecx:
00000000   edx: c9569740
May 29 04:40:42 dsihq kernel: esi: 0816f2bc   edi: c9569740   ebp:
00000001   esp: cb681f80
May 29 04:40:42 dsihq kernel: ds: 0018   es: 0018   ss: 0018
May 29 04:40:42 dsihq kernel: Process nautilus (pid: 1219,
stackpage=cb681000)
May 29 04:40:42 dsihq kernel: Stack: 0816f2bc 00000008 cb681fa8 cb681fc4
00000001 00000000 cb681fa8 c9569740
May 29 04:40:42 dsihq kernel:        fffffff2 00000000 00000000 00000000
cb680000 ffffffff 0816f2bc 0816f29c
May 29 04:40:42 dsihq kernel:        c010719b 0816f2bc 00000001 000000c9
ffffffff 0816f2bc 0816f29c 000000a8
May 29 04:40:42 dsihq kernel: Call Trace: [system_call+51/56]
system_call [kernel] 0x33
May 29 04:40:42 dsihq kernel: Call Trace: [<c010719b>] system_call
[kernel] 0x33
May 29 04:40:42 dsihq kernel:
May 29 04:40:42 dsihq kernel:
May 29 04:40:42 dsihq kernel: Code: 8b 1c b8 53 e8 cc fc 0c 00 83 c4 0c
85 c0 0f 85 de 00 00 00

May 30 02:10:14 dsihq kernel:  <1>Unable to handle kernel paging request
at virtual address ef9d6dc0
May 30 02:10:14 dsihq kernel:  printing eip:
May 30 02:10:14 dsihq kernel: c014e31b
May 30 02:10:14 dsihq kernel: *pde = 00000000
May 30 02:10:14 dsihq kernel: Oops: 0000
May 30 02:10:14 dsihq kernel: Kernel 2.4.9-31smp
May 30 02:10:14 dsihq kernel: CPU:    0
May 30 02:10:14 dsihq kernel: EIP:    0010:[sys_poll+539/896]    Not
tainted
May 30 02:10:14 dsihq kernel: EIP:    0010:[<c014e31b>]    Not tainted
May 30 02:10:14 dsihq kernel: EFLAGS: 00010206
May 30 02:10:14 dsihq kernel: EIP is at sys_poll [kernel] 0x21b
May 30 02:10:14 dsihq kernel: eax: c985e2c0   ebx: 0000000a   ecx:
00000000   edx: c985e2c0
May 30 02:10:14 dsihq kernel: esi: 08208128   edi: c985e2c0   ebp:
0000000a   esp: cbac5f80
May 30 02:10:14 dsihq kernel: ds: 0018   es: 0018   ss: 0018
May 30 02:10:14 dsihq kernel: Process nautilus (pid: 1187,
stackpage=cbac5000)
May 30 02:10:14 dsihq kernel: Stack: 08208128 00000050 cbac5fa8 ffffffe7
0000000a 00000000 cbac5fa8 c985e2c0
May 30 02:10:14 dsihq kernel:        fffffff2 00000000 00000000 00000000
cbac4000 0000000a 08208128 bfffe6e8
May 30 02:10:14 dsihq kernel:        c010719b 08208128 0000000a 00000033
0000000a 08208128 bfffe6e8 000000a8
May 30 02:10:14 dsihq kernel: Call Trace: [system_call+51/56]
system_call [kernel] 0x33
May 30 02:10:14 dsihq kernel: Call Trace: [<c010719b>] system_call
[kernel] 0x33
May 30 02:10:14 dsihq kernel:
May 30 02:10:14 dsihq kernel:
May 30 02:10:15 dsihq kernel: Code: 8b 1c b8 53 e8 cc fc 0c 00 83 c4 0c
85 c0 0f 85 de 00 00 00



Jun  2 14:34:49 dsihq kernel:  <1>Unable to handle kernel paging request
at virtual address 000a9300
Jun  2 14:34:49 dsihq kernel:  printing eip:
Jun  2 14:34:49 dsihq kernel: c012327f
Jun  2 14:34:49 dsihq kernel: *pde = 00000000
Jun  2 14:34:49 dsihq kernel: Oops: 0002
Jun  2 14:34:49 dsihq kernel: Kernel 2.4.9-31smp
Jun  2 14:34:49 dsihq kernel: CPU:    0
Jun  2 14:34:49 dsihq kernel: EIP:    0010:[add_timer+223/272]    Not
tainted
Jun  2 14:34:49 dsihq kernel: EIP:    0010:[<c012327f>]    Not tainted
Jun  2 14:34:49 dsihq kernel: EFLAGS: 00010002
Jun  2 14:34:49 dsihq kernel: EIP is at add_timer [kernel] 0xdf
Jun  2 14:34:49 dsihq kernel: eax: c03ee310   ebx: 00000000   ecx:
c036e0a0   edx: 000a92fc
Jun  2 14:34:49 dsihq kernel: esi: c7ce3f24   edi: 00000246   ebp:
c7ce3f4c   esp: c7ce3f10
Jun  2 14:34:49 dsihq kernel: ds: 0018   es: 0018   ss: 0018
Jun  2 14:34:49 dsihq kernel: Process multiload_apple (pid: 1214,
stackpage=c7ce3000)
Jun  2 14:34:49 dsihq kernel: Stack: c7ce3f24 02b03f4c 00000006 c01182c0
c7ce3f24 00000000 00000000 02b03f4c
Jun  2 14:34:49 dsihq kernel:        c7ce2000 c01181e0 c036e0a0 c7ce2000
c014e0a6 00000033 00000000 c7ce2000
Jun  2 14:34:49 dsihq kernel:        c014e0de 00000000 00000000 c3346000
00000006 00000000 00000006 c014e352
Jun  2 14:34:49 dsihq kernel: Call Trace: [schedule_timeout+128/176]
schedule_timeout [kernel] 0x80
Jun  2 14:34:49 dsihq kernel: Call Trace: [<c01182c0>] schedule_timeout
[kernel] 0x80
Jun  2 14:34:49 dsihq kernel: [process_timeout+0/96] process_timeout
[kernel] 0x0
Jun  2 14:34:49 dsihq kernel: [<c01181e0>] process_timeout [kernel] 0x0
Jun  2 14:34:49 dsihq kernel: [do_poll+134/224] do_pollfd [kernel] 0x106
Jun  2 14:34:49 dsihq kernel: [<c014e0a6>] do_pollfd [kernel] 0x106
Jun  2 14:34:49 dsihq kernel: [do_poll+190/224] do_pollfd [kernel] 0x13e
Jun  2 14:34:49 dsihq kernel: [<c014e0de>] do_pollfd [kernel] 0x13e
Jun  2 14:34:49 dsihq kernel: [sys_poll+594/896] sys_poll [kernel] 0x252
Jun  2 14:34:49 dsihq kernel: [<c014e352>] sys_poll [kernel] 0x252
Jun  2 14:34:49 dsihq kernel: [system_call+51/56] system_call [kernel]
0x33
Jun  2 14:34:49 dsihq kernel: [<c010719b>] system_call [kernel] 0x33
Jun  2 14:34:49 dsihq kernel:
Jun  2 14:34:49 dsihq kernel:
Jun  2 14:34:49 dsihq kernel: Code: 89 72 04 89 16 89 46 04 89 30 89 4e
14 c6 01 01 57 9d eb 16

Jun  6 21:15:27 dsihq kernel: Unable to handle kernel paging request at
virtual address f2dc9b45
Jun  6 21:15:27 dsihq kernel:  printing eip:
Jun  6 21:15:27 dsihq kernel: c012327f
Jun  6 21:15:27 dsihq kernel: *pde = 00000000
Jun  6 21:15:27 dsihq kernel: Oops: 0002
Jun  6 21:15:27 dsihq kernel: Kernel 2.4.9-31smp
Jun  6 21:15:27 dsihq kernel: CPU:    0
Jun  6 21:15:27 dsihq kernel: EIP:    0010:[add_timer+223/272]    Not
tainted
Jun  6 21:15:27 dsihq kernel: EIP:    0010:[<c012327f>]    Not tainted
Jun  6 21:15:27 dsihq kernel: EFLAGS: 00010002
Jun  6 21:15:27 dsihq kernel: EIP is at add_timer [kernel] 0xdf
Jun  6 21:15:27 dsihq kernel: eax: c03ee310   ebx: 00000000   ecx:
c036e0a0   edx: f2dc9b41
Jun  6 21:15:27 dsihq kernel: esi: c73aff24   edi: 00000246   ebp:
c73aff4c   esp: c73aff10
Jun  6 21:15:27 dsihq kernel: ds: 0018   es: 0018   ss: 0018
Jun  6 21:15:27 dsihq kernel: Process nautilus (pid: 1207,
stackpage=c73af000)
Jun  6 21:15:27 dsihq kernel: Stack: c73aff24 0057764c 00000001 c01182c0
c73aff24 00000000 00000000 0057764c
Jun  6 21:15:27 dsihq kernel:        c73ae000 c01181e0 c036e0a0 c73ae000
c014e0a6 000000c9 00000000 c73ae000
Jun  6 21:15:27 dsihq kernel:        c014e0de 00000000 00000000 cb4f7000
00000001 00000000 00000001 c014e352
Jun  6 21:15:27 dsihq kernel: Call Trace: [schedule_timeout+128/176]
schedule_timeout [kernel] 0x80
Jun  6 21:15:27 dsihq kernel: Call Trace: [<c01182c0>] schedule_timeout
[kernel] 0x80
Jun  6 21:15:27 dsihq kernel: [process_timeout+0/96] process_timeout
[kernel] 0x0
Jun  6 21:15:27 dsihq kernel: [<c01181e0>] process_timeout [kernel] 0x0
Jun  6 21:15:27 dsihq kernel: [do_poll+134/224] do_pollfd [kernel] 0x106
Jun  6 21:15:27 dsihq kernel: [<c014e0a6>] do_pollfd [kernel] 0x106
Jun  6 21:15:27 dsihq kernel: [do_poll+190/224] do_pollfd [kernel] 0x13e
Jun  6 21:15:27 dsihq kernel: [<c014e0de>] do_pollfd [kernel] 0x13e
Jun  6 21:15:27 dsihq kernel: [sys_poll+594/896] sys_poll [kernel] 0x252
Jun  6 21:15:27 dsihq kernel: [<c014e352>] sys_poll [kernel] 0x252
Jun  6 21:15:27 dsihq kernel: [system_call+51/56] system_call [kernel]
0x33
Jun  6 21:15:27 dsihq kernel: [<c010719b>] system_call [kernel] 0x33
Jun  6 21:15:27 dsihq kernel:
Jun  6 21:15:27 dsihq kernel:
Jun  6 21:15:27 dsihq kernel: Code: 89 72 04 89 16 89 46 04 89 30 89 4e
14 c6 01 01 57 9d eb 16


Jun 11 13:46:40 dsihq kernel: Unable to handle kernel paging request at
virtual address 05730004
Jun 11 13:46:40 dsihq kernel:  printing eip:
Jun 11 13:46:40 dsihq kernel: c012324f
Jun 11 13:46:40 dsihq kernel: *pde = 00000000
Jun 11 13:46:40 dsihq kernel: Oops: 0002
Jun 11 13:46:40 dsihq kernel: Kernel 2.4.9-34smp
Jun 11 13:46:40 dsihq kernel: CPU:    0
Jun 11 13:46:40 dsihq kernel: EIP:    0010:[add_timer+223/272]    Not
tainted
Jun 11 13:46:40 dsihq kernel: EIP:    0010:[<c012324f>]    Not tainted
Jun 11 13:46:40 dsihq kernel: EFLAGS: 00210002
Jun 11 13:46:40 dsihq kernel: EIP is at add_timer [kernel] 0xdf
Jun 11 13:46:40 dsihq kernel: eax: c03ee310   ebx: 00000000   ecx:
c036e0a0   edx: 05730000
Jun 11 13:46:40 dsihq kernel: esi: c5bedf24   edi: 00200246   ebp:
c5bedf4c   esp: c5bedf10
Jun 11 13:46:40 dsihq kernel: ds: 0018   es: 0018   ss: 0018
Jun 11 13:46:40 dsihq kernel: Process nautilus (pid: 1185,
stackpage=c5bed000)
Jun 11 13:46:40 dsihq kernel: Stack: c5bedf24 0020f54c 00000014 c0118290
c5bedf24 00000000 00000000 0020f54c
Jun 11 13:46:40 dsihq kernel:        c5bec000 c01181b0 c036e0a0 c5bec000
c014e3f6 000000ab 00000000 c5bec000
Jun 11 13:46:40 dsihq kernel:        c014e42e 00000000 00000000 c7deb000
00000014 00000000 00000014 c014e6a2
Jun 11 13:46:40 dsihq kernel: Call Trace: [schedule_timeout+128/176]
schedule_timeout [kernel] 0x80
Jun 11 13:46:40 dsihq kernel: Call Trace: [<c0118290>] schedule_timeout
[kernel] 0x80
Jun 11 13:46:40 dsihq kernel: [process_timeout+0/96] process_timeout
[kernel] 0x0
Jun 11 13:46:40 dsihq kernel: [<c01181b0>] process_timeout [kernel] 0x0
Jun 11 13:46:40 dsihq kernel: [do_poll+134/224] do_pollfd [kernel] 0x106
Jun 11 13:46:40 dsihq kernel: [<c014e3f6>] do_pollfd [kernel] 0x106
Jun 11 13:46:40 dsihq kernel: [do_poll+190/224] do_pollfd [kernel] 0x13e
Jun 11 13:46:40 dsihq kernel: [<c014e42e>] do_pollfd [kernel] 0x13e
Jun 11 13:46:40 dsihq kernel: [sys_poll+594/896] sys_poll [kernel] 0x252
Jun 11 13:46:40 dsihq kernel: [<c014e6a2>] sys_poll [kernel] 0x252
Jun 11 13:46:40 dsihq kernel: [system_call+51/56] system_call [kernel]
0x33
Jun 11 13:46:40 dsihq kernel: [<c01071ab>] system_call [kernel] 0x33
Jun 11 13:46:40 dsihq kernel:
Jun 11 13:46:40 dsihq kernel:
Jun 11 13:46:40 dsihq kernel: Code: 89 72 04 89 16 89 46 04 89 30 89 4e
14 c6 01 01 57 9d eb 16

