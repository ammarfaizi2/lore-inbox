Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318266AbSIBLBt>; Mon, 2 Sep 2002 07:01:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318274AbSIBLBt>; Mon, 2 Sep 2002 07:01:49 -0400
Received: from mail.pixelwings.com ([194.152.163.212]:13067 "EHLO
	pixelwings.com") by vger.kernel.org with ESMTP id <S318266AbSIBLBs> convert rfc822-to-8bit;
	Mon, 2 Sep 2002 07:01:48 -0400
Date: Mon, 2 Sep 2002 13:06:13 +0200 (CEST)
From: Clemens Schwaighofer <cs@pixelwings.com>
X-X-Sender: gullevek@lynx.piwi.intern
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: 2.5.33 compile error in ipv6
Message-ID: <Pine.LNX.4.44.0209021304590.2696-100000@lynx.piwi.intern>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi,

my typical test system: std rh 7.3 + gcc-3.2 from rawhide

I applied the aty FB patches, cause build would fail there too.

then this ...

make[3]: Entering directory `/usr/src/kernel/2.5.33/linux-2.5.33/net/ipv6'
  gcc -Wp,-MD,./.af_inet6.o.d -D__KERNEL__ 
-I/usr/src/kernel/2.5.33/linux-2.5.33/include -Wall -Wstrict-prototypes 
-Wno-trigraphs -O2 -fomit-frame-pointer -fno-strict-aliasing -fno-common 
-pipe -mpreferred-stack-boundary=2 -march=i686 -nostdinc -iwithprefix 
include    -DKBUILD_BASENAME=af_inet6   -c -o af_inet6.o af_inet6.c
af_inet6.c: In function `inet6_init':
af_inet6.c:666: called object is not a function
af_inet6.c:667: parse error before string constant
make[3]: *** [af_inet6.o] Error 1
make[3]: Leaving directory `/usr/src/kernel/2.5.33/linux-2.5.33/net/ipv6'
make[2]: *** [ipv6] Error 2
make[2]: Leaving directory `/usr/src/kernel/2.5.33/linux-2.5.33/net'
make[1]: *** [net] Error 2
make[1]: Leaving directory `/usr/src/kernel/2.5.33/linux-2.5.33'
make: *** [bzImage] Error 2

I saw no patch in ML yet for this ...

-- 
"Der Krieg ist ein Massaker von Leuten, die sich nicht kennen, zum
Nutzen von Leuten, die sich kennen, aber nicht massakrieren"
- Paul Valéry (1871-1945)
mfg, Clemens Schwaighofer                       PIXELWINGS Medien GMBH
Kandlgasse 15/5, A-1070 Wien                      T: [+43 1] 524 58 50
JETZT NEU! MIT FEWA GEWASCHEN       -->      http://www.pixelwings.com

