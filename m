Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131820AbRDCOPf>; Tue, 3 Apr 2001 10:15:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131899AbRDCOP0>; Tue, 3 Apr 2001 10:15:26 -0400
Received: from rdu163-40-153.nc.rr.com ([24.163.40.153]:39434 "EHLO
	kaitan.hacknslash.net") by vger.kernel.org with ESMTP
	id <S131820AbRDCOPK>; Tue, 3 Apr 2001 10:15:10 -0400
Date: Tue, 3 Apr 2001 10:14:24 -0400 (EDT)
From: Jeff Layton <jtlayton@bigfoot.com>
To: linux-kernel@vger.kernel.org
Subject: cannot compile 2.4.3 on SPARC
Message-ID: <Pine.LNX.4.21.0104030949580.24433-100000@kaitan.hacknslash.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm unable to compile 2.4.3 on SPARC architecture. I'm willing to test
patches that fix this -- please email me with them directly for faster
response.

Here's where it barfs:

gcc -D__KERNEL__ -I/usr/src/linux/include -Wall -Wstrict-prototypes -O2
-fomit-frame-pointer -fno-strict-aliasing -m32 -pipe -mno-fpu
-fcall-used-g5 -fcall-used-g7    -c -o memory.o memory.c
memory.c:183: macro `pmd_alloc' used with too many (3) args
memory.c:204: macro `pte_alloc' used with too many (3) args
memory.c:668: macro `pte_alloc' used with too many (3) args
memory.c:693: macro `pmd_alloc' used with too many (3) args
memory.c:748: macro `pte_alloc' used with too many (3) args
memory.c:775: macro `pmd_alloc' used with too many (3) args
memory.c:1263: macro `pmd_alloc' used with too many (3) args
memory.c:1266: macro `pte_alloc' used with too many (3) args
memory.c:1316: macro `pte_alloc' used with too many (3) args
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
memory.c:668: warning: passing arg 1 of `___f_pte_alloc' from incompatible
pointer type
memory.c:668: warning: passing arg 2 of `___f_pte_alloc' makes integer
from pointer without a cast
memory.c: In function `zeromap_page_range':
memory.c:693: warning: passing arg 1 of `___f_pmd_alloc' from incompatible
pointer type
memory.c:693: warning: passing arg 2 of `___f_pmd_alloc' makes integer
from pointer without a cast
memory.c: In function `remap_pmd_range':
memory.c:748: warning: passing arg 1 of `___f_pte_alloc' from incompatible
pointer type
memory.c:748: warning: passing arg 2 of `___f_pte_alloc' makes integer
from pointer without a cast
memory.c: In function `remap_page_range':
memory.c:775: warning: passing arg 1 of `___f_pmd_alloc' from incompatible
pointer type
memory.c:775: warning: passing arg 2 of `___f_pmd_alloc' makes integer
from pointer without a cast
memory.c: In function `handle_mm_fault':
memory.c:1263: warning: passing arg 1 of `___f_pmd_alloc' from
incompatible pointer type
memory.c:1263: warning: passing arg 2 of `___f_pmd_alloc' makes integer
from pointer without a cast
memory.c:1266: warning: passing arg 1 of `___f_pte_alloc' from
incompatible pointer type
memory.c:1266: warning: passing arg 2 of `___f_pte_alloc' makes integer
from pointer without a cast
memory.c: In function `__pmd_alloc':
memory.c:1288: warning: implicit declaration of function
`pmd_alloc_one_fast'
memory.c:1288: warning: assignment makes pointer from integer without a
cast
memory.c:1291: warning: implicit declaration of function `pmd_alloc_one'
memory.c:1291: warning: assignment makes pointer from integer without a
cast
memory.c:1305: warning: implicit declaration of function `pgd_populate'
memory.c: At top level:
memory.c:1317: conflicting types for `___f_pte_alloc'
/usr/src/linux/include/asm/pgalloc.h:125: previous declaration of
`___f_pte_alloc'
memory.c: In function `___f_pte_alloc':
memory.c:1322: warning: implicit declaration of function
`pte_alloc_one_fast'
memory.c:1322: `address' undeclared (first use in this function)
memory.c:1322: (Each undeclared identifier is reported only once
memory.c:1322: for each function it appears in.)
memory.c:1322: warning: assignment makes pointer from integer without a
cast
memory.c:1325: warning: implicit declaration of function `pte_alloc_one'
memory.c:1325: warning: assignment makes pointer from integer without a
cast
memory.c:1339: warning: implicit declaration of function `pmd_populate'
make[2]: *** [memory.o] Error 1
make[2]: Leaving directory `/usr/src/linux/mm'
make[1]: *** [first_rule] Error 2
make[1]: Leaving directory `/usr/src/linux/mm'
make: *** [_dir_mm] Error 2

--
Jeff Layton (jtlayton@bigfoot.com)

