Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132563AbRD1RYS>; Sat, 28 Apr 2001 13:24:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132567AbRD1RYJ>; Sat, 28 Apr 2001 13:24:09 -0400
Received: from [211.58.12.104] ([211.58.12.104]:14598 "EHLO progress.plw.net")
	by vger.kernel.org with ESMTP id <S132563AbRD1RXv>;
	Sat, 28 Apr 2001 13:23:51 -0400
Date: Sun, 29 Apr 2001 02:23:37 +0900 (KST)
From: Byeong-ryeol Kim <jinbo21@hananet.net>
Reply-To: Byeong-ryeol Kim <jinbo21@hananet.net>
To: <linux-kernel@vger.kernel.org>
Subject: buz.c of 2.4.4
Message-ID: <Pine.LNX.4.33.0104290210480.581-100000@progress.plw.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I met follwing erros which was workarounded by put
define KMALLOC_MAXSIZE	131072
borrowed from af_unix.c of 2.4.3-ac14. But I'm convinced of this.
below lines were wrapped by me for readabilities' sake.
....
-D__KERNEL__ -I/usr/src/linux-2.4.4/include -Wall -Wstrict-prototypes -O2
-fomit-frame-pointer -fno-strict-aliasing -pipe -mpreferred-stack-boundary=2 \
-march=k6 -DMODULE -DMODVERSIONS -include \
/usr/src/linux-2.4.4/include/linux/modversions.h   -c -o buz.o buz.c
buz.c: In function `v4l_fbuffer_alloc':
buz.c:188: `KMALLOC_MAXSIZE' undeclared (first use in this function)
buz.c:188: (Each undeclared identifier is reported only once
buz.c:188: for each function it appears in.)
buz.c: In function `jpg_fbuffer_alloc':
buz.c:262: `KMALLOC_MAXSIZE' undeclared (first use in this function)
buz.c:256: warning: `alloc_contig' might be used uninitialized in this function
buz.c: In function `jpg_fbuffer_free':
buz.c:322: `KMALLOC_MAXSIZE' undeclared (first use in this function)
buz.c:316: warning: `alloc_contig' might be used uninitialized in this function
buz.c: In function `zoran_ioctl':
buz.c:2837: `KMALLOC_MAXSIZE' undeclared (first use in this function)
make[3]: *** [buz.o] Error 1
make[3]: Leaving directory `/usr/src/linux-2.4.4/drivers/media/video'
make[2]: *** [_modsubdir_video] Error 2
make[2]: Leaving directory `/usr/src/linux-2.4.4/drivers/media'
make[1]: *** [_modsubdir_media] Error 2
make[1]: Leaving directory `/usr/src/linux-2.4.4/drivers'
make: *** [_mod_drivers] Error 2
....

