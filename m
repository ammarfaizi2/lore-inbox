Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131652AbRCSXka>; Mon, 19 Mar 2001 18:40:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131653AbRCSXkV>; Mon, 19 Mar 2001 18:40:21 -0500
Received: from chicago.cheek.com ([64.16.171.55]:524 "EHLO chicago.cheek.com")
	by vger.kernel.org with ESMTP id <S131652AbRCSXkL>;
	Mon, 19 Mar 2001 18:40:11 -0500
Message-ID: <3AB698DD.5DAFDBA8@cheek.com>
Date: Mon, 19 Mar 2001 15:40:13 -0800
From: Joseph Cheek <joseph@cheek.com>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.2 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: KMALLOC_MAXSIZE undeclared in drivers/media/video/buz.c
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

2.4.3-pre4.

i also see a reference to KMALLOC_MAXSIZE in
drivers/net/hamradio/6pack.c

this kernel won't compile, is KMALLOC_MAXSIZE set somewhere?  i can't
find it.  is it deprecated?

gcc -D__KERNEL__ -I/usr/src/RedmondLinux/BUILD/linux-2.4.3/linux/include
-Wall -Wstrict-prototypes -O2 -fomit-frame-pointer -fno-strict-aliasing
-pipe -mpreferred-stack-boundary=2 -march=i586 -mcpu=i686 -DMODULE
-DMODVERSIONS -include
/usr/src/RedmondLinux/BUILD/linux-2.4.3/linux/include/linux/modversions.h
-c -o buz.o buz.c
buz.c: In function `v4l_fbuffer_alloc':
buz.c:188: `KMALLOC_MAXSIZE' undeclared (first use in this function)
buz.c:188: (Each undeclared identifier is reported only once
buz.c:188: for each function it appears in.)
buz.c: In function `jpg_fbuffer_alloc':
buz.c:262: `KMALLOC_MAXSIZE' undeclared (first use in this function)
buz.c:256: warning: `alloc_contig' might be used uninitialized in this
function
buz.c: In function `jpg_fbuffer_free':
buz.c:322: `KMALLOC_MAXSIZE' undeclared (first use in this function)
buz.c:316: warning: `alloc_contig' might be used uninitialized in this
function
buz.c: In function `zoran_ioctl':
buz.c:2837: `KMALLOC_MAXSIZE' undeclared (first use in this function)
make[3]: *** [buz.o] Error 1
make[3]: Leaving directory
`/usr/src/RedmondLinux/BUILD/linux-2.4.3/linux/drivers/media/video'
make[2]: *** [_modsubdir_video] Error 2
make[2]: Leaving directory
`/usr/src/RedmondLinux/BUILD/linux-2.4.3/linux/drivers/media'
make[1]: *** [_modsubdir_media] Error 2
make[1]: Leaving directory
`/usr/src/RedmondLinux/BUILD/linux-2.4.3/linux/drivers'
make: *** [_mod_drivers] Error 2

