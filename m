Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262490AbTD3XLl (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Apr 2003 19:11:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262494AbTD3XLl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Apr 2003 19:11:41 -0400
Received: from pointblue.com.pl ([62.89.73.6]:31501 "EHLO pointblue.com.pl")
	by vger.kernel.org with ESMTP id S262490AbTD3XLi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Apr 2003 19:11:38 -0400
Subject: 2.5.68-bk10 blkmtd.c:219: warning: implicit declaration of
	function `alloc_kiovec'
From: Grzegorz Jaskiewicz <gj@pointblue.com.pl>
To: lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Organization: K4 labs
Message-Id: <1051745126.5274.22.camel@flat41>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 01 May 2003 00:25:26 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Well, "burned" on ieee1394 i will not try to patch it my self :)
Anyway, i can live without those drivers :)
make -f scripts/Makefile.build obj=drivers/mtd/devices
  gcc -Wp,-MD,drivers/mtd/devices/.blkmtd.o.d -D__KERNEL__ -Iinclude
-Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing
-fno-common -pipe -mpreferred-stack-boundary=2 -march=i686
-falign-functions=0 -falign-jumps=0 -falign-loops=0
-Iinclude/asm-i386/mach-default -fomit-frame-pointer -nostdinc
-iwithprefix include -DMODULE   -DKBUILD_BASENAME=blkmtd
-DKBUILD_MODNAME=blkmtd -c -o drivers/mtd/devices/.tmp_blkmtd.o
drivers/mtd/devices/blkmtd.c
drivers/mtd/devices/blkmtd.c:52:25: linux/iobuf.h: No such file or
directory
drivers/mtd/devices/blkmtd.c: In function `blkmtd_readpage':
drivers/mtd/devices/blkmtd.c:219: warning: implicit declaration of
function `alloc_kiovec'
drivers/mtd/devices/blkmtd.c:236: dereferencing pointer to incomplete
type
drivers/mtd/devices/blkmtd.c:239: dereferencing pointer to incomplete
type
drivers/mtd/devices/blkmtd.c:240: dereferencing pointer to incomplete
type
drivers/mtd/devices/blkmtd.c:241: dereferencing pointer to incomplete
type
drivers/mtd/devices/blkmtd.c:242: dereferencing pointer to incomplete
type
drivers/mtd/devices/blkmtd.c:243: dereferencing pointer to incomplete
type
drivers/mtd/devices/blkmtd.c:265: warning: implicit declaration of
function `brw_kiovec'
drivers/mtd/devices/blkmtd.c:267: dereferencing pointer to incomplete
type
drivers/mtd/devices/blkmtd.c:268: warning: implicit declaration of
function `free_kiovec'
drivers/mtd/devices/blkmtd.c:169: warning: unused variable `b'
drivers/mtd/devices/blkmtd.c: In function `write_queue_task':
drivers/mtd/devices/blkmtd.c:323: dereferencing pointer to incomplete
type
drivers/mtd/devices/blkmtd.c:351: `KIO_MAX_SECTORS' undeclared (first
use in this function)
drivers/mtd/devices/blkmtd.c:351: (Each undeclared identifier is
reported only once
drivers/mtd/devices/blkmtd.c:351: for each function it appears in.)
drivers/mtd/devices/blkmtd.c:369: dereferencing pointer to incomplete
type
drivers/mtd/devices/blkmtd.c:370: dereferencing pointer to incomplete
type
drivers/mtd/devices/blkmtd.c:382: dereferencing pointer to incomplete
type
drivers/mtd/devices/blkmtd.c:384: dereferencing pointer to incomplete
type
drivers/mtd/devices/blkmtd.c:392: dereferencing pointer to incomplete
type
drivers/mtd/devices/blkmtd.c:393: dereferencing pointer to incomplete
type
drivers/mtd/devices/blkmtd.c:407: dereferencing pointer to incomplete
type
drivers/mtd/devices/blkmtd.c: In function `blkmtd_erase':
drivers/mtd/devices/blkmtd.c:527: warning: unused variable `b'
drivers/mtd/devices/blkmtd.c: In function `blkmtd_read':
drivers/mtd/devices/blkmtd.c:640: warning: unused variable `b'
drivers/mtd/devices/blkmtd.c: In function `blkmtd_write':
drivers/mtd/devices/blkmtd.c:713: syntax error before "e3"
drivers/mtd/devices/blkmtd.c:712: warning: unused variable `b'
drivers/mtd/devices/blkmtd.c: In function `init_blkmtd':
drivers/mtd/devices/blkmtd.c:1060: warning: unused variable `b'
make[3]: *** [drivers/mtd/devices/blkmtd.o] Error 1
make[2]: *** [drivers/mtd/devices] Error 2
make[1]: *** [drivers/mtd] Error 2
make: *** [drivers] Error 2

-- 
Grzegorz Jaskiewicz <gj@pointblue.com.pl>
K4 labs

