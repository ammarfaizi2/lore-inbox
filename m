Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268924AbRHULps>; Tue, 21 Aug 2001 07:45:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269437AbRHULpi>; Tue, 21 Aug 2001 07:45:38 -0400
Received: from ip440.austriaone.at ([193.81.245.7]:59608 "HELO
	ip440.austriaone.a") by vger.kernel.org with SMTP
	id <S268924AbRHULpf>; Tue, 21 Aug 2001 07:45:35 -0400
From: <gonzales@dns1.austriaone.at>
To: <linux-kernel@vger.kernel.org>
Subject: 2.4.9 "rrunner.c" wont compile
Message-Id: <20010821114536Z268924-760+4176@vger.kernel.org>
Date: Tue, 21 Aug 2001 07:45:35 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


hello list,

recently I tried to compile 2.4.9. however, allthough being a so-called
"stable production release", it fails being compiled.

  :  gonzales:/usr/src/linux # make modules
  :  [...]
  :  make -C  kernel CFLAGS="-D__KERNEL__ -I/usr/src/linux/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer -fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2 -march=i586 -DMODULE" MAKING_MODULES=1 modules
  :  make[1]: Entering directory `/usr/src/linux/kernel'
  :
  :  gcc -D__KERNEL__ -I/usr/src/linux/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer -fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2 -march=i586 -DMODULE   -c -o rrunner.o rrunner.c
  :  rrunner.c:1241: macro `min' used with only 2 args
  :  rrunner.c:1252: macro `min' used with only 2 args
  :  rrunner.c: In function `rr_dump':
  :  rrunner.c:1241: parse error before `__x'
  :  rrunner.c:1241: `__x' undeclared (first use in this function)
  :  rrunner.c:1241: (Each undeclared identifier is reported only once
  :  rrunner.c:1241: for each function it appears in.)
  :  rrunner.c:1241: `__y' undeclared (first use in this function)
  :  rrunner.c:1252: parse error before `__x'
  :  rrunner.c:1221: warning: `len' might be used uninitialized in this function
  :  make[2]: *** [rrunner.o] Error 1
  :  make[2]: Leaving directory `/usr/src/linux/drivers/net'
  :  make[1]: *** [_modsubdir_net] Error 2
  :  make[1]: Leaving directory `/usr/src/linux/drivers'
  :  make: *** [_mod_drivers] Error 2

I understand this not. what does "min used with only 2 args" mean?
why would a comparison need more than 2 arguments?

sincerly,
gonazeles
