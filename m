Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275570AbRJTHwH>; Sat, 20 Oct 2001 03:52:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276075AbRJTHv4>; Sat, 20 Oct 2001 03:51:56 -0400
Received: from smtp3.libero.it ([193.70.192.53]:58497 "EHLO smtp3.libero.it")
	by vger.kernel.org with ESMTP id <S275570AbRJTHvm>;
	Sat, 20 Oct 2001 03:51:42 -0400
Message-ID: <3BD0BB8D.5AC21D7D@libero.it>
Date: Sat, 20 Oct 2001 01:47:25 +0200
From: "Roberto A. F." <robang@libero.it>
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.7-12.3mdk i686)
X-Accept-Language: it, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Errore di compilazione del kernel
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 Error compiling kernel 2.4.12
 ------------------------------------

 Using CONFIG_PARPORT_1284 in .config file, compilation does't work as
you can see:

gcc -D__KERNEL__ -I/usr/src/linux-2.4.12/include -Wall
-Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer
-fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2
-march=i686 -DMODULE
-DMODVERSIONS -include
/usr/src/linux-2.4.12/include/linux/modversions.h   -c -o ieee1284_ops.o
ieee1284_ops.c
ieee1284_ops.c: In function `ecp_forward_to_reverse':
ieee1284_ops.c:365: `IEEE1284_PH_DIR_UNKNOWN' undeclared (first use in
this function)
ieee1284_ops.c:365: (Each undeclared identifier is reported only once
ieee1284_ops.c:365: for each function it appears in.)
ieee1284_ops.c: In function `ecp_reverse_to_forward':
ieee1284_ops.c:397: `IEEE1284_PH_DIR_UNKNOWN' undeclared (first use in
this function)
make[2]: *** [ieee1284_ops.o] Error 1
make[2]: Leaving directory `/usr/src/linux-2.4.12/drivers/parport'
make[1]: *** [_modsubdir_parport] Error 2
make[1]: Leaving directory `/usr/src/linux-2.4.12/drivers'
make: *** [_mod_drivers] Error 2

[root@localhost linux-2.4.12]# cat .con
.config      .config.old
[root@localhost linux-2.4.12]# cat .config | grep ieee1284
[root@localhost linux-2.4.12]# cat .config | grep 1284
CONFIG_PARPORT_1284=y

 [root@localhost linux-2.4.12]# gcc -v
Reading specs from /usr/lib/gcc-lib/i586-mandrake-linux-gnu/3.0.1/specs
Configured with: ../configure --prefix=/usr --mandir=/usr/share/man
--infodir=/usr/share/info --enable-shared --enable-threads=posix
--disable-checking --enable-long-long --enable-cstdio=stdio
--enable-clocale=generic --enable-languages=c,c++,f77,objc,java
--program-suffix=-3.0.1 --enable-objc-gc --host=i586-mandrake-linux-gnu
Thread model: posix
gcc version 3.0.1

 [root@localhost linux-2.4.12]# cat  /proc/version
Linux version 2.4.7-12.3mdk (root@updates) (gcc version egcs-2.91.66
19990314/Linux (egcs-1.1.2 release / Linux-Mandrake 8.0)) #1 Mon Aug 20
16:16:58 MDT 2001

 Bye,
--

   ,__    ,_     ,___    .-------=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-.
   ||_)   ||\    ||_    /     Proud Member & Master of the LUGGE    |
   || \   ||¯\   ||¯      linuxgrp: http://lugge.ziobudda.net       |
   ¯¯  ¯° ¯¯  ¯° ¯¯  °    homepage: http://digilander.iol.it/robang |
   Roberto A. Foglietta   icq uin : 1087 18 257, E=s*aurimento²     |
 \                        reg num : #219348 with the Linux Counter  |
  `---------------------=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-'






