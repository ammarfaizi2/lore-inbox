Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317673AbSHDOPk>; Sun, 4 Aug 2002 10:15:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317696AbSHDOPk>; Sun, 4 Aug 2002 10:15:40 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:14576 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id <S317673AbSHDOPj>; Sun, 4 Aug 2002 10:15:39 -0400
Date: Sun, 4 Aug 2002 16:19:07 +0200 (CEST)
From: Adrian Bunk <bunk@fs.tum.de>
X-X-Sender: bunk@mimas.fachschaften.tu-muenchen.de
To: linux-kernel@vger.kernel.org
Subject: 2.5 ide/hd.c compile error: `i' undeclared (first use in this
 function)
Message-ID: <Pine.NEB.4.44.0208041615400.1422-100000@mimas.fachschaften.tu-muenchen.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


When trying to compile 2.5.30-dj1 with using the 2.5 IDE code compilation
fails as follows (it seems the problem is also present in plain 2.5.30):

<--  snip  -->

...
  gcc -Wp,-MD,./.hd.o.d -D__KERNEL__
-I/home/bunk/linux/kernel-2.5/linux-2.5.30-full/include -Wall
-Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common
-pipe -mpreferred-stack-boundary=2 -march=k6 -nostdinc -iwithprefix
include    -DKBUILD_BASENAME=hd   -c -o hd.o hd.c
hd.c: In function `hd_geninit':
hd.c:859: `i' undeclared (first use in this function)
hd.c:859: (Each undeclared identifier is reported only once
hd.c:859: for each function it appears in.)
make[2]: *** [hd.o] Error 1
make[2]: Leaving directory `/home/bunk/linux/kernel-2.5/linux-2.5.30-full/drivers/ide'

<--  snip  -->

cu
Adrian

-- 

You only think this is a free country. Like the US the UK spends a lot of
time explaining its a free country because its a police state.
								Alan Cox

