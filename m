Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262389AbRE2XFQ>; Tue, 29 May 2001 19:05:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262406AbRE2XFF>; Tue, 29 May 2001 19:05:05 -0400
Received: from fe8.southeast.rr.com ([24.93.67.55]:46863 "EHLO mail8.nc.rr.com")
	by vger.kernel.org with ESMTP id <S262389AbRE2XEs>;
	Tue, 29 May 2001 19:04:48 -0400
Message-ID: <3B142AE0.20A22175@bigfoot.com>
Date: Tue, 29 May 2001 19:04:00 -0400
From: John <cmptradm@bigfoot.com>
X-Mailer: Mozilla 4.76 [en] (Win95; U)
X-Accept-Language: en,pdf
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: 2.4.5 kernel on Sparc32
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry if this is a repeat.  Can't find anything on it. My guess is that
I don't know where to look.  I am trying to build the 2.4.5 kernel on a
Sparc LX.  I get numerous error messages when trying to build the
kernel:


> make[1]: Entering directory `/usr/src/linux-2.4.5/mm'
> make all_targets
> make[2]: Entering directory `/usr/src/linux-2.4.5/mm'
> gcc -D__KERNEL__ -I/usr/src/linux-2.4.5/include -Wall -Wstrict-prototypes -O2 -fomit-frame-pointer -fno-strict-aliasing -m32 -pipe -mno-fpu -fcall-used-g5 -fcall-used-g7    -c -o memory.o memory.c
> memory.c:183: macro `pmd_alloc' used with too many (3) args
> memory.c:204: macro `pte_alloc' used with too many (3) args
> memory.c:725: macro `pte_alloc' used with too many (3) args
> memory.c:750: macro `pmd_alloc' used with too many (3) args
> memory.c:805: macro `pte_alloc' used with too many (3) args
> memory.c:832: macro `pmd_alloc' used with too many (3) args
> memory.c:1339: macro `pmd_alloc' used with too many (3) args
> memory.c:1342: macro `pte_alloc' used with too many (3) args
> memory.c:1392: macro `pte_alloc' used with too many (3) args
> memory.c: In function `copy_page_range':
> memory.c:183: warning: passing arg 1 of `___f_pmd_alloc' from incompatible pointer type
> memory.c:183: warning: passing arg 2 of `___f_pmd_alloc' makes integer from pointer without a cast
> memory.c:204: warning: passing arg 1 of `___f_pte_alloc' from incompatible pointer type
> memory.c:204: warning: passing arg 2 of `___f_pte_alloc' makes integer from pointer without a cast
> memory.c: In function `zeromap_pmd_range':
> memory.c:725: warning: passing arg 1 of `___f_pte_alloc' from incompatible pointer type
> memory.c:725: warning: passing arg 2 of `___f_pte_alloc' makes integer from pointer without a cast
> memory.c: In function `zeromap_page_range':
> memory.c:750: warning: passing arg 1 of `___f_pmd_alloc' from incompatible pointer type
> memory.c:750: warning: passing arg 2 of `___f_pmd_alloc' makes integer from pointer without a cast
> memory.c: In function `remap_pmd_range':
> memory.c:805: warning: passing arg 1 of `___f_pte_alloc' from incompatible pointer type
> memory.c:805: warning: passing arg 2 of `___f_pte_alloc' makes integer from pointer without a cast
> memory.c: In function `remap_page_range':
> memory.c:832: warning: passing arg 1 of `___f_pmd_alloc' from incompatible pointer type
> memory.c:832: warning: passing arg 2 of `___f_pmd_alloc' makes integer from pointer without a cast
> memory.c: In function `handle_mm_fault':
> memory.c:1339: warning: passing arg 1 of `___f_pmd_alloc' from incompatible pointer type
> memory.c:1339: warning: passing arg 2 of `___f_pmd_alloc' makes integer from pointer without a cast
> memory.c:1342: warning: passing arg 1 of `___f_pte_alloc' from incompatible pointer type
> memory.c:1342: warning: passing arg 2 of `___f_pte_alloc' makes integer from pointer without a cast
> memory.c: In function `__pmd_alloc':
> memory.c:1364: warning: implicit declaration of function `pmd_alloc_one_fast'
> memory.c:1364: warning: assignment makes pointer from integer without a cast
> memory.c:1367: warning: implicit declaration of function `pmd_alloc_one'
> memory.c:1367: warning: assignment makes pointer from integer without a cast
> memory.c:1381: warning: implicit declaration of function `pgd_populate'
> memory.c: At top level:
> memory.c:1393: conflicting types for `___f_pte_alloc'
> /usr/src/linux-2.4.5/include/asm/pgalloc.h:125: previous declaration of `___f_pte_alloc'
> memory.c: In function `___f_pte_alloc':
> memory.c:1398: warning: implicit declaration of function `pte_alloc_one_fast'
> memory.c:1398: `address' undeclared (first use in this function)
> memory.c:1398: (Each undeclared identifier is reported only once
> memory.c:1398: for each function it appears in.)
> memory.c:1398: warning: assignment makes pointer from integer without a cast
> memory.c:1401: warning: implicit declaration of function `pte_alloc_one'
> memory.c:1401: warning: assignment makes pointer from integer without a cast
> memory.c:1415: warning: implicit declaration of function `pmd_populate'
> make[2]: *** [memory.o] Error 1
> make[2]: Leaving directory `/usr/src/linux-2.4.5/mm'
> make[1]: *** [first_rule] Error 2
> make[1]: Leaving directory `/usr/src/linux-2.4.5/mm'
> make: *** [_dir_mm] Error 2
>

-- tia

