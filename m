Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264779AbSLGVfW>; Sat, 7 Dec 2002 16:35:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264798AbSLGVfW>; Sat, 7 Dec 2002 16:35:22 -0500
Received: from f04s07.cac.psu.edu ([128.118.141.35]:34697 "EHLO
	f04n07.cac.psu.edu") by vger.kernel.org with ESMTP
	id <S264779AbSLGVfV>; Sat, 7 Dec 2002 16:35:21 -0500
Date: Sat, 7 Dec 2002 16:43:00 -0500
From: Matt Rickard <mjr318@psu.edu>
To: linux-kernel@vger.kernel.org
Subject: Oops with 3c59x module (3com 3c595 NIC)
Message-Id: <20021207164300.2a35f18d.mjr318@psu.edu>
X-Mailer: Sylpheed version 0.8.5claws (GTK+ 1.2.10; )
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm running kernel 2.4.19 on a system with a 3com 3c595 NIC, using the
3c59x module.  The system will run as normal for a period of time
(generally a pretty long period of time, e.g. 30 days or so) before I
will get an Oops regarding this module.  After the oops however, the
system will generally run as expected, although in several cases the NIC
has been unresponsive following this.

Also on another note, I have not been able to get this card to run at
100mbps no matter what I try.  It will insist on running only at 10mbps
half duplex (This is on a 100mbps network).

Any ideas?  Is this a problem with the 3c59x module itself?

Here is the relevant portion of my dmesg:

3c59x: Donald Becker and others. www.scyld.com/network/vortex.html
00:0b.0: 3Com PCI 3c595 Vortex 100baseTx at 0x6100. Vers LK1.1.16
00:0b.0: Overriding PCI latency timer (CFLT) setting of 32, new value is
248.
[SNIPPED]
...

eth0: Transmit error, Tx status register 90.
eth0: Transmit error, Tx status register 90.
eth0: Transmit error, Tx status register c0.
eth0: Transmit error, Tx status register d0.
eth0: Transmit error, Tx status register 90.
eth0: Transmit error, Tx status register 90.
invalid operand: 0000
CPU:    0
EIP:    0010:[<c0108704>]    Not tainted
EFLAGS: 00010046
eax: 00000000   ebx: 00000004   ecx: bffff698   edx: 401286a0
esi: 4012c1d0   edi: 00000004   ebp: bffff668   esp: c30fbfd0
ds: 0018   es: 0018   ss: 0018
Process find (pid: 894, stackpage=c30fb000)
Stack: 4012c1d0 00000004 bffff668 00000000 c010002b 0000002b 000000c5
400d914c        00000023 00000216 bffff5fc 0000002b 
Call Trace:   

Code: fe ff ff fd 1f 07 83 c4 0c cf cf fe fb f7 44 24 33 68 08 c3 
 <1>Unable to handle kernel NULL pointer dereference at virtual address
00000000 printing eip:
c013d515
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0010:[<c013d515>]    Not tainted
EFLAGS: 00010246
eax: 00000000   ebx: c220c6c0   ecx: c1b3ca20   edx: c29c44c0
esi: c220c6d8   edi: c10b6320   ebp: c220c6c0   esp: c30fbe8c
ds: 0018   es: 0018   ss: 0018
Process find (pid: 894, stackpage=c30fb000)
Stack: c29c4340 c1b3ca20 c012e427 c220c6c0 c088fea0 c24e7b40 08055000
00001000        c012088d c24e7b40 c30fbf9c c30fa000 0000000b c088f5a0
c01115dd c24e7b40        c24e7b40 c01153cd c24e7b40 00000000 c30fbf9c
c0108f0c bffff668 c0108cf9 Call Trace:    [<c012e427>] [<c012088d>]
[<c01115dd>] [<c01153cd>] [<c0108f0c>]  [<c0108cf9>] [<c0108f8e>]
[<c0108704>] [<c011c60a>] [<c0135b80>] [<c01087f4>]  [<c0108704>]

Code: 08 00 00 39 43 10 74 23 20 9c 02 25 c0 89 70 04 89 43 18 c7 
 <3>eth0: Transmit error, Tx status register 90.
eth0: Transmit error, Tx status register 90.
