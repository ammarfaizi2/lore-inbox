Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267872AbTAHQPp>; Wed, 8 Jan 2003 11:15:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267873AbTAHQPp>; Wed, 8 Jan 2003 11:15:45 -0500
Received: from prgy-npn1.prodigy.com ([207.115.54.37]:10250 "EHLO
	oddball.prodigy.com") by vger.kernel.org with ESMTP
	id <S267872AbTAHQPn>; Wed, 8 Jan 2003 11:15:43 -0500
Date: Wed, 8 Jan 2003 11:24:24 -0500 (EST)
From: Bill Davidsen <davidsen@tmr.com>
X-X-Sender: root@oddball.prodigy.com
Reply-To: Bill Davidsen <davidsen@tmr.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [BUG] 2.5.54 sb16.c compile fails
Message-ID: <Pine.LNX.4.44.0301081123100.19953-100000@oddball.prodigy.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  gcc -Wp,-MD,sound/isa/sb/.sb16_main.o.d -D__KERNEL__ -Iinclude -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2 -march=i686 -Iinclude/asm-i386/mach-default -nostdinc -iwithprefix include -DMODULE   -DKBUILD_BASENAME=sb16_main -DKBUILD_MODNAME=snd_sb16_dsp -DEXPORT_SYMTAB  -c -o sound/isa/sb/sb16_main.o sound/isa/sb/sb16_main.c
  gcc -Wp,-MD,sound/isa/sb/.sb16.o.d -D__KERNEL__ -Iinclude -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2 -march=i686 -Iinclude/asm-i386/mach-default -nostdinc -iwithprefix include -DMODULE   -DKBUILD_BASENAME=sb16 -DKBUILD_MODNAME=snd_sb16   -c -o sound/isa/sb/sb16.o sound/isa/sb/sb16.c
sound/isa/sb/sb16.c: In function `snd_sb16_isapnp':
sound/isa/sb/sb16.c:276: warning: implicit declaration of function `isapnp_find_dev'
sound/isa/sb/sb16.c:276: warning: assignment makes pointer from integer without a cast
sound/isa/sb/sb16.c:277: structure has no member named `active'
sound/isa/sb/sb16.c:290: structure has no member named `prepare'
sound/isa/sb/sb16.c:293: warning: implicit declaration of function `isapnp_resource_change'
sound/isa/sb/sb16.c:304: structure has no member named `activate'
sound/isa/sb/sb16.c: In function `snd_sb16_deactivate':
sound/isa/sb/sb16.c:344: structure has no member named `deactivate'
sound/isa/sb/sb16.c: In function `alsa_card_sb16_init':
sound/isa/sb/sb16.c:629: warning: implicit declaration of function `isapnp_probe_cards'
make[3]: *** [sound/isa/sb/sb16.o] Error 1
make[2]: *** [sound/isa/sb] Error 2
make[1]: *** [sound/isa] Error 2
make: *** [sound] Error 2

