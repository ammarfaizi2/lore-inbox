Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267717AbSLGFQJ>; Sat, 7 Dec 2002 00:16:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267719AbSLGFQJ>; Sat, 7 Dec 2002 00:16:09 -0500
Received: from bitmover.com ([192.132.92.2]:2524 "EHLO mail.bitmover.com")
	by vger.kernel.org with ESMTP id <S267717AbSLGFQH>;
	Sat, 7 Dec 2002 00:16:07 -0500
Date: Fri, 6 Dec 2002 21:23:42 -0800
From: Larry McVoy <lm@bitmover.com>
Message-Id: <200212070523.gB75Ng932574@work.bitmover.com>
To: linux-kernel@vger.kernel.org
Subject: compile problem in current BK 2.5
X-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

FYI 

make -f scripts/Makefile.build obj=drivers/block
  gcc -Wp,-MD,drivers/block/.nbd.o.d -D__KERNEL__ -Iinclude -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2 -march=athlon -Iarch/i386/mach-generic -fomit-frame-pointer -nostdinc -iwithprefix include    -DKBUILD_BASENAME=nbd -DKBUILD_MODNAME=nbd   -c -o drivers/block/nbd.o drivers/block/nbd.c
In file included from drivers/block/nbd.c:56:
include/linux/nbd.h:87:2: #endif without #if
drivers/block/nbd.c:71: warning: `struct request' declared inside parameter list
drivers/block/nbd.c:71: warning: its scope is only this definition or declaration, which is probably not what you want.
drivers/block/nbd.c: In function `nbd_end_request':
drivers/block/nbd.c:73: dereferencing pointer to incomplete type
drivers/block/nbd.c:74: `request_queue_t' undeclared (first use in this function)
drivers/block/nbd.c:74: (Each undeclared identifier is reported only once
drivers/block/nbd.c:74: for each function it appears in.)
drivers/block/nbd.c:74: `q' undeclared (first use in this function)
drivers/block/nbd.c:74: dereferencing pointer to incomplete type
drivers/block/nbd.c:75: parse error before `struct'
drivers/block/nbd.c:82: `flags' undeclared (first use in this function)
drivers/block/nbd.c:83: `bio' undeclared (first use in this function)
drivers/block/nbd.c:83: dereferencing pointer to incomplete type
drivers/block/nbd.c:84: `nsect' undeclared (first use in this function)
drivers/block/nbd.c:85: warning: implicit declaration of function `blk_finished_io'
drivers/block/nbd.c:86: dereferencing pointer to incomplete type
drivers/block/nbd.c:90: warning: implicit declaration of function `blk_put_request'
drivers/block/nbd.c: In function `nbd_open':
drivers/block/nbd.c:96: dereferencing pointer to incomplete type
drivers/block/nbd.c: At top level:
drivers/block/nbd.c:176: warning: `struct request' declared inside parameter list
drivers/block/nbd.c: In function `nbd_send_req':
drivers/block/nbd.c:180: dereferencing pointer to incomplete type
