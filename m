Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263191AbSJGUtU>; Mon, 7 Oct 2002 16:49:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263195AbSJGUtU>; Mon, 7 Oct 2002 16:49:20 -0400
Received: from colossus.systems.pipex.net ([62.241.160.73]:30105 "EHLO
	colossus.systems.pipex.net") by vger.kernel.org with ESMTP
	id <S263191AbSJGUsI>; Mon, 7 Oct 2002 16:48:08 -0400
Subject: Compile failure with 2.5.41 in serial/core.o
From: Alastair Stevens <alastair@altruxsolutions.co.uk>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 
Date: 07 Oct 2002 21:53:44 +0100
Message-Id: <1034024024.1962.15.camel@dolphin.entropy.net>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

RH7.3 : gcc-2.96-112 : Athlon XP

Here's the error when doing "make modules" from a clean build. The "make
bzImage" works fine:

  gcc -Wp,-MD,drivers/serial/.core.o.d -D__KERNEL__ -Iinclude -Wall
-Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer
-fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2
-march=athlon  -Iarch/i386/mach-generic -nostdinc -iwithprefix include
-DMODULE -include include/linux/modversions.h   -DKBUILD_BASENAME=core  
-c -o drivers/serial/core.o drivers/serial/core.c
drivers/serial/core.c:2456: parse error before
`this_object_must_be_defined_as_export_objs_in_the_Makefile'
drivers/serial/core.c:2456: warning: type defaults to `int' in
declaration of
`this_object_must_be_defined_as_export_objs_in_the_Makefile'
drivers/serial/core.c:2456: warning: data definition has no type or
storage class
drivers/serial/core.c:2457: parse error before
`this_object_must_be_defined_as_export_objs_in_the_Makefile'
drivers/serial/core.c:2457: warning: type defaults to `int' in
declaration of
`this_object_must_be_defined_as_export_objs_in_the_Makefile'
drivers/serial/core.c:2457: warning: data definition has no type or
storage class
drivers/serial/core.c:2458: parse error before
`this_object_must_be_defined_as_export_objs_in_the_Makefile'
drivers/serial/core.c:2458: warning: type defaults to `int' in
declaration of
`this_object_must_be_defined_as_export_objs_in_the_Makefile'
drivers/serial/core.c:2458: warning: data definition has no type or
storage class
drivers/serial/core.c:2459: parse error before
`this_object_must_be_defined_as_export_objs_in_the_Makefile'
drivers/serial/core.c:2459: warning: type defaults to `int' in
declaration of
`this_object_must_be_defined_as_export_objs_in_the_Makefile'
drivers/serial/core.c:2459: warning: data definition has no type or
storage class
drivers/serial/core.c:2460: parse error before
`this_object_must_be_defined_as_export_objs_in_the_Makefile'
drivers/serial/core.c:2460: warning: type defaults to `int' in
declaration of
`this_object_must_be_defined_as_export_objs_in_the_Makefile'
drivers/serial/core.c:2460: warning: data definition has no type or
storage class
drivers/serial/core.c:2461: parse error before
`this_object_must_be_defined_as_export_objs_in_the_Makefile'
drivers/serial/core.c:2461: warning: type defaults to `int' in
declaration of
`this_object_must_be_defined_as_export_objs_in_the_Makefile'
drivers/serial/core.c:2461: warning: data definition has no type or
storage class
drivers/serial/core.c:2462: parse error before
`this_object_must_be_defined_as_export_objs_in_the_Makefile'
drivers/serial/core.c:2462: warning: type defaults to `int' in
declaration of
`this_object_must_be_defined_as_export_objs_in_the_Makefile'
drivers/serial/core.c:2462: warning: data definition has no type or
storage class
make[2]: *** [drivers/serial/core.o] Error 1
make[1]: *** [drivers/serial] Error 2
make: *** [drivers] Error 2

_____________________________             o
Alastair Stevens             \           /-'_
Newport : Essex : UK          \   .     |\/(*)   /\__
                               \__  . .(*)   ___/    \______
www.altruxsolutions.co.uk         \_________/               \_________
__________________________________/

GPG fingerprint = 8920 D7B7 D3DE AC8C ECA6  EE8A FEE6 AADA 09D6 2BDB

