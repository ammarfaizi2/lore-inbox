Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262987AbTC1Of7>; Fri, 28 Mar 2003 09:35:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262989AbTC1Of7>; Fri, 28 Mar 2003 09:35:59 -0500
Received: from carmel.ip.tiscali.net ([213.200.88.197]:9232 "EHLO
	carmel.ip.tiscali.net") by vger.kernel.org with ESMTP
	id <S262987AbTC1Of6>; Fri, 28 Mar 2003 09:35:58 -0500
Date: Fri, 28 Mar 2003 15:47:10 +0100
From: Alexander Koch <efraim@clues.de>
To: linux-kernel@vger.kernel.org
Subject: sound, sb16, not compiling
Message-ID: <20030328144710.GA8522@shekinah.ip.tiscali.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hiya.

I fail to get the SB16 module compiled, it does not like me.
This is 2.5.66, .65 does not work either.

Hope anyone can help as I miss it. ;-)

Thanks,
Alexander

[ make modules ]

make -f scripts/Makefile.build obj=sound/isa/opti9xx
make -f scripts/Makefile.build obj=sound/isa/sb
  gcc -Wp,-MD,sound/isa/sb/.sb16.o.d -D__KERNEL__ -Iinclude
-Wall -Wstrict-prototypes -Wno-trigraphs -O2
-fno-strict-aliasing -fno-common -pipe
-mpreferred-stack-boundary=2 -march=pentium3
-Iinclude/asm-i386/mach-default -fomit-frame-pointer
-nostdinc -iwithprefix include -DMODULE
-DKBUILD_BASENAME=sb16 -DKBUILD_MODNAME=snd_sb16 -c -o
sound/isa/sb/sb16.o sound/isa/sb/sb16.c
sound/isa/sb/sb16.c: In function `snd_sb16_isapnp':
sound/isa/sb/sb16.c:279: warning: implicit declaration of
function `isapnp_find_dev'
sound/isa/sb/sb16.c:279: warning: assignment makes pointer
from integer without a cast
sound/isa/sb/sb16.c:280: structure has no member named `active'
sound/isa/sb/sb16.c:293: structure has no member named `prepare'
sound/isa/sb/sb16.c:296: warning: implicit declaration of
function `isapnp_resource_change'
sound/isa/sb/sb16.c:307: structure has no member named `activate'
sound/isa/sb/sb16.c: In function `snd_sb16_deactivate':
sound/isa/sb/sb16.c:347: structure has no member named `deactivate'
sound/isa/sb/sb16.c: In function `alsa_card_sb16_init':
sound/isa/sb/sb16.c:632: warning: implicit declaration of function `isapnp_probe_cards'
make[3]: *** [sound/isa/sb/sb16.o] Error 1
make[2]: *** [sound/isa/sb] Error 2
make[1]: *** [sound/isa] Error 2
make: *** [sound] Error 2

