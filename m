Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267602AbRHKNnc>; Sat, 11 Aug 2001 09:43:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267615AbRHKNnW>; Sat, 11 Aug 2001 09:43:22 -0400
Received: from CPE-61-9-149-76.vic.bigpond.net.au ([61.9.149.76]:61422 "EHLO
	eyal.emu.id.au") by vger.kernel.org with ESMTP id <S267602AbRHKNnO>;
	Sat, 11 Aug 2001 09:43:14 -0400
Message-ID: <3B7533FE.4A8EC734@eyal.emu.id.au>
Date: Sat, 11 Aug 2001 23:32:46 +1000
From: Eyal Lebedinsky <eyal@eyal.emu.id.au>
Organization: Eyal at Home
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.7-ac8 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Andrea Arcangeli <andrea@suse.de>
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.4.8aa1
In-Reply-To: <20010811145813.B19169@athlon.random>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrea Arcangeli wrote:
> 
> Only in 2.4.8pre8aa1: 40_blkdev-pagecache-11
> Only in 2.4.8aa1: 40_blkdev-pagecache-12

Everything possible selected as a module.

The relevant DRM part of .config:

CONFIG_DRM=y
CONFIG_DRM_TDFX=m   
CONFIG_DRM_GAMMA=m
CONFIG_DRM_R128=m 
CONFIG_DRM_RADEON=m  
CONFIG_DRM_I810=m
CONFIG_DRM_MGA=m

gcc -D__KERNEL__ -I/data2/usr/local/src/linux-2.4/include -Wall
-Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer
-fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2
-march=i686 -malign-functions=4  -DMODULE -DMODVERSIONS -include
/data2/usr/local/src/linux-2.4/include/linux/modversions.h   -c -o
r128_drv.o r128_drv.c
In file included from r128_drv.c:36:
ati_pcigart.h: In function `r128_ati_pcigart_init':
ati_pcigart.h:114: structure has no member named `virtual'
make[3]: *** [r128_drv.o] Error 1
make[3]: Leaving directory
`/data2/usr/local/src/linux-2.4/drivers/char/drm'

--
Eyal Lebedinsky (eyal@eyal.emu.id.au) <http://samba.anu.edu.au/eyal/>
