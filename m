Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265686AbSJXWMl>; Thu, 24 Oct 2002 18:12:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265687AbSJXWMl>; Thu, 24 Oct 2002 18:12:41 -0400
Received: from gans.physik3.uni-rostock.de ([139.30.44.2]:12948 "EHLO
	gans.physik3.uni-rostock.de") by vger.kernel.org with ESMTP
	id <S265686AbSJXWMk>; Thu, 24 Oct 2002 18:12:40 -0400
Date: Fri, 25 Oct 2002 00:18:50 +0200 (CEST)
From: Tim Schmielau <tim@physik3.uni-rostock.de>
To: Manfred Spraul <manfred@colorfullife.com>
cc: <linux-kernel@vger.kernel.org>, <arjanv@redhat.com>
Subject: Re: [CFT] faster athlon/duron memory copy implementation
In-Reply-To: <3DB82ABF.8030706@colorfullife.com>
Message-ID: <Pine.LNX.4.33.0210250013120.32410-100000@gans.physik3.uni-rostock.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Attached is a test app that compares several memory copy implementations.
> Could you run it and report the results to me, together with cpu, 
> chipset and memory type?

since everone seems to CC: lkml in the reply...

Athlon-500, AMD-751 Irongate, PC800-222 ECC SDRAM

> ./a.out 
Athlon test program $Id: fast.c,v 1.6 2000/09/23 09:05:45 arjan Exp $ 

copy_page() tests 
copy_page function 'warm up run'         took 9998 cycles per page
copy_page function '2.4 non MMX'         took 15269 cycles per page
copy_page function '2.4 MMX fallback'    took 15192 cycles per page
copy_page function '2.4 MMX version'     took 10152 cycles per page
copy_page function 'faster_copy'         took 10264 cycles per page
copy_page function 'even_faster'         took 10013 cycles per page
copy_page function 'no_prefetch'         took 11527 cycles per page
> ./a.out
Athlon test program $Id: fast.c,v 1.6 2000/09/23 09:05:45 arjan Exp $ 

copy_page() tests 
copy_page function 'warm up run'         took 9975 cycles per page
copy_page function '2.4 non MMX'         took 15513 cycles per page
copy_page function '2.4 MMX fallback'    took 15219 cycles per page
copy_page function '2.4 MMX version'     took 10009 cycles per page
copy_page function 'faster_copy'         took 10186 cycles per page
copy_page function 'even_faster'         took 10088 cycles per page
copy_page function 'no_prefetch'         took 11583 cycles per page
> ./a.out
Athlon test program $Id: fast.c,v 1.6 2000/09/23 09:05:45 arjan Exp $ 

copy_page() tests 
copy_page function 'warm up run'         took 9967 cycles per page
copy_page function '2.4 non MMX'         took 15178 cycles per page
copy_page function '2.4 MMX fallback'    took 15178 cycles per page
copy_page function '2.4 MMX version'     took 10086 cycles per page
copy_page function 'faster_copy'         took 10124 cycles per page
copy_page function 'even_faster'         took 10025 cycles per page
copy_page function 'no_prefetch'         took 11524 cycles per page
> lspci 
00:00.0 Host bridge: Advanced Micro Devices [AMD] AMD-751 [Irongate] 
System Controller (rev 23)
00:01.0 PCI bridge: Advanced Micro Devices [AMD] AMD-751 [Irongate] AGP 
Bridge (rev 01)
00:04.0 Ethernet controller: 3Com Corporation 3c905B 100BaseTX [Cyclone] 
(rev 64)
00:07.0 ISA bridge: VIA Technologies, Inc. VT82C686 [Apollo Super South] 
(rev 14)
00:07.1 IDE interface: VIA Technologies, Inc. Bus Master IDE (rev 06)
00:07.2 USB Controller: VIA Technologies, Inc. UHCI USB (rev 06)
00:07.3 USB Controller: VIA Technologies, Inc. UHCI USB (rev 06)
00:07.4 SMBus: VIA Technologies, Inc. VT82C686 [Apollo Super ACPI] (rev 
10)
01:05.0 VGA compatible controller: S3 Inc. 86c368 [Trio 3D/2X] (rev 02)
> cat /proc/cpuinfo 
processor       : 0
vendor_id       : AuthenticAMD
cpu family      : 6
model           : 1
model name      : AMD-K7(tm) Processor
stepping        : 2
cpu MHz         : 499.051
cache size      : 512 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 1
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 sep mtrr pge mca cmov 
pat mmx syscall mmxext 3dnowext 3dnow
bogomips        : 992.87


Tim

