Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315167AbSHXBI2>; Fri, 23 Aug 2002 21:08:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315178AbSHXBHe>; Fri, 23 Aug 2002 21:07:34 -0400
Received: from firewall2.uwindsor.ca ([137.207.233.22]:47073 "HELO
	internet2.uwindsor.ca") by vger.kernel.org with SMTP
	id <S315167AbSHXBHb> convert rfc822-to-8bit; Fri, 23 Aug 2002 21:07:31 -0400
Content-Type: text/plain;
  charset="iso-8859-15"
From: Martin =?iso-8859-15?q?K=F6bele?= <martin@mkoebele.de>
To: linux-kernel@vger.kernel.org
Subject: BUG, sis_main.c doesn't compile in 2.5.31
Date: Fri, 23 Aug 2002 21:06:04 -0400
User-Agent: KMail/1.4.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Message-Id: <200208232106.04197.martin@mkoebele.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi, couldn't find a bug report in the archive.
I tried to compile the kernel with the SIS-Support in Framebuffer.

I got this message:


make[3]: Wechsel in das Verzeichnis Verzeichnis 
»/usr/src/linux-2.5.31/drivers/video/sis«
  gcc -Wp,-MD,./.sis_main.o.d -D__KERNEL__ -I/usr/src/linux-2.5.31/include 
-Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer 
-fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2 
-march=i686 -malign-functions=4  -nostdinc -iwithprefix include -DMODULE 
-include /usr/src/linux-2.5.31/include/linux/modversions.h   
-DKBUILD_BASENAME=sis_main -DEXPORT_SYMTAB  -c -o sis_main.o sis_main.c
In file included from sis_main.c:57:
sis_main.h:299: parse error before `sisfbinfo'
sis_main.h:299: warning: type defaults to `int' in declaration of `sisfbinfo'
sis_main.h:299: warning: data definition has no type or storage class
sis_main.c: In function `sisfb_query_north_bridge_space':
sis_main.c:206: `SIS_650' undeclared (first use in this function)
sis_main.c:206: (Each undeclared identifier is reported only once
sis_main.c:206: for each function it appears in.)
sis_main.c: In function `sisfb_set_disp':
sis_main.c:677: warning: implicit declaration of function `save_flags'
sis_main.c:709: warning: implicit declaration of function `restore_flags'
sis_main.c:654: warning: `flags' might be used uninitialized in this function
sis_main.c: In function `sisfb_heap_init':
sis_main.c:1340: structure has no member named `heapstart'
sis_main.c:1342: structure has no member named `heapstart'
sis_main.c:1344: structure has no member named `heapstart'
sis_main.c:1347: structure has no member named `heapstart'
sis_main.c:1350: structure has no member named `heapstart'
sis_main.c:1352: structure has no member named `heapstart'
sis_main.c: In function `sisfb_ioctl':
sis_main.c:2490: `SISFB_GET_INFO' undeclared (first use in this function)
sis_main.c:2492: `sisfb_info' undeclared (first use in this function)
sis_main.c:2492: `x' undeclared (first use in this function)
sis_main.c:2492: parse error before `)'
sis_main.c:2494: `SISFB_ID' undeclared (first use in this function)
sis_main.c:2500: structure has no member named `heapstart'
sis_main.c: At top level:
sis_main.c:2570: warning: initialization from incompatible pointer type
sis_main.c: In function `sisfb_init':
sis_main.c:2814: `SIS_650' undeclared (first use in this function)
sis_main.c:3373: structure has no member named `mtrr'
sis_main.c:3376: structure has no member named `mtrr'
sis_main.c:3397: `SISFB_GET_INFO' undeclared (first use in this function)
sis_main.c: In function `cleanup_module':
sis_main.c:3539: structure has no member named `mtrr'
sis_main.c:3539: structure has no member named `mtrr'
sis_main.c: At top level:
sis_main.h:275: warning: `currcon' defined but not used
make[3]: *** [sis_main.o] Fehler 1
make[3]: Verlassen des Verzeichnisses Verzeichnis 
»/usr/src/linux-2.5.31/drivers/video/sis«
make[2]: *** [sis] Fehler 2
make[2]: Verlassen des Verzeichnisses Verzeichnis 
»/usr/src/linux-2.5.31/drivers/video«
make[1]: *** [video] Fehler 2
make[1]: Verlassen des Verzeichnisses Verzeichnis 
»/usr/src/linux-2.5.31/drivers«
make: *** [drivers] Fehler 2


Martin Koebele

