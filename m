Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129047AbRBKMht>; Sun, 11 Feb 2001 07:37:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129058AbRBKMhk>; Sun, 11 Feb 2001 07:37:40 -0500
Received: from [202.123.212.187] ([202.123.212.187]:25610 "EHLO ns1.b2s.com")
	by vger.kernel.org with ESMTP id <S129047AbRBKMhY>;
	Sun, 11 Feb 2001 07:37:24 -0500
Message-ID: <3A868782.55ED2B5F@vtc.edu.hk>
Date: Sun, 11 Feb 2001 20:37:23 +0800
From: Nick Urbanik <nicku@vtc.edu.hk>
Organization: Institute of Vocational Education (Tsing Yi)
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.2-pre3 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Kernel list <linux-kernel@vger.kernel.org>
Subject: 2.4.2-pre3 compile error in 6pack.c
Content-Type: text/plain; charset=big5
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dear folks,

2.4.2-pre3 doesn't compile with 6pack as a module; I had to disable it;
now it compiles (and so far, works fine).
kgcc -D__KERNEL__ -I/home/nicku/linux/include -Wall -Wstrict-prototypes
-O2 -fomit-frame-pointer -fno-strict-aliasing -pipe  -march=i686
-DMODULE -DMODVERSIONS -include
/home/nicku/linux/include/linux/modversions.h   -c -o 6pack.o 6pack.c
6pack.c: In function `sixpack_init_driver':
6pack.c:714: `KMALLOC_MAXSIZE' undeclared (first use in this function)
6pack.c:714: (Each undeclared identifier is reported only once
6pack.c:714: for each function it appears in.)
make[2]: *** [6pack.o] Error 1
make[2]: Leaving directory `/home/nicku/linux/drivers/net/hamradio'
make[1]: *** [_modsubdir_net/hamradio] Error 2
make[1]: Leaving directory `/home/nicku/linux/drivers'
make: *** [_mod_drivers] Error 2
{later:]
$ find linux -type f | xargs grep KMALLOC_MAXSIZE
linux/drivers/net/hamradio/6pack.c:     if (sixpack_maxdev *
sizeof(void*) >= KMALLOC_MAXSIZE) {
1005 $ uname -r
2.4.2-pre3

--
Nick Urbanik, Dept. of Computing and Mathematics
Hong Kong Institute of Vocational Education (Tsing Yi)
email: nicku@vtc.edu.hk
Tel:   (852) 2436 8576, (852) 2436 8579   Fax: (852) 2435 1406
pgp ID: 7529555D fingerprint: 53 B6 6D 73 52 EE 1F EE EC F8 21 98 45 1C 23 7B



-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
