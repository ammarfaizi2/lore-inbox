Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262210AbSLJOzf>; Tue, 10 Dec 2002 09:55:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262215AbSLJOzf>; Tue, 10 Dec 2002 09:55:35 -0500
Received: from mail106.mail.bellsouth.net ([205.152.58.46]:17269 "EHLO
	imf06bis.bellsouth.net") by vger.kernel.org with ESMTP
	id <S262210AbSLJOze>; Tue, 10 Dec 2002 09:55:34 -0500
Date: Tue, 10 Dec 2002 10:02:21 -0500 (EST)
From: Burton Windle <bwindle@fint.org>
X-X-Sender: bwindle@morpheus
To: linux-kernel@vger.kernel.org
cc: adam@yggdrasil.com
Subject: [2.5.51] unknown field 'driver_data' compiling cs4243
Message-ID: <Pine.LNX.4.43.0212100956320.18580-100000@morpheus>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm getting an error compiling cs4232 in 2.5.51. It built fine in 50-bk6.

  gcc -Wp,-MD,sound/oss/.cs4232.o.d -D__KERNEL__ -Iinclude -Wall
-Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-al
iasing -fno-common -pipe -mpreferred-stack-boundary=2 -march=i686
-Iarch/i386/mach-generic -nostdinc -iwithprefix incl
ude    -DKBUILD_BASENAME=cs4232 -DKBUILD_MODNAME=cs4232   -c -o
sound/oss/cs4232.o sound/oss/cs4232.c
sound/oss/cs4232.c:361: unknown field `driver_data' specified in initializer
sound/oss/cs4232.c:362: unknown field `driver_data' specified in initializer
sound/oss/cs4232.c:365: unknown field `driver_data' specified in initializer
sound/oss/cs4232.c: In function `cs4232_pnp_probe':
sound/oss/cs4232.c:389: warning: passing arg 1 of `pci_set_drvdata' from incompatible pointer type
sound/oss/cs4232.c: In function `cs4232_pnp_remove':
sound/oss/cs4232.c:395: structure has no member named `driver_data'
sound/oss/cs4232.c: At top level:
sound/oss/cs4232.c:402: unknown field `card_id_table' specified in initializer
sound/oss/cs4232.c:403: duplicate initializer
sound/oss/cs4232.c:403: (near initialization for `cs4232_driver.id_table')
sound/oss/cs4232.c:404: warning: initialization from incompatible pointer type
sound/oss/cs4232.c:327: warning: `synthirq' defined but not used
make[2]: *** [sound/oss/cs4232.o] Error 1
make[1]: *** [sound/oss] Error 2
make: *** [sound] Error 2


CONFIG_PNP=y
CONFIG_PNP_NAMES=y
CONFIG_PNPBIOS=y

CONFIG_SOUND=y
CONFIG_SOUND_PRIME=y
CONFIG_SOUND_OSS=y
CONFIG_SOUND_TRACEINIT=y
CONFIG_SOUND_CS4232=y

Gnu C                  2.95.4
Gnu make               3.79.1
util-linux             2.11n
mount                  2.11n
modutils               2.4.19
e2fsprogs              1.30-WIP
Linux C Library        2.2.5
Dynamic linker (ldd)   2.2.5
Procps                 2.0.7
Net-tools              1.60
Console-tools          0.2.3
Sh-utils               4.5.2
Modules Loaded



--
Burton Windle                           burton@fint.org
Linux: the "grim reaper of innocent orphaned children."
          from /usr/src/linux-2.4.18/init/main.c:461


