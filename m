Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130841AbRBWXdz>; Fri, 23 Feb 2001 18:33:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130867AbRBWXdq>; Fri, 23 Feb 2001 18:33:46 -0500
Received: from cc668399-a.ewndsr1.nj.home.com ([24.180.97.113]:50159 "EHLO
	eriador.mirkwood.net") by vger.kernel.org with ESMTP
	id <S130841AbRBWXdg>; Fri, 23 Feb 2001 18:33:36 -0500
Date: Fri, 23 Feb 2001 18:28:35 -0500 (EST)
From: pf-kernel@mirkwood.net
To: linux-kernel@vger.kernel.org
Subject: Kernel 2.4.2 - kernel BUG at apic.c:220!
Message-ID: <Pine.LNX.4.20.0102231825220.19730-100000@eriador.mirkwood.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

When running 2.4.2 on a pentium 4, I get the following during boot: (any
typos are due to me typing this in manually, off of what I see on the
monitor connected to the P4.  I've made sure the addresses are correct, at
least... note that this happens with noapic passed as an option to the
kernel as well)

CPU: After generic, caps: 3febf9ff 00000000 00000000 00000000
CPU: Common caps: 3febf9ff 00000000 00000000 00000000
CPU: Intel(R) Pentium(R) 4 CPU 1300MHz stepping 07
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
leaving PIC mode, enabling symmetric IO mode.
kernel BUG at apic.c:220!
invalid operand: 0000
CPU:	0
EIP:	0010:[<c02352e7>]
EFLAGS: 00010286
eax: 0000001a	ebx: f000ae7e	ecx: 00000001	edx: c021a108
esi: 0000007e	edi: c0105000	ebp: 0008e000	esp: c022ffc0
ds: 0018   es: 0018   ss: 0018
Process swapper (pid: 0, stackpage=c022f000)
Stack: c01e4725 c01e4932 000000dc 0000ff87 0009b800 c0113873 c02308f6 c01deec0
       0000ff87 0000ff87 0000ff87 0000ff87 0000ff87 c0267fc0 00010808 c0100191
Call Trace: [<c0113873>] [<c0100191>]

Code: 0f 0b 83 c4 0c b8 ff ff ff ff 8b 0d cc 14 28 c0 a3 e0 e0 ff
Kernel panic: Attempted to kill the idle task!
In idle task - not syncing


-----------------------------------
Unsolicited advertisments to this address are not welcome.

