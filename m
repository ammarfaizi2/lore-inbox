Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317619AbSGFFnG>; Sat, 6 Jul 2002 01:43:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317620AbSGFFnF>; Sat, 6 Jul 2002 01:43:05 -0400
Received: from port5.ds1-sby.adsl.cybercity.dk ([212.242.169.198]:48432 "EHLO
	trider-g7.fabbione.net") by vger.kernel.org with ESMTP
	id <S317619AbSGFFnE>; Sat, 6 Jul 2002 01:43:04 -0400
Message-ID: <3D26840C.9010906@fabbione.net>
Date: Sat, 06 Jul 2002 07:45:48 +0200
From: Fabio Massimo Di Nitto <fabbione@fabbione.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/20020615 Debian/1.0.0-3
X-Accept-Language: en
MIME-Version: 1.0
To: LKML <linux-kernel@vger.kernel.org>
Subject: Re: linux 2.5.25 (different compilation errors)
References: <200207050047.30425.ivangurdiev@attbi.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,
            some small other problems.

make dep claims that i2c-old.h is missing. (also in 2.5.24, not tested 
in other versions)

----

  gcc -Wp,-MD,./.iforce-packets.o.d -D__KERNEL__ 
-I/usr/src/linux-2.5.25/include -Wall -Wstrict-prototypes -Wno-trigraphs 
-O2 -fomit-frame-pointer -fno-strict-aliasing -fno-common -pipe 
-mpreferred-stack-boundary=2 -march=i686 -nostdinc -iwithprefix include 
-DMODULE -include /usr/src/linux-2.5.25/include/linux/modversions.h   
-DKBUILD_BASENAME=iforce_packets   -c -o iforce-packets.o iforce-packets.c
iforce-packets.c: In function `iforce_get_id_packet':
iforce-packets.c:252: `IFORCE_USB' undeclared (first use in this function)
iforce-packets.c:252: (Each undeclared identifier is reported only once
iforce-packets.c:252: for each function it appears in.)
iforce-packets.c:282: `IFORCE_232' undeclared (first use in this function)
iforce-packets.c:278: warning: unreachable code at beginning of switch 
statement
iforce-packets.c:248: warning: unused variable `timeout'
iforce-packets.c:247: warning: unused variable `wait'
make[4]: *** [iforce-packets.o] Error 1
make[4]: Leaving directory 
`/usr/src/linux-2.5.25/drivers/input/joystick/iforce'

----

  gcc -Wp,-MD,./.zr36120.o.d -D__KERNEL__ 
-I/usr/src/linux-2.5.25/include -Wall -Wstrict-prototypes -Wno-trigraphs 
-O2 -fomit-frame-pointer -fno-strict-aliasing -fno-common -pipe 
-mpreferred-stack-boundary=2 -march=i686 -nostdinc -iwithprefix include 
-DMODULE -include /usr/src/linux-2.5.25/include/linux/modversions.h   
-DKBUILD_BASENAME=zr36120   -c -o zr36120.o zr36120.c
zr36120.c:1497: unknown field `open' specified in initializer
zr36120.c:1497: warning: initialization makes integer from pointer 
without a cast
zr36120.c:1498: unknown field `close' specified in initializer
zr36120.c:1498: warning: initialization from incompatible pointer type

[SNIP]

zr36120.c:1839: unknown field `minor' specified in initializer
make[3]: *** [zr36120.o] Error 1
make[3]: Leaving directory `/usr/src/linux-2.5.25/drivers/media/video'
make[2]: *** [video] Error 2
make[2]: Leaving directory `/usr/src/linux-2.5.25/drivers/media'
make[1]: *** [media] Error 2
make[1]: Leaving directory `/usr/src/linux-2.5.25/drivers'
make: *** [drivers] Error 2

----

  gcc -Wp,-MD,./.zr36067.o.d -D__KERNEL__ 
-I/usr/src/linux-2.5.25/include -Wall -Wstrict-prototypes -Wno-trigraphs 
-O2 -fomit-frame-pointer -fno-strict-aliasing -fno-common -pipe 
-mpreferred-stack-boundary=2 -march=i686 -nostdinc -iwithprefix include 
-DMODULE -include /usr/src/linux-2.5.25/include/linux/modversions.h   
-DKBUILD_BASENAME=zr36067   -c -o zr36067.o zr36067.c
zr36067.c: In function `zoran_open':
zr36067.c:3267: structure has no member named `busy'
zr36067.c: At top level:
zr36067.c:4404: warning: initialization makes integer from pointer 
without a cast
zr36067.c:4405: warning: initialization makes integer from pointer 
without a cast
zr36067.c:4406: warning: initialization from incompatible pointer type
zr36067.c:4408: warning: initialization makes integer from pointer 
without a cast
zr36067.c:4409: warning: missing braces around initializer
zr36067.c:4409: warning: (near initialization for `zoran_template.lock')
zr36067.c:4409: warning: initialization makes integer from pointer 
without a cast
zr36067.c:4410: warning: initialization makes integer from pointer 
without a cast
zr36067.c:4411: warning: initialization makes integer from pointer 
without a cast
make[3]: *** [zr36067.o] Error 1
make[3]: Leaving directory `/usr/src/linux-2.5.25/drivers/media/video'
make[2]: *** [video] Error 2
make[2]: Leaving directory `/usr/src/linux-2.5.25/drivers/media'
make[1]: *** [media] Error 2
make[1]: Leaving directory `/usr/src/linux-2.5.25/drivers'
make: *** [drivers] Error 2

----

  gcc -Wp,-MD,./.stradis.o.d -D__KERNEL__ 
-I/usr/src/linux-2.5.25/include -Wall -Wstrict-prototypes -Wno-trigraphs 
-O2 -fomit-frame-pointer -fno-strict-aliasing -fno-common -pipe 
-mpreferred-stack-boundary=2 -march=i686 -nostdinc -iwithprefix include 
-DMODULE -include /usr/src/linux-2.5.25/include/linux/modversions.h   
-DKBUILD_BASENAME=stradis   -c -o stradis.o stradis.c
stradis.c: In function `saa_open':
stradis.c:1949: structure has no member named `busy'
stradis.c: In function `saa_close':
stradis.c:1961: structure has no member named `busy'
stradis.c: At top level:
stradis.c:1974: unknown field `open' specified in initializer
stradis.c:1974: warning: initialization makes integer from pointer 
without a cast

[SNIP]

make[3]: *** [stradis.o] Error 1
make[3]: Leaving directory `/usr/src/linux-2.5.25/drivers/media/video'
make[2]: *** [video] Error 2


Regards
Fabio


