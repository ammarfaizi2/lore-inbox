Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264743AbSKNHB0>; Thu, 14 Nov 2002 02:01:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264775AbSKNHB0>; Thu, 14 Nov 2002 02:01:26 -0500
Received: from isp247n.hispeed.ch ([62.2.95.247]:3501 "EHLO smtp.hispeed.ch")
	by vger.kernel.org with ESMTP id <S264743AbSKNHBZ>;
	Thu, 14 Nov 2002 02:01:25 -0500
Date: Thu, 14 Nov 2002 08:08:14 +0100
From: xmb <xmb@kick.sytes.net>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: adbhid wont compile (ppc)
Message-ID: <2147483647.1037261294@[192.168.1.10]>
X-Mailer: Mulberry/3.0.0b8 (Mac OS X)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Yo,

Running on Debian testing / unstable with gcc 3.2.1, but getting the same 
err when trying with gcc-2.95.4...
>From the original 2.5.47 kernel tree:

  gcc -Wp,-MD,drivers/macintosh/.adbhid.o.d -D__KERNEL__ -Iinclude -Wall 
-Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer 
-fno-strict-aliasing -fno-common -I/home/xmb/kernel/linux-2.5.47/arch/ppc 
-msoft-float -pipe -ffixed-r2 -Wno-uninitialized -mmultiple -mstring 
-nostdinc -iwithprefix include    -DKBUILD_BASENAME=adbhid   -c -o 
drivers/macintosh/adbhid.o drivers/macintosh/adbhid.c
drivers/macintosh/adbhid.c: In function `adb_message_handler':
drivers/macintosh/adbhid.c:442: warning: implicit declaration of function 
`save_flags'
drivers/macintosh/adbhid.c:443: warning: implicit declaration of function 
`cli'
drivers/macintosh/adbhid.c:451: warning: implicit declaration of function 
`restore_flags'
drivers/macintosh/adbhid.c: In function `adbhid_input_register':
drivers/macintosh/adbhid.c:482: request for member `h_list' in something 
not a structure or union
drivers/macintosh/adbhid.c:482: request for member `h_list' in something 
not a structure or union
drivers/macintosh/adbhid.c:482: request for member `h_list' in something 
not a structure or union
drivers/macintosh/adbhid.c:482: request for member `h_list' in something 
not a structure or union
drivers/macintosh/adbhid.c:482: request for member `node' in something not 
a structure or union
drivers/macintosh/adbhid.c:482: request for member `node' in something not 
a structure or union
drivers/macintosh/adbhid.c:482: request for member `node' in something not 
a structure or union
drivers/macintosh/adbhid.c:482: request for member `node' in something not 
a structure or union
drivers/macintosh/adbhid.c:511: structure has no member named `idversion'
drivers/macintosh/adbhid.c:518: structure has no member named `idversion'
drivers/macintosh/adbhid.c:525: structure has no member named `idversion'
drivers/macintosh/adbhid.c:534: structure has no member named `idversion'
make[2]: *** [drivers/macintosh/adbhid.o] Error 1
make[1]: *** [drivers/macintosh] Error 2
make: *** [drivers] Error 2

./xmb
