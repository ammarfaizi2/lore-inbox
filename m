Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317572AbSFIIfe>; Sun, 9 Jun 2002 04:35:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317577AbSFIIfd>; Sun, 9 Jun 2002 04:35:33 -0400
Received: from pop017pub.verizon.net ([206.46.170.210]:45814 "EHLO
	pop017.verizon.net") by vger.kernel.org with ESMTP
	id <S317572AbSFIIfd>; Sun, 9 Jun 2002 04:35:33 -0400
Date: Sun, 9 Jun 2002 04:40:26 -0400
From: Skip Ford <skip.ford@verizon.net>
To: Miles Lane <miles@megapathdsl.net>
Cc: Linus Torvalds <torvalds@transmeta.com>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.5.21 -- suspend.h:58: parse error before "__nosavedata"
In-Reply-To: <Pine.LNX.4.33.0206082235240.4635-100000@penguin.transmeta.com> <1023606626.5775.1.camel@turbulence.megapathdsl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Message-Id: <20020609083529.GZZE10701.pop017.verizon.net@pool-141-150-239-239.delv.east.verizon.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Miles Lane wrote:
> gcc -Wp,-MD,.suspend.o.d -D__KERNEL__ -I/usr/src/linux/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer -fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2 -march=athlon  -nostdinc -iwithprefix include    -DKBUILD_BASENAME=suspend -DEXPORT_SYMTAB  -c -o suspend.o suspend.c
> In file included from suspend.c:40:
> /usr/src/linux/include/linux/suspend.h:58: parse error before "__nosavedata"
> /usr/src/linux/include/linux/suspend.h:58: warning: type defaults to `int' in declaration of `__nosavedata'
> /usr/src/linux/include/linux/suspend.h:58: warning: data definition has no type or storage class
> /usr/src/linux/include/linux/suspend.h:59: parse error before "__nosavedata"
> /usr/src/linux/include/linux/suspend.h:59: warning: type defaults to `int' in declaration of `__nosavedata'
> /usr/src/linux/include/linux/suspend.h:59: warning: data definition has no type or storage class

Looks like suspend.h needs init.h

--- linux/include/linux/suspend.h~	Sun Jun  9 04:31:05 2002
+++ linux/include/linux/suspend.h	Sun Jun  9 04:31:22 2002
@@ -7,6 +7,7 @@
 #include <linux/swap.h>
 #include <linux/notifier.h>
 #include <linux/config.h>
+#include <linux/init.h>
 
 extern unsigned char software_suspend_enabled;

-- 
Skip
