Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281245AbRKPIn1>; Fri, 16 Nov 2001 03:43:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281246AbRKPInR>; Fri, 16 Nov 2001 03:43:17 -0500
Received: from p60-tnt8.syd.ihug.com.au ([203.173.147.60]:18963 "EHLO
	bugger.jampot.org") by vger.kernel.org with ESMTP
	id <S281245AbRKPInI>; Fri, 16 Nov 2001 03:43:08 -0500
Message-ID: <3BF4D16E.10802@ihug.com.au>
Date: Fri, 16 Nov 2001 19:42:22 +1100
From: Cyrus Santos <crashboy@ihug.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.5) Gecko/20011012
X-Accept-Language: en-us
MIME-Version: 1.0
Newsgroups: alt.os.linux,alt.os.linux.slackware,comp.os.linux.hardware,linux.dev.kernel
To: rml@tech9.net, linux-kernel@vger.kernel.org
Subject: Follow-up: AMD761+Radeon....Kernel compilation warnings/errors.....
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi all,

here is what i had a glimpse on compiling 2.4.15-pre5.... i don't know 
if it is really useful for the gart or even a radeon problem if there 
are any... i've been seeing this since 2.4.12 actually...

FOR agpgart: built-in kernel support for amd 761....

ict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2 -march=i686 
-malign-functions=4     -c -o agpgart_fe.o agpgart_fe.c
gcc -D__KERNEL__ -I/usr/src/linux-2.4.15-pre5/include -Wall 
-Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer -fno-str
ict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2 -march=i686 
-malign-functions=4     -DEXPORT_SYMTAB -c agpgart_be.c
agpgart_be.c:524: warning: `agp_generic_create_gatt_table' defined but 
not used
agpgart_be.c:652: warning: `agp_generic_free_gatt_table' defined but not 
used
agpgart_be.c:700: warning: `agp_generic_insert_memory' defined but not used
agpgart_be.c:758: warning: `agp_generic_remove_memory' defined but not used
ld -m elf_i386  -r -o agpgart.o agpgart_fe.o agpgart_be.o
rm -f agp.o
ld -m elf_i386  -r -o agp.o agpgart.o

honestly, i don't know what this means.... :-(

FOR radeon: DRI support built-in kernel support with radeon as a module.....

r/src/linux-2.4.15-pre5/include/linux/modversions.h   -c -o radeon_cp.o 
radeon_cp.c
radeon_cp.c: In function `radeon_cp_init_ring_buffer':
radeon_cp.c:627: warning: unsigned int format, different type arg (arg 2)
gcc -D__KERNEL__ -I/usr/src/linux-2.4.15-pre5/include -Wall 
-Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer -fno-str
ict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2 -march=i686 
-malign-functions=4  -DMODULE -DMODVERSIONS -include /us
r/src/linux-2.4.15-pre5/include/linux/modversions.h   -c -o 
radeon_state.o radeon_state.c
ld -m elf_i386 -r -o radeon.o radeon_drv.o radeon_cp.o radeon_state.o
make[3]: Leaving directory `/usr/src/linux-2.4.15-pre5/drivers/char/drm'

and this one too... :-(

anyway, hope you can enlighten us once more....

thanks guys!!!

cheers!

cyrus


-- 
Cyrus Santos

Registered Linux User # 220455
Sydney, Australia

"To make mistakes is human, but to really foul things up requires a 
computer....."

#!/bin/rm -Rf *


