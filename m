Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135907AbRDTRMW>; Fri, 20 Apr 2001 13:12:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135906AbRDTRMN>; Fri, 20 Apr 2001 13:12:13 -0400
Received: from twilight.cs.hut.fi ([130.233.40.5]:22343 "EHLO
	twilight.cs.hut.fi") by vger.kernel.org with ESMTP
	id <S135898AbRDTRL4>; Fri, 20 Apr 2001 13:11:56 -0400
Date: Fri, 20 Apr 2001 20:11:41 +0300
From: =?ISO-8859-1?Q?Kristian_S=F6derblom?= <ksoderbl@mail.niksula.cs.hut.fi>
To: linux-kernel@vger.kernel.org
Subject: KMALLOC_MAXSIZE undefined in drivers/media/video/buz.c in kernel
 2.4.3
Message-ID: <Pine.SGI.4.20.0104201931480.95651-100000@sparkling.cs.hut.fi>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hello!

	I was compiling kernel 2.4.3 and got this:
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
make[3]: Leaving directory `/usr/src/linux-2.4.3/drivers/media/video'
make[2]: *** [_modsubdir_video] Error 2
make[2]: Leaving directory `/usr/src/linux-2.4.3/drivers/media'
make[1]: *** [_modsubdir_media] Error 2
make[1]: Leaving directory `/usr/src/linux-2.4.3/drivers'
make: *** [_mod_drivers] Error 2

In kernel 2.4.2, instead of KMALLOC_MAXSIZE, there is MAX_KMALLOC_MEM
which is defined at the beginning of the file buz.c (2.4.2) as
(512*1024). The compilation went ok after I did define KMALLOC_MAXSIZE.

There should not be any problem as I don't think I need the buz driver, I
had just unknowingly put at into the config. However, I guess it should be
fixed.

Kristian Söderblom,
wannabe kernel hacker




