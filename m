Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265634AbSJXTyL>; Thu, 24 Oct 2002 15:54:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265635AbSJXTyL>; Thu, 24 Oct 2002 15:54:11 -0400
Received: from crete.csd.uch.gr ([147.52.16.2]:59357 "EHLO crete.csd.uch.gr")
	by vger.kernel.org with ESMTP id <S265634AbSJXTyJ>;
	Thu, 24 Oct 2002 15:54:09 -0400
Organization: 
Date: Fri, 25 Oct 2002 03:59:13 +0300 (EEST)
From: Panagiotis Papadakos <papadako@csd.uoc.gr>
To: linux-kernel@vger.kernel.org
Subject: Re: [CFT] faster athlon/duron memory copy implementation
In-Reply-To: <3DB84C3E.1070709@colorfullife.com>
Message-ID: <Pine.GSO.4.44.0210250355450.4299-100000@oneiro.csd.uch.gr>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


ASUS K7V 512 Mb PC-133 Athlon Slot-A 600 MhZ

bash-2.05# cat /proc/cpuinfo
processor	: 0
vendor_id	: AuthenticAMD
cpu family	: 6
model		: 2
model name	: AMD Athlon(tm) Processor
stepping	: 1
cpu MHz		: 618.008
cache size	: 512 KB
fdiv_bug	: no
hlt_bug		: no
f00f_bug	: no
coma_bug	: no
fpu		: yes
fpu_exception	: yes
cpuid level	: 1
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca
cmov pat pse36 mmx fxsr syscall mmxext 3dnowext 3dnow
bogomips	: 1232.07

bash-2.05# ./athlon
Athlon test program $Id: fast.c,v 1.6 2000/09/23 09:05:45 arjan Exp $

copy_page() tests
copy_page function 'warm up run'	 took 10096 cycles per page
copy_page function '2.4 non MMX'	 took 14856 cycles per page
copy_page function '2.4 MMX fallback'	 took 14168 cycles per page
copy_page function '2.4 MMX version'	 took 10754 cycles per page
copy_page function 'faster_copy'	 took 5752 cycles per page
copy_page function 'even_faster'	 took 5694 cycles per page
copy_page function 'no_prefetch'	 took 6560 cycles per page

bash-2.05# ./athlon
Athlon test program $Id: fast.c,v 1.6 2000/09/23 09:05:45 arjan Exp $

copy_page() tests
copy_page function 'warm up run'	 took 10851 cycles per page
copy_page function '2.4 non MMX'	 took 14726 cycles per page
copy_page function '2.4 MMX fallback'	 took 14390 cycles per page
copy_page function '2.4 MMX version'	 took 11390 cycles per page
copy_page function 'faster_copy'	 took 5490 cycles per page
copy_page function 'even_faster'	 took 5655 cycles per page
copy_page function 'no_prefetch'	 took 5906 cycles per page


bash-2.05# ./athlon
Athlon test program $Id: fast.c,v 1.6 2000/09/23 09:05:45 arjan Exp $

copy_page() tests
copy_page function 'warm up run'	 took 9819 cycles per page
copy_page function '2.4 non MMX'	 took 14897 cycles per page
copy_page function '2.4 MMX fallback'	 took 15609 cycles per page
copy_page function '2.4 MMX version'	 took 10374 cycles per page
copy_page function 'faster_copy'	 took 5759 cycles per page
copy_page function 'even_faster'	 took 5609 cycles per page
copy_page function 'no_prefetch'	 took 6059 cycles per page


