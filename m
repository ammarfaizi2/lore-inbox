Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265725AbTBKBJl>; Mon, 10 Feb 2003 20:09:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265736AbTBKBJl>; Mon, 10 Feb 2003 20:09:41 -0500
Received: from clem.clem-digital.net ([68.16.168.10]:11537 "EHLO
	clem.clem-digital.net") by vger.kernel.org with ESMTP
	id <S265725AbTBKBJl>; Mon, 10 Feb 2003 20:09:41 -0500
From: Pete Clements <clem@clem.clem-digital.net>
Message-Id: <200302110119.UAA23883@clem.clem-digital.net>
Subject: 2.5.60 fails compile -- net/Space.c -- 3c509
To: linux-kernel@vger.kernel.org (linux-kernel)
Date: Mon, 10 Feb 2003 20:18:11 -0500 (EST)
X-Mailer: ELM [version 2.4ME+ PL48 (25)]
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

FYI:

make -f scripts/Makefile.build obj=drivers/net
  gcc -Wp,-MD,drivers/net/.Space.o.d -D__KERNEL__ -Iinclude -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2 -march=i686 -Iinclude/asm-i386/mach-default -fomit-frame-pointer -nostdinc -iwithprefix include    -DKBUILD_BASENAME=Space -DKBUILD_MODNAME=Space -c -o drivers/net/Space.o drivers/net/Space.c
drivers/net/Space.c:228: `el3_probe' undeclared here (not in a function)
drivers/net/Space.c:228: initializer element is not constant
drivers/net/Space.c:228: (near initialization for `isa_probes[0].probe')
make[2]: *** [drivers/net/Space.o] Error 1

-- 
Pete Clements 
clem@clem.clem-digital.net
