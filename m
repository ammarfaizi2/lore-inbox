Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265616AbSJXT0x>; Thu, 24 Oct 2002 15:26:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265617AbSJXT0x>; Thu, 24 Oct 2002 15:26:53 -0400
Received: from mailout.nordcom.net ([213.168.202.90]:21405 "HELO
	mailout.nordcom.net") by vger.kernel.org with SMTP
	id <S265616AbSJXT0v>; Thu, 24 Oct 2002 15:26:51 -0400
To: Manfred Spraul <manfred@colorfullife.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [CFT] faster athlon/duron memory copy implementation
In-Reply-To: <3DB82ABF.8030706@colorfullife.com>
References: <3DB82ABF.8030706@colorfullife.com>
Reply-To: pharao90@tzi.de
Message-Id: <E184nj4-0000Qo-00@neptune.sol.net>
From: Pascal Schmidt <der.eremit@email.de>
Date: Thu, 24 Oct 2002 21:33:02 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 24 Oct 2002 19:20:13 +0200, you wrote in linux.kernel:
> Attached is a test app that compares several memory copy implementations.
> Could you run it and report the results to me, together with cpu, 
> chipset and memory type?

CPU: AMD Duron Spitfire 1 GHz
Chipset: ALi 1647 (Magik 1)
Memory: 2x 256 MB DDR-SDRAM at 200 MHz

> Please run 2 or 3 times.

CFLAGS="-march=athlon" make athlon

[pharao90@neptune (ttyp2) ~]$ ./athlon 
Athlon test program $Id: fast.c,v 1.6 2000/09/23 09:05:45 arjan Exp $ 

copy_page() tests 
copy_page function 'warm up run'         took 20604 cycles per page
copy_page function '2.4 non MMX'         took 26798 cycles per page
copy_page function '2.4 MMX fallback'    took 27143 cycles per page
copy_page function '2.4 MMX version'     took 20835 cycles per page
copy_page function 'faster_copy'         took 12324 cycles per page
copy_page function 'even_faster'         took 12615 cycles per page
copy_page function 'no_prefetch'         took 10842 cycles per page
[pharao90@neptune (ttyp2) ~]$ ./athlon 
Athlon test program $Id: fast.c,v 1.6 2000/09/23 09:05:45 arjan Exp $ 

copy_page() tests 
copy_page function 'warm up run'         took 25284 cycles per page
copy_page function '2.4 non MMX'         took 31419 cycles per page
copy_page function '2.4 MMX fallback'    took 30724 cycles per page
copy_page function '2.4 MMX version'     took 25246 cycles per page
copy_page function 'faster_copy'         took 15462 cycles per page
copy_page function 'even_faster'         took 16504 cycles per page
copy_page function 'no_prefetch'         took 10179 cycles per page
[pharao90@neptune (ttyp2) ~]$ ./athlon 
Athlon test program $Id: fast.c,v 1.6 2000/09/23 09:05:45 arjan Exp $ 

copy_page() tests 
copy_page function 'warm up run'         took 22943 cycles per page
copy_page function '2.4 non MMX'         took 30414 cycles per page
copy_page function '2.4 MMX fallback'    took 30703 cycles per page
copy_page function '2.4 MMX version'     took 23345 cycles per page
copy_page function 'faster_copy'         took 14878 cycles per page
copy_page function 'even_faster'         took 14902 cycles per page
copy_page function 'no_prefetch'         took 10872 cycles per page

Note that even_faster is always slower than faster_copy. ;)

-- 
Ciao,
Pascal
