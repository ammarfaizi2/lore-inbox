Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131232AbRC3JP7>; Fri, 30 Mar 2001 04:15:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131233AbRC3JPt>; Fri, 30 Mar 2001 04:15:49 -0500
Received: from web1502.mail.yahoo.com ([128.11.23.180]:62224 "HELO
	web1502.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S131232AbRC3JPl>; Fri, 30 Mar 2001 04:15:41 -0500
Message-ID: <20010330091500.2583.qmail@web1502.mail.yahoo.com>
Date: Fri, 30 Mar 2001 01:15:00 -0800 (PST)
From: Jeffrey Ingber <jhingber@yahoo.com>
Subject: build of Zoran ZR36060 driver broken in 2.4.3
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The build of the Zoran ZR36060 driver appears to be
broken when building buz.c.  FYI, I don't even have
the option "Include Support for Iomga Buz" selected.

SuSE 7.1, gcc 2.95.2, on a dual i686 BX

make -C video modules
make[3]: Entering directory
`/usr/src/linux-2.4.3-64GB-SMP/drivers/media/video'
gcc -D__KERNEL__
-I/usr/src/linux-2.4.3-64GB-SMP/include -Wall
-Wstrict-prototypes -O2 -fomit-frame-pointer
-fno-strict-aliasing -pipe
-mpreferred-stack-boundary=2 -march=i686 -DMODULE
-DMODVERSIONS -include
/usr/src/linux-2.4.3-64GB-SMP/include/linux/modversions.h
  -DEXPORT_SYMTAB -c videodev.c
gcc -D__KERNEL__
-I/usr/src/linux-2.4.3-64GB-SMP/include -Wall
-Wstrict-prototypes -O2 -fomit-frame-pointer
-fno-strict-aliasing -pipe
-mpreferred-stack-boundary=2 -march=i686 -DMODULE
-DMODVERSIONS -include
/usr/src/linux-2.4.3-64GB-SMP/include/linux/modversions.h
  -c -o buz.o buz.c
buz.c: In function `v4l_fbuffer_alloc':
buz.c:188: `KMALLOC_MAXSIZE' undeclared (first use in
this function)
buz.c:188: (Each undeclared identifier is reported
only once
buz.c:188: for each function it appears in.)
buz.c: In function `jpg_fbuffer_alloc':
buz.c:262: `KMALLOC_MAXSIZE' undeclared (first use in
this function)
buz.c:256: warning: `alloc_contig' might be used
uninitialized in this function
buz.c: In function `jpg_fbuffer_free':
buz.c:322: `KMALLOC_MAXSIZE' undeclared (first use in
this function)
buz.c:316: warning: `alloc_contig' might be used
uninitialized in this function
buz.c: In function `zoran_ioctl':
buz.c:2837: `KMALLOC_MAXSIZE' undeclared (first use in
this function)
make[3]: *** [buz.o] Error 1
make[3]: Leaving directory
`/usr/src/linux-2.4.3-64GB-SMP/drivers/media/video'
make[2]: *** [_modsubdir_video] Error 2
make[2]: Leaving directory
`/usr/src/linux-2.4.3-64GB-SMP/drivers/media'
make[1]: *** [_modsubdir_media] Error 2
make[1]: Leaving directory
`/usr/src/linux-2.4.3-64GB-SMP/drivers'
make: *** [_mod_drivers] Error 2


__________________________________________________
Do You Yahoo!?
Get email at your own domain with Yahoo! Mail. 
http://personal.mail.yahoo.com/?.refer=text
