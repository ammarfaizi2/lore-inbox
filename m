Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265176AbSJaEcY>; Wed, 30 Oct 2002 23:32:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265177AbSJaEcY>; Wed, 30 Oct 2002 23:32:24 -0500
Received: from web1.elbnet.com ([65.209.12.165]:63160 "EHLO web1.elbnet.com")
	by vger.kernel.org with ESMTP id <S265176AbSJaEcX>;
	Wed, 30 Oct 2002 23:32:23 -0500
Date: Wed, 30 Oct 2002 23:28:51 -0500
From: Bob Billson <reb@bhive.dhs.org>
To: linux-kernel@vger.kernel.org
Subject: 2.5.45: compiler error in video/sis/sis_main.c
Message-ID: <20021031042851.GB6386@etain.bhive.dhs.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.4i
Organization: Hopeless... my honeybees are more organized.
X-Moon: The Moon is Waning Crescent (29% of Full)
X-Uptime: 22:24:48 up 1 day,  7:15,  4 users,  load average: 1.89, 1.81, 1.64
X-GPG-Key: http://bhive.dhs.org/gpgkey.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

A compiler error in drivers/video/sis/sis_main.c:

make -f scripts/Makefile.build obj=drivers/video/sis
  gcc -Wp,-MD,drivers/video/sis/.sis_main.o.d -D__KERNEL__ -Iinclude -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer -fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2 -march=i686 -malign-functions=4 -Iarch/i386/mach-generic -nostdinc -iwithprefix include    -DKBUILD_BASENAME=sis_main -DEXPORT_SYMTAB  -c -o drivers/video/sis/sis_main.o drivers/video/sis/sis_main.c
In file included from drivers/video/sis/sis_main.c:57:
drivers/video/sis/sis_main.h:299: parse error before `sisfbinfo'
drivers/video/sis/sis_main.h:299: warning: type defaults to `int' in declaration of `sisfbinfo'
drivers/video/sis/sis_main.h:299: warning: data definition has no type or storage class
drivers/video/sis/sis_main.c: In function `sisfb_query_north_bridge_space':
drivers/video/sis/sis_main.c:206: `SIS_650' undeclared (first use in this function)
drivers/video/sis/sis_main.c:206: (Each undeclared identifier is reported only once
drivers/video/sis/sis_main.c:206: for each function it appears in.)
drivers/video/sis/sis_main.c: In function `sisfb_set_disp':
drivers/video/sis/sis_main.c:666: structure has no member named `visual'
drivers/video/sis/sis_main.c:667: structure has no member named `type'
drivers/video/sis/sis_main.c:668: structure has no member named `type_aux'
drivers/video/sis/sis_main.c:669: structure has no member named `ypanstep'
drivers/video/sis/sis_main.c:670: structure has no member named `ywrapstep'
drivers/video/sis/sis_main.c:671: structure has no member named `line_length'
drivers/video/sis/sis_main.c:677: warning: implicit declaration of function `save_flags'
drivers/video/sis/sis_main.c:709: warning: implicit declaration of function `restore_flags'
drivers/video/sis/sis_main.c:654: warning: `flags' might be used uninitialized in this function
drivers/video/sis/sis_main.c: In function `sisfb_heap_init':
drivers/video/sis/sis_main.c:1340: structure has no member named `heapstart'
drivers/video/sis/sis_main.c:1342: structure has no member named `heapstart'
drivers/video/sis/sis_main.c:1344: structure has no member named `heapstart'
drivers/video/sis/sis_main.c:1347: structure has no member named `heapstart'
drivers/video/sis/sis_main.c:1350: structure has no member named `heapstart'
drivers/video/sis/sis_main.c:1352: structure has no member named `heapstart'
drivers/video/sis/sis_main.c: In function `sisfb_ioctl':
drivers/video/sis/sis_main.c:2490: `SISFB_GET_INFO' undeclared (first use in this function)
drivers/video/sis/sis_main.c:2492: `sisfb_info' undeclared (first use in this function)
drivers/video/sis/sis_main.c:2492: `x' undeclared (first use in this function)
drivers/video/sis/sis_main.c:2492: parse error before `)'
drivers/video/sis/sis_main.c:2494: `SISFB_ID' undeclared (first use in this function)
drivers/video/sis/sis_main.c:2500: structure has no member named `heapstart'
drivers/video/sis/sis_main.c: At top level:
drivers/video/sis/sis_main.c:2563: unknown field `fb_get_fix' specified in initializer
drivers/video/sis/sis_main.c:2563: warning: initialization from incompatible pointer type
drivers/video/sis/sis_main.c:2564: unknown field `fb_get_var' specified in initializer
drivers/video/sis/sis_main.c:2564: warning: initialization from incompatible pointer type
drivers/video/sis/sis_main.c:2570: warning: initialization from incompatible pointer type
drivers/video/sis/sis_main.c: In function `sisfb_init':
drivers/video/sis/sis_main.c:2814: `SIS_650' undeclared (first use in this function)
drivers/video/sis/sis_main.c:3373: structure has no member named `mtrr'
drivers/video/sis/sis_main.c:3376: structure has no member named `mtrr'
drivers/video/sis/sis_main.c:3397: `SISFB_GET_INFO' undeclared (first use in this function)
drivers/video/sis/sis_main.c: At top level:
drivers/video/sis/sis_main.h:275: warning: `currcon' defined but not used
make[3]: *** [drivers/video/sis/sis_main.o] Error 1
make[2]: *** [drivers/video/sis] Error 2
make[1]: *** [drivers/video] Error 2
make: *** [drivers] Error 2
  
             bob
-- 
 bob billson        email: reb@bhive.dhs.org          ham: kc2wz    /)
                           reb@elbnet.com             beekeeper  -8|||}
 "Níl aon tinteán mar do thinteán féin." --Dorothy    Linux geek    \)
 [ GPG key: http://bhive.dhs.org/gpgkey.html ]
