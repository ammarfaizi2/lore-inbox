Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261664AbSKLPcj>; Tue, 12 Nov 2002 10:32:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261836AbSKLPcj>; Tue, 12 Nov 2002 10:32:39 -0500
Received: from mail028.mail.bellsouth.net ([205.152.58.68]:11132 "EHLO
	imf28bis.bellsouth.net") by vger.kernel.org with ESMTP
	id <S261664AbSKLPcI>; Tue, 12 Nov 2002 10:32:08 -0500
Date: Tue, 12 Nov 2002 10:38:47 -0500 (EST)
From: Burton Windle <bwindle@fint.org>
X-X-Sender: bwindle@morpheus
To: linux-kernel@vger.kernel.org
Subject: 2.5.47-bk1: error compiling skbuff.c
Message-ID: <Pine.LNX.4.43.0211121036140.6269-100000@morpheus>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I didn't see this in the archives yet... Linux 2.5.47-bk1, Debian Testing

  gcc -Wp,-MD,net/core/.skbuff.o.d -D__KERNEL__ -Iinclude -Wall
-Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer
-fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2
-march=i686 -Iarch/i386/mach-generic -nostdinc -iwithprefix include
-DKBUILD_BASENAME=skbuff -DKBUILD_MODNAME=skbuff   -c -o net/core/skbuff.o
net/core/skbuff.c
In file included from include/net/xfrm.h:6,
                 from net/core/skbuff.c:61:
include/linux/crypto.h: In function `crypto_tfm_alg_modname':
include/linux/crypto.h:202: dereferencing pointer to incomplete type
include/linux/crypto.h:205: warning: control reaches end of non-void function
make[2]: *** [net/core/skbuff.o] Error 1
make[1]: *** [net/core] Error 2
make: *** [net] Error 2


CONFIG_SECURITY_CAPABILITIES=y
# CONFIG_CRYPTO is not set



Linux razor 2.5.46 #1 Fri Nov 8 17:34:37 EST 2002 i686 Pentium II
(Klamath) GenuineIntel GNU/Linux

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


--
Burton Windle                           burton@fint.org
Linux: the "grim reaper of innocent orphaned children."
          from /usr/src/linux-2.4.18/init/main.c:461


