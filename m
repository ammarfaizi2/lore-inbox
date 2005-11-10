Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750975AbVKJOfb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750975AbVKJOfb (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Nov 2005 09:35:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750984AbVKJOfb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Nov 2005 09:35:31 -0500
Received: from sccrmhc14.comcast.net ([204.127.202.59]:41602 "EHLO
	sccrmhc14.comcast.net") by vger.kernel.org with ESMTP
	id S1750975AbVKJOfa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Nov 2005 09:35:30 -0500
Date: Thu, 10 Nov 2005 08:35:25 -0600
From: Lee <linuxtwidler@gmail.com>
To: linux-kernel@vger.kernel.org, pageexec@freemail.hu
Subject: 4k stack overflow and stack traces
Message-ID: <20051110083525.6cfe6f35@localhost>
Reply-To: linuxtwidler@gmail.com
X-Mailer: Sylpheed-Claws 1.0.5 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary=Multipart_Thu__10_Nov_2005_08_35_25_-0600_McYMcyqit6D3EThq
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Multipart_Thu__10_Nov_2005_08_35_25_-0600_McYMcyqit6D3EThq
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hello,

When I am running with 4k stacks enabled, my kernel completely locks up whe=
n I get a high load.

When I am running with 4k stacks disabled, my kernel runs stabely.

=46rom the few kernel output I can get on the serial port, I see some type of=
 recursive kernel fault.

Is there a way to get a stacktrace in this case so we can identify which ex=
ecution path is causing this stack overflos ?

Attached is the output form the serial port which shows some type of recurs=
ive kernel fault.

Thanks,
Lee



--=20
Lee
linuxtwidler@gmail.com

 08:31:20 up 3 days, 13:41,  0 users,  load average: 0.47, 0.34, 0.19

--Multipart_Thu__10_Nov_2005_08_35_25_-0600_McYMcyqit6D3EThq
Content-Type: text/plain; name=kernel-2.6.13-gentoo-r3-crash.txt
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename=kernel-2.6.13-gentoo-r3-crash.txt

Oops: 0000 [#1]
SMP DEBUG_PAGEALLOC
Modules linked in:
CPU:    1
EIP:    0060:[<c011816b>]    Not tainted VLI
EFLAGS: 00010082   (2.6.13-gentoo-r3-20051108-1407)
EIP is at do_page_fault+0xcb/0x6bf
eax: f7f08000   ebx: 0000000b   ecx: 0000000d   edx: 00000000
esi: 0000000e   edi: c04689a2   ebp: f7f08110   esp: f7f08040
ds: 007b   es: 007b   ss: 0068
Process khubd (pid: 16, threadinfo=f7f07000 task=f7f06ac0)
Stack: c05b904c 0000000d f7f08064 00000000 00000000 0000008c 00000000 00000000
       f7f08118 f7f08118 c04689a2 00000000 0000000e 0000000b 00000000 00000000
       00000000 00000000 00000000 00030001 00000000 00000000 00000000 00000000
Call Trace:
 =======================
Unable to handle kernel paging request at virtual address fffff030
 printing eip:
c0103e83
*pde = 0065e067
Oops: 0000 [#2]
SMP DEBUG_PAGEALLOC
Modules linked in:
CPU:    1
EIP:    0060:[<c0103e83>]    Not tainted VLI
EFLAGS: 00010083   (2.6.13-gentoo-r3-20051108-1407)
EIP is at show_trace+0x83/0xc0
eax: 0000001c   ebx: f7f07e94   ecx: fffffd32   edx: 00000001
esi: f7f07e94   edi: fffff000   ebp: f7f07e94   esp: f7f07e80
ds: 007b   es: 007b   ss: 0068
Process khubd (pid: 16, threadinfo=f7f07000 task=f7f06ac0)
Stack: c0466ce5 f7f07e94 f7f080a0 00000018 00000000 f7f07eb0 c0103f3f 00000000
       f7f08040 f7f07000 f7f0800c 00000000 f7f07ee8 c01040f0 00000000 f7f08040
       00000010 f7f07000 f7f06ac0 00010082 c04cf322 00000068 00000001 f7f07000
Call Trace:
 [<c0103f3f>] show_stack+0x7f/0xa0
 [<c01040f0>] show_registers+0x160/0x1d0
 [<c0104320>] die+0x100/0x180
 [<c0118434>] do_page_fault+0x394/0x6bf
 [<c0103b63>] error_code+0x4f/0x54
 [<c0103f3f>] show_stack+0x7f/0xa0
 [<c01040f0>] show_registers+0x160/0x1d0
 [<c0104320>] die+0x100/0x180
 [<c0118434>] do_page_fault+0x394/0x6bf
Code: 89 5c 24 04 e8 9f d1 01 00 89 5c 24 04 c7 04 24 7a fb 48 c0 e8 1f aa 03 00 c7 04 24 23 eb 46 c0 e8 83 d1 01 00 8b 36 eb bf 89 f3 <8b> 77 30 85 f6 74 0e c7 04 24 e5 6c 46 c0 e8 6a d1 01 00 eb 92
 eip: c012b43b
------------[ cut here ]------------
kernel BUG at include/asm/spinlock.h:136!
invalid operand: 0000 [#3]
SMP DEBUG_PAGEALLOC
Modules linked in:
CPU:    1
EIP:    0060:[<c044f3dc>]    Not tainted VLI
EFLAGS: 00010096   (2.6.13-gentoo-r3-20051108-1407)
EIP is at _spin_lock+0x3c/0x50
eax: 0000000e   ebx: f7f08ff0   ecx: c04d1cec   edx: 00000086
esi: f7f06ac0   edi: f7f08ff0   ebp: f7f07c80   esp: f7f07c74
ds: 007b   es: 007b   ss: 0068
Process khubd (pid: 16, threadinfo=f7f07000 task=f7f06ac0)
Stack: c046955d c012b43b f7f09ea0 f7f07c9c c012b43b f7f07c9c c019b3d2 f7f06ac0
       00000020 f7f06f94 f7f07cc0 c01224d9 f7f06ac0 00000001 f2b24f68 f7f07cd0
       f7f07ce8 00000020 c1da8ac0 f7f07cfc c01234a7 f7f06ac0 00000011 c01440cc
Call Trace:
 [<c0103f3f>] show_stack+0x7f/0xa0
 [<c01040f0>] show_registers+0x160/0x1d0
 [<c0104320>] die+0x100/0x180
 [<c0104455>] do_trap+0xb5/0xc0
 [<c010470c>] do_invalid_op+0xbc/0xd0
 [<c0103b63>] error_code+0x4f/0x54
 [<c012b43b>] __exit_signal+0x3b/0x180
 [<c01224d9>] release_task+0x69/0x160
 [<c01234a7>] exit_notify+0x3c7/0x8d0
 [<c0123baf>] do_exit+0x1ff/0x3f0
 [<c01043a0>] do_trap+0x0/0xc0
 [<c0118434>] do_page_fault+0x394/0x6bf
 [<c0103b63>] error_code+0x4f/0x54
 [<c0103f3f>] show_stack+0x7f/0xa0
 [<c01040f0>] show_registers+0x160/0x1d0
 [<c0104320>] die+0x100/0x180
 [<c0118434>] do_page_fault+0x394/0x6bf
Code: de 75 15 f0 fe 0b 79 09 f3 90 80 3b 00 7e f9 eb f2 8b 5d fc 89 ec 5d c3 c7 04 24 5d 95 46 c0 8b 45 04 89 44 24 04 e8 24 1c cd ff <0f> 0b 88 00 b5 8d 46 c0 eb ce 8d 76 00 8d bc 27 00 00 00 00 81
 <1>Fixing recursive fault but reboot is needed!
Unable to handle kernel NULL pointer dereference at virtual address 00000000
 printing eip:
c0119cb6
*pde = 00000000
Oops: 0002 [#4]
SMP DEBUG_PAGEALLOC
Modules linked in:
CPU:    1
EIP:    0060:[<c0119cb6>]    Not tainted VLI
EFLAGS: 00010086   (2.6.13-gentoo-r3-20051108-1407)
EIP is at dequeue_task+0x16/0x50
eax: 00000000   ebx: f7f06ae0   ecx: f7f06ac0   edx: f7f06ac0
esi: 00000000   edi: f7f06ac0   ebp: f7f07a58   esp: f7f07a50
ds: 007b   es: 007b   ss: 0068
Process khubd (pid: 16, threadinfo=f7f07000 task=f7f06ac0)
Stack: f7f06ac0 c1c13400 f7f07a6c c0119ff1 f7f06ac0 00000000 c1c13400 f7f07adc
       c044d5d7 f7f06ac0 c1c13400 00000286 f7f07a7c f7f06ac0 00000001 00000000
       f7f07ab0 c012a4e9 f7f06ac0 00000046 c05b28cc 00000001 c1c13400 00000246
Call Trace:
 [<c0103f3f>] show_stack+0x7f/0xa0
 [<c01040f0>] show_registers+0x160/0x1d0
 [<c0104320>] die+0x100/0x180
 [<c0118434>] do_page_fault+0x394/0x6bf
 [<c0103b63>] error_code+0x4f/0x54
 [<c0119ff1>] deactivate_task+0x21/0x30
 [<c044d5d7>] schedule+0x157/0xd90
 [<c0123d21>] do_exit+0x371/0x3f0
 [<c01043a0>] do_trap+0x0/0xc0
 [<c0104455>] do_trap+0xb5/0xc0
 [<c010470c>] do_invalid_op+0xbc/0xd0
 [<c0103b63>] error_code+0x4f/0x54
 [<c012b43b>] __exit_signal+0x3b/0x180
 [<c01224d9>] release_task+0x69/0x160
 [<c01234a7>] exit_notify+0x3c7/0x8d0
 [<c0123baf>] do_exit+0x1ff/0x3f0
 [<c01043a0>] do_trap+0x0/0xc0
 [<c0118434>] do_page_fault+0x394/0x6bf
 [<c0103b63>] error_code+0x4f/0x54
 [<c0103f3f>] show_stack+0x7f/0xa0
 [<c01040f0>] show_registers+0x160/0x1d0
 [<c0104320>] die+0x100/0x180
 [<c0118434>] do_page_fault+0x394/0x6bf
Code: 8b 7d fc 89 ec 5d c3 89 1c 24 e8 56 6a 03 00 eb e7 8d 74 26 00 55 89 e5 83 ec 08 89 74 24 04 8b 55 08 8b 75 0c 89 1c 24 8d 5a 20 <ff> 0e 8b 42 20 8b 4b 04 89 01 89 48 04 c7 43 04 00 02 20 00 8b
 
--Multipart_Thu__10_Nov_2005_08_35_25_-0600_McYMcyqit6D3EThq--
