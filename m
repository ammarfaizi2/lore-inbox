Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132318AbREIUxo>; Wed, 9 May 2001 16:53:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132338AbREIUxf>; Wed, 9 May 2001 16:53:35 -0400
Received: from tahallah.claranet.co.uk ([212.126.138.206]:36364 "EHLO
	tahallah.clara.co.uk") by vger.kernel.org with ESMTP
	id <S132318AbREIUxZ>; Wed, 9 May 2001 16:53:25 -0400
Date: Wed, 9 May 2001 21:51:29 +0100 (BST)
From: Alex Buell <alex.buell@tahallah.clara.co.uk>
X-X-Sender: <alex@tahallah.clara.co.uk>
Reply-To: <alex.buell@tahallah.clara.co.uk>
To: Mailing List - Linux Kernel <linux-kernel@vger.kernel.org>
Subject: 2.4.4 pmd_alloc/pte_alloc used with too many (3) args with mm/memory.c
Message-ID: <Pine.LNX.4.33.0105092148360.23521-100000@tahallah.clara.co.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Has anyone got a patch to fix the following error when compiling
2.4.4 on SparcStation 4?

make[2]: Entering directory `/usr/src/linux-2.4.4/mm'
gcc -D__KERNEL__ -I/usr/src/linux-2.4.4/include -Wall -Wstrict-prototypes
-O2 -fomit-frame-pointer -fno-strict-aliasing -m32 -pipe -mno-fpu
-fcall-used-g5 -fcall-used-g7    -c -o memory.o memory.c
memory.c:183: macro `pmd_alloc' used with too many (3) args
memory.c:204: macro `pte_alloc' used with too many (3) args
memory.c:725: macro `pte_alloc' used with too many (3) args
memory.c:750: macro `pmd_alloc' used with too many (3) args
memory.c:805: macro `pte_alloc' used with too many (3) args
memory.c:832: macro `pmd_alloc' used with too many (3) args
memory.c:1339: macro `pmd_alloc' used with too many (3) args
memory.c:1342: macro `pte_alloc' used with too many (3) args
memory.c:1392: macro `pte_alloc' used with too many (3) args
memory.c: In function `copy_page_range':
memory.c:183: warning: passing arg 1 of `___f_pmd_alloc' from incompatible
pointer type
memory.c:183: warning: passing arg 2 of `___f_pmd_alloc' makes integer
from pointer without a cast
memory.c:204: warning: passing arg 1 of `___f_pte_alloc' from incompatible
pointer type
memory.c:204: warning: passing arg 2 of `___f_pte_alloc' makes integer
from pointer without a cast
memory.c: In function `zeromap_pmd_range':
memory.c:725: warning: passing arg 1 of `___f_pte_alloc' from incompatible
pointer type
memory.c:725: warning: passing arg 2 of `___f_pte_alloc' makes integer
from pointer without a cast
memory.c: In function `zeromap_page_range':
memory.c:750: warning: passing arg 1 of `___f_pmd_alloc' from incompatible
pointer type
memory.c:750: warning: passing arg 2 of `___f_pmd_alloc' makes integer
from pointer without a cast
memory.c: In function `remap_pmd_range':
memory.c:805: warning: passing arg 1 of `___f_pte_alloc' from incompatible
pointer type
memory.c:805: warning: passing arg 2 of `___f_pte_alloc' makes integer
from pointer without a cast
memory.c: In function `remap_page_range':
memory.c:832: warning: passing arg 1 of `___f_pmd_alloc' from incompatible
pointer type
memory.c:832: warning: passing arg 2 of `___f_pmd_alloc' makes integer
from pointer without a cast
memory.c: In function `handle_mm_fault':
memory.c:1339: warning: passing arg 1 of `___f_pmd_alloc' from
incompatible pointer type
memory.c:1339: warning: passing arg 2 of `___f_pmd_alloc' makes integer
from pointer without a cast
memory.c:1342: warning: passing arg 1 of `___f_pte_alloc' from
incompatible pointer type
memory.c:1342: warning: passing arg 2 of `___f_pte_alloc' makes integer
from pointer without a cast
memory.c: In function `__pmd_alloc':
memory.c:1364: warning: implicit declaration of function
`pmd_alloc_one_fast'
memory.c:1364: warning: assignment makes pointer from integer without a
cast
memory.c:1367: warning: implicit declaration of function `pmd_alloc_one'
memory.c:1367: warning: assignment makes pointer from integer without a
cast
memory.c:1381: warning: implicit declaration of function `pgd_populate'
memory.c: At top level:
memory.c:1393: conflicting types for `___f_pte_alloc'
/usr/src/linux-2.4.4/include/asm/pgalloc.h:125: previous declaration of
`___f_pte_alloc'
memory.c: In function `___f_pte_alloc':
memory.c:1398: warning: implicit declaration of function
`pte_alloc_one_fast'
memory.c:1398: `address' undeclared (first use in this function)
memory.c:1398: (Each undeclared identifier is reported only once
memory.c:1398: for each function it appears in.)
memory.c:1398: warning: assignment makes pointer from integer without a
cast
memory.c:1401: warning: implicit declaration of function `pte_alloc_one'
memory.c:1401: warning: assignment makes pointer from integer without a
cast
memory.c:1415: warning: implicit declaration of function `pmd_populate'
make[2]: *** [memory.o] Error 1
make[2]: Leaving directory `/usr/src/linux-2.4.4/mm'
make[1]: *** [first_rule] Error 2
make[1]: Leaving directory `/usr/src/linux-2.4.4/mm'
make: *** [_dir_mm] Error 2


Alex.
-- 
I fitted a microfusion reactor and antigravity
generators to my car. Now she flies.

http://www.tahallah.clara.co.uk

