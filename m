Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265566AbSJXRfT>; Thu, 24 Oct 2002 13:35:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265567AbSJXRfT>; Thu, 24 Oct 2002 13:35:19 -0400
Received: from hermes.domdv.de ([193.102.202.1]:36617 "EHLO zeus.domdv.de")
	by vger.kernel.org with ESMTP id <S265566AbSJXRfR>;
	Thu, 24 Oct 2002 13:35:17 -0400
Message-ID: <3DB830AC.1020509@domdv.de>
Date: Thu, 24 Oct 2002 19:41:00 +0200
From: Andreas Steinmetz <ast@domdv.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1) Gecko/20021020
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Manfred Spraul <manfred@colorfullife.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: [CFT] faster athlon/duron memory copy implementation
References: <3DB82ABF.8030706@colorfullife.com>
X-Enigmail-Version: 0.65.2.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Athlon TB 900/VIA KT133

titanic:/tmp # cat /proc/cpuinfo
processor       : 0
vendor_id       : AuthenticAMD
cpu family      : 6
model           : 4
model name      : AMD Athlon(tm) Processor
stepping        : 2
cpu MHz         : 902.075
cache size      : 256 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 1
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge 
mca cmov pat pse36 mmx fxsr syscall mmxext 3dnowext 3dnow
bogomips        : 1795.68

titanic:/tmp # gcc -O3 -s -o athlon athlon.c
titanic:/tmp # ./athlon
Athlon test program $Id: fast.c,v 1.6 2000/09/23 09:05:45 arjan Exp $

copy_page() tests
copy_page function 'warm up run'         took 13359 cycles per page
copy_page function '2.4 non MMX'         took 20749 cycles per page
copy_page function '2.4 MMX fallback'    took 20737 cycles per page
copy_page function '2.4 MMX version'     took 13545 cycles per page
copy_page function 'faster_copy'         took 8132 cycles per page
copy_page function 'even_faster'         took 8123 cycles per page
copy_page function 'no_prefetch'         took 7648 cycles per page
titanic:/tmp # ./athlon
Athlon test program $Id: fast.c,v 1.6 2000/09/23 09:05:45 arjan Exp $

copy_page() tests
copy_page function 'warm up run'         took 13398 cycles per page
copy_page function '2.4 non MMX'         took 20774 cycles per page
copy_page function '2.4 MMX fallback'    took 20749 cycles per page
copy_page function '2.4 MMX version'     took 13349 cycles per page
copy_page function 'faster_copy'         took 8130 cycles per page
copy_page function 'even_faster'         took 8168 cycles per page
copy_page function 'no_prefetch'         took 7631 cycles per page
titanic:/tmp # ./athlon
Athlon test program $Id: fast.c,v 1.6 2000/09/23 09:05:45 arjan Exp $

copy_page() tests
copy_page function 'warm up run'         took 13470 cycles per page
copy_page function '2.4 non MMX'         took 20780 cycles per page
copy_page function '2.4 MMX fallback'    took 20784 cycles per page
copy_page function '2.4 MMX version'     took 13384 cycles per page
copy_page function 'faster_copy'         took 8172 cycles per page
copy_page function 'even_faster'         took 8137 cycles per page
copy_page function 'no_prefetch'         took 7633 cycles per page
titanic:/tmp # ./athlon
Athlon test program $Id: fast.c,v 1.6 2000/09/23 09:05:45 arjan Exp $

copy_page() tests
copy_page function 'warm up run'         took 13377 cycles per page
copy_page function '2.4 non MMX'         took 20764 cycles per page
copy_page function '2.4 MMX fallback'    took 20831 cycles per page
copy_page function '2.4 MMX version'     took 13336 cycles per page
copy_page function 'faster_copy'         took 8140 cycles per page
copy_page function 'even_faster'         took 8131 cycles per page
copy_page function 'no_prefetch'         took 7670 cycles per page

--
Andreas Steinmetz
D.O.M. Datenverarbeitung GmbH

