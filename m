Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263232AbSJTQwx>; Sun, 20 Oct 2002 12:52:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263249AbSJTQwx>; Sun, 20 Oct 2002 12:52:53 -0400
Received: from roc-24-169-118-30.rochester.rr.com ([24.169.118.30]:35030 "EHLO
	death.krwtech.com") by vger.kernel.org with ESMTP
	id <S263232AbSJTQww>; Sun, 20 Oct 2002 12:52:52 -0400
Date: Sun, 20 Oct 2002 12:58:49 -0400 (EDT)
From: Ken Witherow <ken@krwtech.com>
X-X-Sender: ken@death
Reply-To: Ken Witherow <ken@krwtech.com>
To: linux-kernel@vger.kernel.org
Subject: compile failure in i2o_block.c on 2.5.44
Message-ID: <Pine.LNX.4.44.0210201256100.14962-100000@death>
Organization: KRW Technologies
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

stock 2.5.44 using gcc 3.2

  gcc -Wp,-MD,drivers/message/i2o/.i2o_block.o.d -D__KERNEL__ -Iinclude
-Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer
-fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2
-march=athlon  -Iarch/i386/mach-generic -nostdinc -iwithprefix include
-DKBUILD_BASENAME=i2o_block   -c -o drivers/message/i2o/i2o_block.o
drivers/message/i2o/i2o_block.c
drivers/message/i2o/i2o_block.c:58:2: #error Please convert me to
Documentation/DMA-mapping.txt
drivers/message/i2o/i2o_block.c: In function `i2ob_send':
drivers/message/i2o/i2o_block.c:363: warning: comparison between pointer
and integer
drivers/message/i2o/i2o_block.c: In function `i2ob_scan':
drivers/message/i2o/i2o_block.c:1376: `i2o_disk' undeclared (first use in
this function)
drivers/message/i2o/i2o_block.c:1376: (Each undeclared identifier is
reported only once
drivers/message/i2o/i2o_block.c:1376: for each function it appears in.)
drivers/message/i2o/i2o_block.c: In function `i2ob_new_device':
drivers/message/i2o/i2o_block.c:1463: `i2o_disk' undeclared (first use in
this function)
drivers/message/i2o/i2o_block.c: In function `i2o_block_init':
drivers/message/i2o/i2o_block.c:1647: `i2o_disk' undeclared (first use in
this function)
drivers/message/i2o/i2o_block.c:1671: warning: initialization from
incompatible pointer type
drivers/message/i2o/i2o_block.c: In function `i2o_block_exit':
drivers/message/i2o/i2o_block.c:1773: `i2o_disk' undeclared (first use in
this function)
make[3]: *** [drivers/message/i2o/i2o_block.o] Error 1


-- 
       Ken Witherow <phantoml AT rochester.rr.com>
           ICQ: 21840670  AIM: phantomlordken
               http://www.krwtech.com/ken


