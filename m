Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265869AbSJXThb>; Thu, 24 Oct 2002 15:37:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265868AbSJXTha>; Thu, 24 Oct 2002 15:37:30 -0400
Received: from roc-24-169-118-30.rochester.rr.com ([24.169.118.30]:33251 "EHLO
	death.krwtech.com") by vger.kernel.org with ESMTP
	id <S265864AbSJXTh2>; Thu, 24 Oct 2002 15:37:28 -0400
Date: Thu, 24 Oct 2002 15:43:28 -0400 (EDT)
From: Ken Witherow <ken@krwtech.com>
X-X-Sender: ken@death
Reply-To: Ken Witherow <ken@krwtech.com>
To: Manfred Spraul <manfred@colorfullife.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: [CFT] faster athlon/duron memory copy implementation
In-Reply-To: <3DB849EF.1050904@colorfullife.com>
Message-ID: <Pine.LNX.4.44.0210241541240.14962-100000@death>
Organization: KRW Technologies
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[ken@death ken]$ cat /proc/cpuinfo
processor       : 0
vendor_id       : AuthenticAMD
cpu family      : 6
model           : 6
model name      : AMD Athlon(tm) MP 1800+
stepping        : 2
cpu MHz         : 1533.408
cache size      : 256 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 1
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca
cmov pat pse36 mmx fxsr sse syscall mmxext 3dnowext 3dnow
bogomips        : 3060.53

processor       : 1
vendor_id       : AuthenticAMD
cpu family      : 6
model           : 6
model name      : AMD Athlon(tm) Processor
stepping        : 2
cpu MHz         : 1533.408
cache size      : 256 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 1
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca
cmov pat pse36 mmx fxsr sse syscall mmxext 3dnowext 3dnow
bogomips        : 3060.53


Running on a Tyan S2460 (760MP chipset)

[ken@death ken]$ ./athlon
Athlon test program $Id: fast.c,v 1.6 2000/09/23 09:05:45 arjan Exp $

copy_page() tests
copy_page function 'warm up run'         took 16742 cycles per page
copy_page function '2.4 non MMX'         took 18632 cycles per page
copy_page function '2.4 MMX fallback'    took 18948 cycles per page
copy_page function '2.4 MMX version'     took 16772 cycles per page
copy_page function 'faster_copy'         took 10157 cycles per page
copy_page function 'even_faster'         took 10406 cycles per page
copy_page function 'no_prefetch'         took 8865 cycles per page
[ken@death ken]$ ./athlon
Athlon test program $Id: fast.c,v 1.6 2000/09/23 09:05:45 arjan Exp $

copy_page() tests
copy_page function 'warm up run'         took 16804 cycles per page
copy_page function '2.4 non MMX'         took 18712 cycles per page
copy_page function '2.4 MMX fallback'    took 18630 cycles per page
copy_page function '2.4 MMX version'     took 16810 cycles per page
copy_page function 'faster_copy'         took 10211 cycles per page
copy_page function 'even_faster'         took 10462 cycles per page
copy_page function 'no_prefetch'         took 8858 cycles per page
[ken@death ken]$ ./athlon
Athlon test program $Id: fast.c,v 1.6 2000/09/23 09:05:45 arjan Exp $

copy_page() tests
copy_page function 'warm up run'         took 16877 cycles per page
copy_page function '2.4 non MMX'         took 18692 cycles per page
copy_page function '2.4 MMX fallback'    took 18557 cycles per page
copy_page function '2.4 MMX version'     took 16763 cycles per page
copy_page function 'faster_copy'         took 10206 cycles per page
copy_page function 'even_faster'         took 10325 cycles per page
copy_page function 'no_prefetch'         took 8892 cycles per page


-- 
       Ken Witherow <phantoml AT rochester.rr.com>
           ICQ: 21840670  AIM: phantomlordken
               http://www.krwtech.com/ken


