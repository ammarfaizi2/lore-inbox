Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280751AbRKGD0s>; Tue, 6 Nov 2001 22:26:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280750AbRKGD0h>; Tue, 6 Nov 2001 22:26:37 -0500
Received: from Sioux.meginc.com ([207.246.76.19]:2821 "EHLO sioux.meginc.com")
	by vger.kernel.org with ESMTP id <S280751AbRKGD03>;
	Tue, 6 Nov 2001 22:26:29 -0500
Message-Id: <200111070323.WAA01534@sioux.meginc.com>
Content-Type: text/plain; charset=US-ASCII
From: Brandon Barker <bebarker@meginc.com>
To: linux-kernel@vger.kernel.org
Subject: AGPGART build problem in 2.4.14
Date: Tue, 6 Nov 2001 22:27:50 -0500
X-Mailer: KMail [version 1.3.1]
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The following problem occured while building linux 2.4.14 while trying to 
make the agpgart driver (system is Intel/Redhat 7.2):


make[3]: Entering directory `/usr/src/linux-2.4.14/drivers/char/agp'
gcc -D__KERNEL__ -I/usr/src/linux-2.4.14/include -Wall -Wstrict-prototypes 
-Wno-trigraphs -O2 -fomit-frame-pointer -fno-strict-aliasing -fno-common 
-pipe -mpreferred-stack-boundary=2 -march=i686 -DMODULE -DMODVERSIONS 
-include /usr/src/linux-2.4.14/include/linux/modversions.h   -c -o 
agpgart_fe.o agpgart_fe.c
gcc -D__KERNEL__ -I/usr/src/linux-2.4.14/include -Wall -Wstrict-prototypes 
-Wno-trigraphs -O2 -fomit-frame-pointer -fno-strict-aliasing -fno-common 
-pipe -mpreferred-stack-boundary=2 -march=i686 -DMODULE -DMODVERSIONS 
-include /usr/src/linux-2.4.14/include/linux/modversions.h   -DEXPORT_SYMTAB 
-c agpgart_be.c
agpgart_be.c:84:2: #error "Please define flush_cache."
make[3]: *** [agpgart_be.o] Error 1
make[3]: Leaving directory `/usr/src/linux-2.4.14/drivers/char/agp'
make[2]: *** [_modsubdir_agp] Error 2
make[2]: Leaving directory `/usr/src/linux-2.4.14/drivers/char'
make[1]: *** [_modsubdir_char] Error 2
make[1]: Leaving directory `/usr/src/linux-2.4.14/drivers'
make: *** [_mod_drivers] Error 2
[root@localhost linux]#

If this problem is resolved please tell me, I'd be very appreciative.
Brandon Barker
