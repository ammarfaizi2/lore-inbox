Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283012AbRLQXWC>; Mon, 17 Dec 2001 18:22:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283054AbRLQXVw>; Mon, 17 Dec 2001 18:21:52 -0500
Received: from Expansa.sns.it ([192.167.206.189]:1806 "EHLO Expansa.sns.it")
	by vger.kernel.org with ESMTP id <S283012AbRLQXVk>;
	Mon, 17 Dec 2001 18:21:40 -0500
Date: Tue, 18 Dec 2001 00:21:39 +0100 (CET)
From: Luigi Genoni <kernel@Expansa.sns.it>
To: <linux-kernel@vger.kernel.org>
Subject: 2.5.1 and HP ATARAID support.
Message-ID: <Pine.LNX.4.33.0112180017350.28378-100000@Expansa.sns.it>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

HI, I was compiling kernel 2.5.1 with HPT 370 ataraid support
turned on as a module. I get this error during
compilation:

make[2]: Leaving directory `/usr/src/linux-2.5.1/drivers/hotplug'
make -C ide modules
make[2]: Entering directory `/usr/src/linux-2.5.1/drivers/ide'
gcc -D__KERNEL__ -I/usr/src/linux-2.5.1/include -Wall -Wstrict-prototypes
-Wno-trigraphs -O2 -fomit-frame-pointer -fno-strict-aliasing -fno-common
-pipe -mpreferred-stack-boundary=2 -march=i686 -malign-functions=4
-DMODULE   -c -o ide-cd.o ide-cd.c
gcc -D__KERNEL__ -I/usr/src/linux-2.5.1/include -Wall -Wstrict-prototypes
-Wno-trigraphs -O2 -fomit-frame-pointer -fno-strict-aliasing -fno-common
-pipe -mpreferred-stack-boundary=2 -march=i686 -malign-functions=4
-DMODULE   -DEXPORT_SYMTAB -c ataraid.c
ataraid.c: In function `ataraid_make_request':
ataraid.c:105: structure has no member named `b_rdev'
ataraid.c:103: warning: `minor' might be used uninitialized in this
function
ataraid.c: In function `ataraid_split_request':
ataraid.c:188: structure has no member named `b_rsector'
ataraid.c:199: warning: passing arg 1 of `generic_make_request' makes
pointer from integer without a cast
ataraid.c:199: too many arguments to function `generic_make_request'
ataraid.c:200: warning: passing arg 1 of `generic_make_request' makes
pointer from integer without a cast
ataraid.c:200: too many arguments to function `generic_make_request'
ataraid.c: In function `ataraid_init':
ataraid.c:255: `hardsect_size' undeclared (first use in this function)
ataraid.c:255: (Each undeclared identifier is reported only once
ataraid.c:255: for each function it appears in.)
ataraid.c:287: warning: passing arg 2 of `blk_queue_make_request' from
incompatible pointer type
ataraid.c: In function `ataraid_exit':
ataraid.c:296: `hardsect_size' undeclared (first use in this function)
make[2]: *** [ataraid.o] Error 1
make[2]: Leaving directory `/usr/src/linux-2.5.1/drivers/ide'
make[1]: *** [_modsubdir_ide] Error 2
make[1]: Leaving directory `/usr/src/linux-2.5.1/drivers'
make: *** [_mod_drivers] Error 2

Luigi


