Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261849AbSJZERD>; Sat, 26 Oct 2002 00:17:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261850AbSJZERD>; Sat, 26 Oct 2002 00:17:03 -0400
Received: from CPE3236333432363339.cpe.net.cable.rogers.com ([24.101.90.246]:36612
	"HELO coredump.sh0n.net") by vger.kernel.org with SMTP
	id <S261849AbSJZERC>; Sat, 26 Oct 2002 00:17:02 -0400
From: Shawn Starr <spstarr@sh0n.net>
Organization: sh0n.net
To: linux-kernel@vger.kernel.org
Subject: Re: [CFT] faster athlon/duron memory copy implementation - 2.4.20-pre7 Test
Date: Sat, 26 Oct 2002 00:26:26 -0400
User-Agent: KMail/1.4.7
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200210260026.26043.spstarr@sh0n.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

A 2.5.44 test is coming in a moment :-)

processor       : 0
vendor_id       : AuthenticAMD
cpu family      : 6
model           : 6
model name      : AMD Athlon(TM) MP 2000+
stepping        : 2
cpu MHz         : 1680.422
cache size      : 256 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 1
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 mmx fxsr sse syscall mmxext 3dnowext 3dnow
bogomips        : 3355.44

RAM is PC2100 Registered DDR 512MB 
Motherboard/Chipset: A7M266-D AMD 760MPX

lspci info chipset (It's an MPX but also is MP).

00:00.0 Host bridge: Advanced Micro Devices [AMD] AMD-760 MP [IGD4-2P] System Controller (rev 11)
00:07.0 ISA bridge: Advanced Micro Devices [AMD] AMD-768 [Opus] ISA (rev 04)
00:07.3 Bridge: Advanced Micro Devices [AMD] AMD-768 [Opus] ACPI (rev 03)
00:10.0 PCI bridge: Advanced Micro Devices [AMD] AMD-768 [Opus] PCI (rev 04)

(more detail)
PCI devices found:
  Bus  0, device   0, function  0:
    Host bridge: Advanced Micro Devices [AMD] AMD-760 MP [IGD4-2P] System Controller (rev 17).
      Master Capable.  Latency=32.
      Prefetchable 32 bit memory at 0xf0000000 [0xf7ffffff].
      Prefetchable 32 bit memory at 0xef800000 [0xef800fff].
      I/O at 0xe800 [0xe803].
  Bus  0, device   1, function  0:
    PCI bridge: Advanced Micro Devices [AMD] AMD-760 MP [IGD4-2P] AGP Bridge (rev 0).
      Master Capable.  No bursts.  Min Gnt=8.

Kernel Preformed on : 2.4.20-pre7

gcc (GCC) 3.2.1 20021011 (prerelease)
Copyright (C) 2002 Free Software Foundation, Inc.

gcc athlon.c -O3 -march=athlon-mp -mcpu=athlon-mp -falign-functions -fomit-frame-pointer 
-mpreferred-stack-boundary=2 -falign-functions=4 -fschedule-insns2 -fexpensive-optimizations -o athlon

Athlon test program $Id: fast.c,v 1.6 2000/09/23 09:05:45 arjan Exp $

copy_page() tests
copy_page function 'warm up run'         took 20526 cycles per page
copy_page function '2.4 non MMX'         took 23249 cycles per page
copy_page function '2.4 MMX fallback'    took 23114 cycles per page
copy_page function '2.4 MMX version'     took 20693 cycles per page
copy_page function 'faster_copy'         took 11679 cycles per page
copy_page function 'even_faster'         took 12126 cycles per page
copy_page function 'no_prefetch'         took 9323 cycles per page

Athlon test program $Id: fast.c,v 1.6 2000/09/23 09:05:45 arjan Exp $

copy_page() tests
copy_page function 'warm up run'         took 20255 cycles per page
copy_page function '2.4 non MMX'         took 23129 cycles per page
copy_page function '2.4 MMX fallback'    took 23026 cycles per page
copy_page function '2.4 MMX version'     took 20394 cycles per page
copy_page function 'faster_copy'         took 11923 cycles per page
copy_page function 'even_faster'         took 11974 cycles per page
copy_page function 'no_prefetch'         took 9521 cycles per page

Athlon test program $Id: fast.c,v 1.6 2000/09/23 09:05:45 arjan Exp $

copy_page() tests
copy_page function 'warm up run'         took 20459 cycles per page
copy_page function '2.4 non MMX'         took 23211 cycles per page
copy_page function '2.4 MMX fallback'    took 23347 cycles per page
copy_page function '2.4 MMX version'     took 20305 cycles per page
copy_page function 'faster_copy'         took 11944 cycles per page
copy_page function 'even_faster'         took 12016 cycles per page
copy_page function 'no_prefetch'         took 9313 cycles per page


