Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262655AbREZXDP>; Sat, 26 May 2001 19:03:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262614AbREZXB2>; Sat, 26 May 2001 19:01:28 -0400
Received: from zeus.kernel.org ([209.10.41.242]:20647 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S261968AbREZXAf>;
	Sat, 26 May 2001 19:00:35 -0400
Message-ID: <3B0FEB1B.5030308@centrum.cz>
Date: Sat, 26 May 2001 16:42:51 -0100
From: Jan Sembera <sembera@centrum.cz>
User-Agent: Mozilla/5.0 (X11; U; Linux 2.4.5 i686; en-US; rv:0.9) Gecko/20010507
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: [2.4.5] buz.c won't compile
Content-Type: text/plain; charset=ISO-8859-2; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

i've got a problem compiling drivers/media/video/buz.c as module. When 
i'm trying to compile, i get couple of errors:

gcc -D__KERNEL__ -I/usr/src/linux/include -Wall -Wstrict-prototypes -O2 
-fomit-frame-pointer -fno-strict-aliasing -pipe 
-mpreferred-stack-boundary=2 -march=athlon  -DMODULE -DMODVERSIONS 
-include /usr/src/linux/include/linux/modversions.h   -c -o buz.o buz.c
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
buz.c: In function `zr36057_init':
buz.c:3215: too few arguments to function `video_register_device_Recfe1c4b'
make[3]: *** [buz.o] Error 1
make[3]: Leaving directory `/usr/src/linux/drivers/media/video'
make[2]: *** [_modsubdir_video] Error 2
make[2]: Leaving directory `/usr/src/linux/drivers/media'
make[1]: *** [_modsubdir_media] Error 2
make[1]: Leaving directory `/usr/src/linux/drivers'
make: *** [_mod_drivers] Error 2

Jan Sembera

