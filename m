Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284133AbRLAPuc>; Sat, 1 Dec 2001 10:50:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284132AbRLAPuW>; Sat, 1 Dec 2001 10:50:22 -0500
Received: from chello212186127068.14.vie.surfer.at ([212.186.127.68]:34052
	"EHLO server.home.at") by vger.kernel.org with ESMTP
	id <S284133AbRLAPuK>; Sat, 1 Dec 2001 10:50:10 -0500
Subject: 2.5.1-pre5 compile error in ataraid.c
From: Christian Thalinger <e9625286@student.tuwien.ac.at>
To: linux-kernel <linux-kernel@vger.kernel.org>,
        Arjan van de Ven <arjanv@redhat.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.99.2 (Preview Release)
Date: 01 Dec 2001 16:49:52 +0100
Message-Id: <1007221793.638.2.camel@twisti.home.at>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


gcc -D__KERNEL__ -I/usr/src/linux-2.5.1-pre5/include -Wall
-Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer
-fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2
-march=athlon     -DEXPORT_SYMTAB -c ataraid.c
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
make[3]: *** [ataraid.o] Error 1
make[3]: Leaving directory `/usr/src/linux-2.5.1-pre5/drivers/ide'
make[2]: *** [first_rule] Error 2
make[2]: Leaving directory `/usr/src/linux-2.5.1-pre5/drivers/ide'
make[1]: *** [_subdir_ide] Error 2
make[1]: Leaving directory `/usr/src/linux-2.5.1-pre5/drivers'
make: *** [_dir_drivers] Error 2



