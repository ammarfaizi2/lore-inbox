Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291756AbSBANmv>; Fri, 1 Feb 2002 08:42:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291754AbSBANmm>; Fri, 1 Feb 2002 08:42:42 -0500
Received: from server7.suhplains1.com ([12.110.244.153]:26891 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id <S291755AbSBANm2>; Fri, 1 Feb 2002 08:42:28 -0500
Subject: 2.5.3-dj7
From: "Daniel E. Shipton" <dshipton@vrac.iastate.edu>
To: davej@suse.de
Cc: linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <3C59749C.B4855316@lbl.gov>
In-Reply-To: <3C59749C.B4855316@lbl.gov>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0.2 
Date: 31 Jan 2002 19:43:22 -0600
Message-Id: <1012527802.8490.5.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

One of these days the kernel + modules will compile without error for
me.....
but today is not the day....

gcc -D__KERNEL__ -I/home/kernel/linux-2.5/include -Wall
-Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer
-fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2
-march=i686 -DMODULE -DMODVERSIONS -include
/home/kernel/linux-2.5/include/linux/modversions.h 
-DKBUILD_BASENAME=ataraid  -DEXPORT_SYMTAB -c ataraid.c
ataraid.c: In function `ataraid_make_request':
ataraid.c:105: structure has no member named `b_rdev'
ataraid.c:103: warning: `minor' might be used uninitialized in this
function
ataraid.c: In function `ataraid_split_request':
ataraid.c:182: structure has no member named `b_rsector'
ataraid.c:193: warning: passing arg 1 of
`generic_make_request_Rsmp_094ec5c7' makes pointer from integer without
a cast
ataraid.c:193: too many arguments to function
`generic_make_request_Rsmp_094ec5c7'
ataraid.c:194: warning: passing arg 1 of
`generic_make_request_Rsmp_094ec5c7' makes pointer from integer without
a cast
ataraid.c:194: too many arguments to function
`generic_make_request_Rsmp_094ec5c7'
ataraid.c: In function `ataraid_init':
ataraid.c:249: `hardsect_size' undeclared (first use in this function)
ataraid.c:249: (Each undeclared identifier is reported only once
ataraid.c:249: for each function it appears in.)
ataraid.c:280: warning: passing arg 2 of
`blk_queue_make_request_Rsmp_b22de294' from incompatible pointer type
ataraid.c: In function `ataraid_exit':
ataraid.c:289: `hardsect_size' undeclared (first use in this function)
make[2]: *** [ataraid.o] Error 1
make[2]: Leaving directory `/home/kernel/linux-2.5/drivers/ide'
make[1]: *** [_modsubdir_ide] Error 2
make[1]: Leaving directory `/home/kernel/linux-2.5/drivers'
make: *** [_mod_drivers] Error 2
