Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315720AbSECVa1>; Fri, 3 May 2002 17:30:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315721AbSECVa0>; Fri, 3 May 2002 17:30:26 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.176.19]:51936 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id <S315720AbSECVa0>; Fri, 3 May 2002 17:30:26 -0400
Date: Fri, 3 May 2002 23:25:57 +0200 (CEST)
From: Adrian Bunk <bunk@fs.tum.de>
X-X-Sender: bunk@mimas.fachschaften.tu-muenchen.de
To: Dave Jones <davej@suse.de>
cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.5.13-dj1
In-Reply-To: <20020503185811.GA4846@suse.de>
Message-ID: <Pine.NEB.4.44.0205032313120.2605-100000@mimas.fachschaften.tu-muenchen.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 3 May 2002, Dave Jones wrote:

>...
> 2.5.13-dj1
> o   Merge 2.4.19pre7 & pre8
>     | drop non-x86 archs, cpqarray update, watchdog bits, LARGE ips update
>...

It seems the "drop ... cpqarray update" is the reason for the following
compile failure:

<--  snip  -->

gcc -D__KERNEL__ -I/home/bunk/linux/kernel-2.5/linux-2.5.13/include -Wall
-Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common
-pipe -mpreferred-stack-boundary=2 -march=k6   -nostdinc -I
/usr/lib/gcc-lib/i386-linux/2.95.4/include -DKBUILD_BASENAME=cpqarray  -c
-o cpqarray.o cpqarray.c
In file included from cpqarray.c:62:
smart1,2.h: In function `smart2e_submit_command':
smart1,2.h:159: structure has no member named `io_mem_addr'
smart1,2.h: In function `smart2e_intr_mask':
smart1,2.h:164: structure has no member named `io_mem_addr'
smart1,2.h: In function `smart2e_fifo_full':
smart1,2.h:169: structure has no member named `io_mem_addr'
smart1,2.h: In function `smart2e_completed':
smart1,2.h:174: structure has no member named `io_mem_addr'
smart1,2.h: In function `smart2e_intr_pending':
smart1,2.h:179: structure has no member named `io_mem_addr'
smart1,2.h: In function `smart1_submit_command':
smart1,2.h:215: structure has no member named `io_mem_addr'
smart1,2.h:217: structure has no member named `io_mem_addr'
smart1,2.h:218: structure has no member named `io_mem_addr'
smart1,2.h:220: structure has no member named `io_mem_addr'
smart1,2.h: In function `smart1_intr_mask':
smart1,2.h:226: structure has no member named `io_mem_addr'
smart1,2.h:227: structure has no member named `io_mem_addr'
smart1,2.h:228: structure has no member named `io_mem_addr'
smart1,2.h:229: structure has no member named `io_mem_addr'
smart1,2.h:231: structure has no member named `io_mem_addr'
smart1,2.h: In function `smart1_fifo_full':
smart1,2.h:238: structure has no member named `io_mem_addr'
smart1,2.h: In function `smart1_completed':
smart1,2.h:247: structure has no member named `io_mem_addr'
smart1,2.h:248: structure has no member named `io_mem_addr'
smart1,2.h:250: structure has no member named `io_mem_addr'
smart1,2.h:251: structure has no member named `io_mem_addr'
smart1,2.h:253: structure has no member named `io_mem_addr'
smart1,2.h: In function `smart1_intr_pending':
smart1,2.h:269: structure has no member named `io_mem_addr'
cpqarray.c: In function `ida_geninit':
cpqarray.c:169: warning: unused variable `j'
cpqarray.c: In function `cmd_alloc':
cpqarray.c:1321: warning: passing arg 1 of `find_first_zero_bit' from
incompatible pointer type
cpqarray.c:1324: warning: passing arg 2 of `test_and_set_bit' from
incompatible pointer type
cpqarray.c: In function `cmd_free':
cpqarray.c:1344: warning: passing arg 2 of `clear_bit' from incompatible
pointer type
make[3]: *** [cpqarray.o] Error 1
make[3]: Leaving directory
`/home/bunk/linux/kernel-2.5/linux-2.5.13/drivers/block'

<--  snip  -->

cu
Adrian

-- 

You only think this is a free country. Like the US the UK spends a lot of
time explaining its a free country because its a police state.
								Alan Cox

