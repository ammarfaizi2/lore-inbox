Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271673AbRH0I7r>; Mon, 27 Aug 2001 04:59:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271309AbRH0I7h>; Mon, 27 Aug 2001 04:59:37 -0400
Received: from b73254.upc-b.chello.nl ([212.83.73.254]:36364 "EHLO
	kleintje.nozone.nl") by vger.kernel.org with ESMTP
	id <S271673AbRH0I7V>; Mon, 27 Aug 2001 04:59:21 -0400
Date: Mon, 27 Aug 2001 10:59:36 +0200 (CEST)
From: Tony den Haan <tony@chello.nl>
To: linux-kernel@vger.kernel.org
Subject: 2.4.8/9 panic on serial with MSI-694D MB
Message-ID: <Pine.LNX.4.21.0108271052440.14250-100000@kleintje.nozone.nl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi,

i ran into strange problem with2.4.9 panics, first only sometimes, later
on it just wouldn't boot at all.

VP_IDE: VIA vt82c686a (rev 22) IDE UDMA66 controller on pci00:07.1
        ide0: BM-DMA at 0x9000-0x9007, BIOS settings hda:DMA, hdb:pio
        ide1: BM-DMA at 0x9008-0x900f, BIOS settings hdc:pio, hdd:pio
Unable to handle kernel NULL pointer dereference at virtual address
00000018
 printing eip:
00000018
*pde = 00000000
Oops: 0000
CPU:    1
EIP:    0010:[<00000018>]
EFLAGS: 00010246
eax: 00000000 ebx: c01051d0 ecx: c15f6000 edx: c15f6000
esi: c15f6000 edi: c01051d0 ebp: 00000000 esp: c15f7fb0
ds: 0018  es: 0018  ss: 0018
Process swapper (pid: 0, stackpage=c15f7000)
Stack:  c0105262 00000002 00000000 00000000 c0247a4a c02a0e80 00000000
        c0199b77 00000000 0000000d 00000000 00000000 c016956e c1443000
        00000001 c02a0e0a 00000000 00000000
Call Trace: [c0105262>] [<c0199b77>] [<c016966e>]

Code: Bad EIP value
Kernel panicL Attempted to kill the idle task!
In idle task - not syncing

all attempts came up with same 0018

this is where serial gets initialized, removing serial support from kernel
fixed the problem

it's SMP PIII system with via82Cxx chipset, no special hardware added.
2.4.5 did ok.

any thoughts? hints what to look at?

tony


