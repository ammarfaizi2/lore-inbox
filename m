Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265425AbSJXVzG>; Thu, 24 Oct 2002 17:55:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265676AbSJXVzG>; Thu, 24 Oct 2002 17:55:06 -0400
Received: from amsfep13-int.chello.nl ([213.46.243.24]:20020 "EHLO
	amsfep13-int.chello.nl") by vger.kernel.org with ESMTP
	id <S265425AbSJXVzF>; Thu, 24 Oct 2002 17:55:05 -0400
Subject: Re: [CFT] faster athlon/duron memory copy implementation
From: Harm Verhagen <h.verhagen@chello.nl>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 25 Oct 2002 00:01:09 +0200
Message-Id: <1035496870.5266.3.camel@pchome>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Athlon XP 1800+, VIA KT333, 256MB DDR2100

Athlon test program $Id: fast.c,v 1.6 2000/09/23 09:05:45 arjan Exp $

copy_page() tests
copy_page function 'warm up run'         took 16180 cycles per page
copy_page function '2.4 non MMX'         took 17913 cycles per page
copy_page function '2.4 MMX fallback'    took 18610 cycles per page
copy_page function '2.4 MMX version'     took 16200 cycles per page
copy_page function 'faster_copy'         took 9908 cycles per page
copy_page function 'even_faster'         took 10117 cycles per page
copy_page function 'no_prefetch'         took 6993 cycles per page
[harm@pchome memcpy2]$ ./memcpy
Athlon test program $Id: fast.c,v 1.6 2000/09/23 09:05:45 arjan Exp $

copy_page() tests
copy_page function 'warm up run'         took 16293 cycles per page
copy_page function '2.4 non MMX'         took 17929 cycles per page
copy_page function '2.4 MMX fallback'    took 18637 cycles per page
copy_page function '2.4 MMX version'     took 16209 cycles per page
copy_page function 'faster_copy'         took 9907 cycles per page
copy_page function 'even_faster'         took 10122 cycles per page
copy_page function 'no_prefetch'         took 6964 cycles per page

harm@pchome memcpy2]$ cat /proc/cpuinfo
processor       : 0
vendor_id       : AuthenticAMD
cpu family      : 6
model           : 6
model name      : AMD Athlon(TM) XP 1800+
stepping        : 2
cpu MHz         : 1532.941
cache size      : 256 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 1
wp              : yes
flags           : fpu vme de tsc msr pae mce cx8 apic sep mtrr pge mca
cmov pat
pse36 mmx fxsr sse syscall mmxext 3dnowext 3dnow
bogomips        : 3060.53




