Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315576AbSECG4k>; Fri, 3 May 2002 02:56:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315577AbSECG4j>; Fri, 3 May 2002 02:56:39 -0400
Received: from surf.viawest.net ([216.87.64.26]:45445 "EHLO surf.viawest.net")
	by vger.kernel.org with ESMTP id <S315576AbSECG4h>;
	Fri, 3 May 2002 02:56:37 -0400
Date: Thu, 2 May 2002 23:56:34 -0700
From: A Guy Called Tyketto <tyketto@wizard.com>
To: linux-kernel@vger.kernel.org
Subject: 2.5.13 sound compile error
Message-ID: <20020503065634.GA1984@wizard.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
X-Operating-System: Linux/2.5.7 (i686)
X-uptime: 11:50pm  up 5 days, 20:00,  2 users,  load average: 0.46, 0.95, 0.61
X-RSA-KeyID: 0xE9DF4D85
X-DSA-KeyID: 0xE319F0BF
X-GPG-Keys: see http://www.wizard.com/~tyketto/pgp.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


        Got this, while running make modules:

gcc -D__KERNEL__ -I/usr/src/linux-2.5.10/include -Wall -Wstrict-prototypes 
-Wno-trigraphs -O2 -fomit-frame-pointer -fno-strict-aliasing -fno-common -pipe 
-mpreferred-stack-boundary=2 -march=i686 -malign-functions=4  -DMODULE 
-DMODVERSIONS -include /usr/src/linux-2.5.10/include/linux/modversions.h  
-DKBUILD_BASENAME=isadma  -c -o isadma.o isadma.c
gcc -D__KERNEL__ -I/usr/src/linux-2.5.10/include -Wall -Wstrict-prototypes 
-Wno-trigraphs -O2 -fomit-frame-pointer -fno-strict-aliasing -fno-common -pipe 
-mpreferred-stack-boundary=2 -march=i686 -malign-functions=4  -DMODULE 
-DMODVERSIONS -include /usr/src/linux-2.5.10/include/linux/modversions.h  
-DKBUILD_BASENAME=memory  -c -o memory.o memory.c
gcc -D__KERNEL__ -I/usr/src/linux-2.5.10/include -Wall -Wstrict-prototypes 
-Wno-trigraphs -O2 -fomit-frame-pointer -fno-strict-aliasing -fno-common -pipe 
-mpreferred-stack-boundary=2 -march=i686 -malign-functions=4  -DMODULE 
-DMODVERSIONS -include /usr/src/linux-2.5.10/include/linux/modversions.h  
-DKBUILD_BASENAME=info  -c -o info.o info.c
gcc -D__KERNEL__ -I/usr/src/linux-2.5.10/include -Wall -Wstrict-prototypes 
-Wno-trigraphs -O2 -fomit-frame-pointer -fno-strict-aliasing -fno-common -pipe 
-mpreferred-stack-boundary=2 -march=i686 -malign-functions=4  -DMODULE 
-DMODVERSIONS -include /usr/src/linux-2.5.10/include/linux/modversions.h  
-DKBUILD_BASENAME=control  -c -o control.o control.c
gcc -D__KERNEL__ -I/usr/src/linux-2.5.10/include -Wall -Wstrict-prototypes 
-Wno-trigraphs -O2 -fomit-frame-pointer -fno-strict-aliasing -fno-common -pipe 
-mpreferred-stack-boundary=2 -march=i686 -malign-functions=4  -DMODULE 
-DMODVERSIONS -include /usr/src/linux-2.5.10/include/linux/modversions.h  
-DKBUILD_BASENAME=misc  -c -o misc.o misc.c
misc.c: In function `snd_printd_Rf40b198a':
misc.c:93: `file' undeclared (first use in this function)
misc.c:93: (Each undeclared identifier is reported only once
misc.c:93: for each function it appears in.)
misc.c:93: `line' undeclared (first use in this function)
make[2]: *** [misc.o] Error 1
make[2]: Leaving directory `/usr/src/linux-2.5.10/sound/core'
make[1]: *** [_modsubdir_core] Error 2
make[1]: Leaving directory `/usr/src/linux-2.5.10/sound'
make: *** [_mod_sound] Error 2

        Revelant parts of .config below.

CONFIG_SOUND=m

#
# Open Sound System
#

CONFIG_SOUND_PRIME=m
CONFIG_SOUND_OSS=m
CONFIG_SOUND_VMIDI=m
CONFIG_SOUND_SB=m
CONFIG_SOUND_YM3812=m

#
# Advanced Linux Sound Architecture
#
CONFIG_SND=m
CONFIG_SND_SEQUENCER=m
CONFIG_SND_OSSEMUL=y
CONFIG_SND_MIXER_OSS=m
CONFIG_SND_PCM_OSS=m
CONFIG_SND_SEQUENCER_OSS=m
CONFIG_SND_DEBUG=y
CONFIG_SND_DEBUG_MEMORY=y
CONFIG_SND_DEBUG_DETECT=y
CONFIG_SND_MPU401=m
CONFIG_SND_ENS1371=m
CONFIG_SND_FM801=m

                                                        BL.
-- 
Brad Littlejohn                         | Email:        tyketto@wizard.com
Unix Systems Administrator,             |           tyketto@ozemail.com.au
Web + NewsMaster, BOFH.. Smeghead! :)   |   http://www.wizard.com/~tyketto
  PGP: 1024D/E319F0BF 6980 AAD6 7329 E9E6 D569  F620 C819 199A E319 F0BF

