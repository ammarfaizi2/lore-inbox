Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267625AbTAHRVn>; Wed, 8 Jan 2003 12:21:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267692AbTAHRVm>; Wed, 8 Jan 2003 12:21:42 -0500
Received: from [213.171.53.133] ([213.171.53.133]:65298 "EHLO gulipin.miee.ru")
	by vger.kernel.org with ESMTP id <S267625AbTAHRVK>;
	Wed, 8 Jan 2003 12:21:10 -0500
Date: Wed, 8 Jan 2003 20:28:28 +0300 (MSK)
From: "Ruslan U. Zakirov" <cubic@miee.ru>
To: Bill Davidsen <davidsen@tmr.com>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [BUG] 2.5.54 sb16.c compile fails
In-Reply-To: <Pine.LNX.4.44.0301081123100.19953-100000@oddball.prodigy.com>
Message-ID: <Pine.BSF.4.05.10301082024220.88742-100000@wildrose.miee.ru>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 8 Jan 2003, Bill Davidsen wrote:

>   gcc -Wp,-MD,sound/isa/sb/.sb16_main.o.d -D__KERNEL__ -Iinclude -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2 -march=i686 -Iinclude/asm-i386/mach-default -nostdinc -iwithprefix include -DMODULE   -DKBUILD_BASENAME=sb16_main -DKBUILD_MODNAME=snd_sb16_dsp -DEXPORT_SYMTAB  -c -o sound/isa/sb/sb16_main.o sound/isa/sb/sb16_main.c
>   gcc -Wp,-MD,sound/isa/sb/.sb16.o.d -D__KERNEL__ -Iinclude -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2 -march=i686 -Iinclude/asm-i386/mach-default -nostdinc -iwithprefix include -DMODULE   -DKBUILD_BASENAME=sb16 -DKBUILD_MODNAME=snd_sb16   -c -o sound/isa/sb/sb16.o sound/isa/sb/sb16.c
> sound/isa/sb/sb16.c: In function `snd_sb16_isapnp':
> sound/isa/sb/sb16.c:276: warning: implicit declaration of function `isapnp_find_dev'
> sound/isa/sb/sb16.c:276: warning: assignment makes pointer from integer without a cast
> sound/isa/sb/sb16.c:277: structure has no member named `active'
> sound/isa/sb/sb16.c:290: structure has no member named `prepare'
> sound/isa/sb/sb16.c:293: warning: implicit declaration of function `isapnp_resource_change'
> sound/isa/sb/sb16.c:304: structure has no member named `activate'
> sound/isa/sb/sb16.c: In function `snd_sb16_deactivate':
> sound/isa/sb/sb16.c:344: structure has no member named `deactivate'
> sound/isa/sb/sb16.c: In function `alsa_card_sb16_init':
> sound/isa/sb/sb16.c:629: warning: implicit declaration of function `isapnp_probe_cards'
> make[3]: *** [sound/isa/sb/sb16.o] Error 1
> make[2]: *** [sound/isa/sb] Error 2
> make[1]: *** [sound/isa] Error 2
> make: *** [sound] Error 2
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 
Hello!
All this errors relay to new PnP layer implementation.
I've send PATCH to SB16/AWE32 card just now. 
If you have this card, can you test it and send me results?
			Ruslan.

