Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290289AbSDXHoL>; Wed, 24 Apr 2002 03:44:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290593AbSDXHoK>; Wed, 24 Apr 2002 03:44:10 -0400
Received: from laibach.mweb.co.za ([196.2.53.177]:8421 "EHLO
	laibach.mweb.co.za") by vger.kernel.org with ESMTP
	id <S290289AbSDXHoK>; Wed, 24 Apr 2002 03:44:10 -0400
To: mikej163@attbi.com, Problems <linux-kernel@vger.kernel.org>
From: bonganilinux@mweb.co.za
Subject: Re: PROBLEM:  Main.c fails to compile on 2.5.9
Date: Wed, 24 Apr 2002 07:43:57 GMT
X-Mailer: Endymion MailMan Standard Edition v3.0.33
Message-Id: <E170HNG-0003KG-00@laibach.mweb.co.za>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> [1] Main.c fails to compile on 2.5.9 kernel, during fresh install/rebuild.
> [2] Initial call to bzImage on make dies immediately with exit 1 
> [3] Key Word:  MAIN
> [4] Version: 2.4.8-34.1mdk #1 Mon Nov 19 12:40:39 MST 2001 i686 unknown  
> [Duron 700 Mhz]
> [5] Error reported :  make[1]: Leaving directory 
> `/usr/src/linux-new/linux-2.5.9'
> gcc -D__KERNEL__ -I/usr/src/linux-new/linux-2.5.9/include -Wall 
> - -Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer 
> - -fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2 
> - -march=athlon    -DKBUILD_BASENAME=main -c -o init/main.o init/main.c
> init/main.c:279: redefinition of `setup_per_cpu_areas'
> init/main.c:275: `setup_per_cpu_areas' previously defined here

Linus accidentaly applied the setup_per_cpu_areas patch twice
this patch should fix it

--- linux/init/main.c   Tue Apr 23 14:06:02 2002
+++ linux/init/main.c_new       Wed Apr 24 09:41:55 2002
@@ -275,10 +275,6 @@
 {
 }

-static inline void setup_per_cpu_areas(void)
-{
-}
-
 #else

 #ifdef
__GENERIC_PER_CPU

---------------------------------------------
This message was sent using M-Web Airmail.
JUST LIKE THAT
Are you ready for 10-digit dialling on the 8th of May?
To find out how this will affect your Internet connection go to www.mweb.co.za/ten
http://airmail.mweb.co.za/


