Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264699AbTBTCOw>; Wed, 19 Feb 2003 21:14:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264705AbTBTCOw>; Wed, 19 Feb 2003 21:14:52 -0500
Received: from modemcable092.130-200-24.mtl.mc.videotron.ca ([24.200.130.92]:24132
	"EHLO montezuma.mastecende.com") by vger.kernel.org with ESMTP
	id <S264699AbTBTCOu>; Wed, 19 Feb 2003 21:14:50 -0500
Date: Wed, 19 Feb 2003 21:22:42 -0500 (EST)
From: Zwane Mwaikambo <zwane@holomorphy.com>
X-X-Sender: zwane@montezuma.mastecende.com
To: Linus Torvalds <torvalds@transmeta.com>
cc: Chris Wedgwood <cw@f00f.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       "Martin J. Bligh" <mbligh@aracnet.com>, Ingo Molnar <mingo@elte.hu>,
       William Lee Irwin III <wli@holomorphy.com>
Subject: Re: doublefault debugging (was Re: Linux v2.5.62 --- spontaneous
 reboots)
In-Reply-To: <Pine.LNX.4.44.0302191527400.9786-100000@penguin.transmeta.com>
Message-ID: <Pine.LNX.4.50.0302192113480.10247-100000@montezuma.mastecende.com>
References: <Pine.LNX.4.44.0302191527400.9786-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks!
	Here is a triple fault case (2.5.62-pgcl) and since i'm not a Real 
Man i had to use a simulator ;) Unfortunately i can't unwind the stack.

Freeing unused kernel memory: 100k freed
double fault, gdt at c0268020 [255 bytes]
double fault, tss at c027d800
eip = c01181c4, esp = f7f9bf90
eax = c0003dfc, ebx = ffffffff, ecx = 0000007b, edx = f7f9c04c
esi = 00000003, edi = c01181b0

0xc01181c4 <do_page_fault+20>:  mov    %eax,0xc(%esp,1)

(0) [0x001139e4] 0060:c01139e4 (t doublefault_fn+c4): jmp c0113ae4  ; ebfe

eax            0x1f             31
ecx            0xc027d800       -1071130624
edx            0xc027d800       -1071130624
ebx            0xc027d800       -1071130624
esp            0xc029f7ec       0xc029f7ec
ebp            0x0              0x0
esi            0xffffffff       -1
edi            0x0              0
eip            0xc01139e4       0xc01139e4
eflags         0x4082           16514
cs             0x60             96
ss             0x68             104
ds             0x7b             123
es             0x7b             123
fs             0x0              0
gs             0x0              0

CR0=0x8005003b
    PG=paging=1
    CD=cache disable=0
    NW=not write through=0
    AM=alignment mask=1
    WP=write protect=1
    NE=numeric error=1
    ET=extension type=1
    TS=task switched=1
    EM=FPU emulation=0
    MP=monitor coprocessor=1
    PE=protection enable=1
CR2=page fault linear address=0xf7f9bf8c
CR3=0x00101000
    PCD=page-level cache disable=0
    PWT=page-level writes transparent=0
CR4=0x000000b0
    VME=virtual-8086 mode extensions=0
    PVI=protected-mode virtual interrupts=0
    TSD=time stamp disable=0
    DE=debugging extensions=0
    PSE=page size extensions=1
    PAE=physical address extension=1
    MCE=machine check enable=0
    PGE=page global enable=1
    PCE=performance-monitor counter enable=0
    OXFXSR=OS support for FXSAVE/FXRSTOR=0
    OSXMMEXCPT=OS support for unmasked SIMD FP exceptions=0

Global Descriptor Table (0xc0268020):
GDT[0x00]=??? descriptor hi=00000000, lo=00000000
GDT[0x01]=??? descriptor hi=00000000, lo=00000000
GDT[0x02]=??? descriptor hi=00000000, lo=00000000
GDT[0x03]=??? descriptor hi=00000000, lo=00000000
GDT[0x04]=??? descriptor hi=00000000, lo=00000000
GDT[0x05]=??? descriptor hi=00000000, lo=00000000
GDT[0x06]=??? descriptor hi=00000000, lo=00000000
GDT[0x07]=??? descriptor hi=00000000, lo=00000000
GDT[0x08]=??? descriptor hi=00000000, lo=00000000
GDT[0x09]=??? descriptor hi=00000000, lo=00000000
GDT[0x0a]=??? descriptor hi=00000000, lo=00000000
GDT[0x0b]=??? descriptor hi=00000000, lo=00000000
GDT[0x0c]=Code segment, linearaddr=00000000, len=fffff * 4Kbytes, Execute/Read, 32-bit addrs
GDT[0x0d]=Data segment, linearaddr=00000000, len=fffff * 4Kbytes, Read/Write, Accessed
GDT[0x0e]=Code segment, linearaddr=00000000, len=fffff * 4Kbytes, Execute/Read, 32-bit addrs
GDT[0x0f]=Data segment, linearaddr=00000000, len=fffff * 4Kbytes, Read/Write, Accessed
GDT[0x10]=32-Bit TSS (Busy) at c027d800, length 0x000eb
GDT[0x11]=LDT
GDT[0x12]=Code segment, linearaddr=00000000, len=00000 * 4Kbytes, Execute/Read, 32-bit addrs
GDT[0x13]=Code segment, linearaddr=00000000, len=00000 * 4Kbytes, Execute/Read, 16-bit addrs
GDT[0x14]=Data segment, linearaddr=00000000, len=00000 * 4Kbytes, Read/Write
GDT[0x15]=Data segment, linearaddr=00000000, len=00000 * 4Kbytes, Read/Write
GDT[0x16]=Data segment, linearaddr=00000000, len=00000 * 4Kbytes, Read/Write
GDT[0x17]=Code segment, linearaddr=00000000, len=00000 bytes, Execute/Read, 32-bit addrs
GDT[0x18]=Code segment, linearaddr=00000000, len=00000 bytes, Execute/Read, 16-bit addrs
GDT[0x19]=Data segment, linearaddr=00000000, len=00000 bytes, Read/Write
GDT[0x1a]=??? descriptor hi=00000000, lo=00000000
GDT[0x1b]=??? descriptor hi=00000000, lo=00000000
GDT[0x1c]=??? descriptor hi=00000000, lo=00000000
GDT[0x1d]=??? descriptor hi=00000000, lo=00000000
GDT[0x1e]=??? descriptor hi=00000000, lo=00000000
GDT[0x1f]=32-Bit TSS (Busy) at c027f500, length 0x000eb

