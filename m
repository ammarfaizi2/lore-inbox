Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261379AbTDDWVL (for <rfc822;willy@w.ods.org>); Fri, 4 Apr 2003 17:21:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261380AbTDDWVL (for <rfc822;linux-kernel-outgoing>); Fri, 4 Apr 2003 17:21:11 -0500
Received: from tomts16-srv.bellnexxia.net ([209.226.175.4]:49804 "EHLO
	tomts16-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id S261379AbTDDWVJ (for <rfc822;linux-kernel@vger.kernel.org>); Fri, 4 Apr 2003 17:21:09 -0500
Date: Fri, 4 Apr 2003 17:28:37 -0500 (EST)
From: "Robert P. J. Day" <rpjday@mindspring.com>
X-X-Sender: rpjday@localhost.localdomain
To: Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: error building MTD modules in 2.5.66-bk10
Message-ID: <Pine.LNX.4.44.0304041727460.7451-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


  trying to build a kernel with some MTD functionality
for 2.5.66-bk10 generates:


make -f scripts/Makefile.build obj=drivers/mtd
make -f scripts/Makefile.build obj=drivers/mtd/chips
make -f scripts/Makefile.build obj=drivers/mtd/devices
  gcc -Wp,-MD,drivers/mtd/devices/.blkmtd.o.d -D__KERNEL__ -Iinclude -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2 -march=pentium3 -Iinclude/asm-i386/mach-default -fomit-frame-pointer -nostdinc -iwithprefix include -DMODULE   -DKBUILD_BASENAME=blkmtd -DKBUILD_MODNAME=blkmtd -c -o drivers/mtd/devices/blkmtd.o drivers/mtd/devices/blkmtd.c
drivers/mtd/devices/blkmtd.c:52:25: linux/iobuf.h: No such file or directory
drivers/mtd/devices/blkmtd.c: In function `blkmtd_readpage':
drivers/mtd/devices/blkmtd.c:219: warning: implicit declaration of function `alloc_kiovec'
drivers/mtd/devices/blkmtd.c:236: dereferencing pointer to incomplete type
drivers/mtd/devices/blkmtd.c:239: dereferencing pointer to incomplete type
drivers/mtd/devices/blkmtd.c:240: dereferencing pointer to incomplete type
drivers/mtd/devices/blkmtd.c:241: dereferencing pointer to incomplete type
drivers/mtd/devices/blkmtd.c:242: dereferencing pointer to incomplete type
drivers/mtd/devices/blkmtd.c:243: dereferencing pointer to incomplete type
drivers/mtd/devices/blkmtd.c:265: warning: implicit declaration of function `brw_kiovec'
drivers/mtd/devices/blkmtd.c:267: dereferencing pointer to incomplete type
drivers/mtd/devices/blkmtd.c:268: warning: implicit declaration of function `free_kiovec'
drivers/mtd/devices/blkmtd.c:169: warning: unused variable `b'
drivers/mtd/devices/blkmtd.c: In function `write_queue_task':
drivers/mtd/devices/blkmtd.c:323: dereferencing pointer to incomplete type
drivers/mtd/devices/blkmtd.c:351: `KIO_MAX_SECTORS' undeclared (first use in this function)
drivers/mtd/devices/blkmtd.c:351: (Each undeclared identifier is reported only once
drivers/mtd/devices/blkmtd.c:351: for each function it appears in.)
drivers/mtd/devices/blkmtd.c:369: dereferencing pointer to incomplete type
drivers/mtd/devices/blkmtd.c:370: dereferencing pointer to incomplete type
drivers/mtd/devices/blkmtd.c:382: dereferencing pointer to incomplete type
drivers/mtd/devices/blkmtd.c:384: dereferencing pointer to incomplete type
drivers/mtd/devices/blkmtd.c:392: dereferencing pointer to incomplete type
drivers/mtd/devices/blkmtd.c:393: dereferencing pointer to incomplete type
drivers/mtd/devices/blkmtd.c:407: dereferencing pointer to incomplete type
drivers/mtd/devices/blkmtd.c: In function `blkmtd_erase':
drivers/mtd/devices/blkmtd.c:527: warning: unused variable `b'
drivers/mtd/devices/blkmtd.c: In function `blkmtd_read':
drivers/mtd/devices/blkmtd.c:640: warning: unused variable `b'
drivers/mtd/devices/blkmtd.c: In function `blkmtd_write':
drivers/mtd/devices/blkmtd.c:713: parse error before "e3"
drivers/mtd/devices/blkmtd.c:712: warning: unused variable `b'
drivers/mtd/devices/blkmtd.c: In function `init_blkmtd':
drivers/mtd/devices/blkmtd.c:1067: warning: unused variable `b'
make[3]: *** [drivers/mtd/devices/blkmtd.o] Error 1
make[2]: *** [drivers/mtd/devices] Error 2
make[1]: *** [drivers/mtd] Error 2
make: *** [drivers] Error 2



rday

