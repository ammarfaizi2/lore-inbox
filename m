Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269711AbSISAzy>; Wed, 18 Sep 2002 20:55:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269717AbSISAzy>; Wed, 18 Sep 2002 20:55:54 -0400
Received: from 217-13-24-22.dd.nextgentel.com ([217.13.24.22]:22994 "EHLO
	mail.ihatent.com") by vger.kernel.org with ESMTP id <S269711AbSISAzx>;
	Wed, 18 Sep 2002 20:55:53 -0400
To: linux-kernel@vger.kernel.org
Subject: 2.4.20-pre7-ac2 compile and IrDA
References: <200209190222.33276.duncan.sands@math.u-psud.fr>
	<3D891BD1.8F774946@digeo.com>
From: Alexander Hoogerhuis <alexh@ihatent.com>
Date: 19 Sep 2002 03:00:48 +0200
In-Reply-To: <3D891BD1.8F774946@digeo.com>
Message-ID: <m3bs6uyerj.fsf_-_@lapper.ihatent.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

2.4.20-pre7-ac2 has a problem compiling the irtty module:

make[3]: Entering directory `/home/alexh/src/linux/linux-2.4-ac-test/drivers/net/irda'
gcc -D__KERNEL__ -I/home/alexh/src/linux/linux-2.4-ac-test/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -fomit-frame-pointer -pipe -mpreferred-stack-boundary=2 -march=i686 -DMODULE -DMODVERSIONS -include /home/alexh/src/linux/linux-2.4-ac-test/include/linux/modversions.h  -nostdinc -iwithprefix include -DKBUILD_BASENAME=irtty  -c -o irtty.o irtty.c
irtty.c: In function `irtty_set_dtr_rts':
irtty.c:761: `TIOCM_MODEM_BITS' undeclared (first use in this function)
irtty.c:761: (Each undeclared identifier is reported only once
irtty.c:761: for each function it appears in.)
make[3]: *** [irtty.o] Error 1
make[3]: Leaving directory `/home/alexh/src/linux/linux-2.4-ac-test/drivers/net/irda'
make[2]: *** [_modsubdir_irda] Error 2
make[2]: Leaving directory `/home/alexh/src/linux/linux-2.4-ac-test/drivers/net'
make[1]: *** [_modsubdir_net] Error 2
make[1]: Leaving directory `/home/alexh/src/linux/linux-2.4-ac-test/drivers'
make: *** [_mod_drivers] Error 2

lapper:~/src/linux/linux-2.4-ac-test$ grep IRDA .config
CONFIG_IRDA=m
CONFIG_IRDA_ULTRA=y
CONFIG_IRDA_CACHE_LAST_LSAP=y
CONFIG_IRDA_FAST_RR=y
# CONFIG_IRDA_DEBUG is not set
# CONFIG_USB_IRDA is not set
lapper:~/src/linux/linux-2.4-ac-test$
 
mvh,
A
-- 
Alexander Hoogerhuis                               | alexh@ihatent.com
CCNP - CCDP - MCNE - CCSE                          | +47 908 21 485
"You have zero privacy anyway. Get over it."  --Scott McNealy
