Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129641AbRAEK35>; Fri, 5 Jan 2001 05:29:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129697AbRAEK3q>; Fri, 5 Jan 2001 05:29:46 -0500
Received: from Prins.externet.hu ([212.40.96.161]:11536 "EHLO
	prins.externet.hu") by vger.kernel.org with ESMTP
	id <S129641AbRAEK33>; Fri, 5 Jan 2001 05:29:29 -0500
Date: Fri, 5 Jan 2001 11:29:26 +0100 (CET)
From: Narancs 1 <narancs1@externet.hu>
To: linux-kernel@vger.kernel.org
Subject: agpgart problem on 2.4.0-ac1
Message-ID: <Pine.LNX.4.02.10101051120340.15872-100000@prins.externet.hu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-2
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dear all!

wanted to try the latest stuff, but X fails to start now.

dmesg part:
Linux agpgart interface v0.99 (c) Jeff Hartmann
agpgart: Maximum main memory to use for agp memory: 93M
agpgart: agpgart: Detected an Intel i815 Chipset.
Unable to handle kernel NULL pointer dereference at virtual address
00000000
 printing eip:
00000000
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0010:[<00000000>]
EFLAGS: 00010246
eax: 00000000   ebx: c8827000   ecx: c020da88   edx: 00000001
esi: 00000000   edi: 00000000   ebp: 00000000   esp: c78a1f04
ds: 0018   es: 0018   ss: 0018
Process modprobe (pid: 61, stackpage=c78a1000)
Stack: c8829bb0 c8827000 00000000 c8827068 00003fd0 00000000 c8829d50
c882aa00
       00000000 00000063 c8827000 c01156cd c78a0000 bfffc3a4 bfffc3a4
bfffc364
       00003b67 c779a000 00000060 c779b000 ffffffea 00000007 c1253460
00000060
Call Trace: [<c8829bb0>] [<c8827000>] [<c8827068>] [<c8829d50>]
[<c882aa00>] [<c8827000>] [<c01156cd>]
       [<c8820000>] [<c8827060>] [<c0108d5f>]

Code:  Bad EIP value.

lsmod
Module                  Size  Used by
nls_cp850               3584   2  (autoclean)
nls_iso8859-2           3360   2  (autoclean)
smbfs                  31056   2  (autoclean)
floppy                 45296   0  (autoclean)
serial                 43312   1  (autoclean)
isa-pnp                27600   0  (autoclean) [serial]
ide-cd                 26288   0
cdrom                  26720   0  [ide-cd]
softdog                 1472   0  (unused)
agpgart                16336   1  (initializing)
8139too                14784   1
rtc                     5248   0
ipchains               30848   0  (unused)

I hope you'll fix it soon.


Köszönettel
Narancs v1

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
