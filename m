Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264214AbRFSMoP>; Tue, 19 Jun 2001 08:44:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264216AbRFSMoF>; Tue, 19 Jun 2001 08:44:05 -0400
Received: from pD900F050.dip.t-dialin.net ([217.0.240.80]:7428 "EHLO
	neon.hh59.org") by vger.kernel.org with ESMTP id <S264214AbRFSMn7>;
	Tue, 19 Jun 2001 08:43:59 -0400
Date: Tue, 19 Jun 2001 14:44:16 +0200 (CEST)
From: <axel@rayfun.org>
X-X-Sender: <axel@neon.hh59.org>
To: Miles Lane <miles@megapathdsl.net>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.5-ac15 -- Unresolved symbols "gameport_register_port" and
 "gameport_unregister_port" in char/joystick/[cs461x.o, emu10k1-gp.o,
 lightning.o, ns558.o, pcigame.o]
In-Reply-To: <992892690.11752.0.camel@agate>
Message-ID: <Pine.LNX.4.31.0106191439050.6488-100000@neon.hh59.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi,

something similar is happening with my kernel 2.4.5-ac15 compilation.

drivers/sound/sounddrivers.o: In function `es1371_probe':
drivers/sound/sounddrivers.o(.text.init+0xddb): undefined reference to
`gameport_register_port'
drivers/sound/sounddrivers.o: In function `es1371_remove':
drivers/sound/sounddrivers.o(.text.init+0xf1a): undefined reference to
`gameport_unregister_port'
make: *** [vmlinux] Error 1

there is nothing configured for gameport stuff etc.
i attached my .config, maybe it's of help.

axel


On 18 Jun 2001, Miles Lane wrote:

> I don't know if this is due to symbols not being exported or due
> to some failed dependency structuring in "make menuconfig".
>
> find kernel -path '*/pcmcia/*' -name '*.o' | xargs -i -r ln -sf ../{}
> pcmcia
> if [ -r System.map ]; then /sbin/depmod -ae -F System.map  2.4.5-ac15;
> fi
> depmod: *** Unresolved symbols in
> /lib/modules/2.4.5-ac15/kernel/drivers/char/joystick/cs461x.o
> depmod: 	gameport_register_port
> depmod: 	gameport_unregister_port
> depmod: *** Unresolved symbols in
> /lib/modules/2.4.5-ac15/kernel/drivers/char/joystick/emu10k1-gp.o
> depmod: 	gameport_register_port
> depmod: 	gameport_unregister_port
> depmod: *** Unresolved symbols in
> /lib/modules/2.4.5-ac15/kernel/drivers/char/joystick/lightning.o
> depmod: 	gameport_register_port
> depmod: 	gameport_unregister_port
> depmod: *** Unresolved symbols in
> /lib/modules/2.4.5-ac15/kernel/drivers/char/joystick/ns558.o
> depmod: 	gameport_register_port
> depmod: 	gameport_unregister_port
> depmod: *** Unresolved symbols in
> /lib/modules/2.4.5-ac15/kernel/drivers/char/joystick/pcigame.o
> depmod: 	gameport_register_port
> depmod: 	gameport_unregister_port
>
> Here are the relevant .config bits:
>
> CONFIG_INPUT_GAMEPORT=y
> CONFIG_INPUT_NS558=m
> CONFIG_INPUT_LIGHTNING=m
> CONFIG_INPUT_PCIGAME=m
> CONFIG_INPUT_CS461X=m
> CONFIG_INPUT_EMU10K1=m
> CONFIG_INPUT_SERIO=m
> CONFIG_INPUT_SERPORT=m
> # CONFIG_INPUT_ANALOG is not set
> # CONFIG_INPUT_A3D is not set
> # CONFIG_INPUT_ADI is not set
> # CONFIG_INPUT_COBRA is not set
> # CONFIG_INPUT_GF2K is not set
> # CONFIG_INPUT_GRIP is not set
> # CONFIG_INPUT_INTERACT is not set
> # CONFIG_INPUT_TMDC is not set
> # CONFIG_INPUT_SIDEWINDER is not set
> # CONFIG_INPUT_IFORCE_USB is not set
> # CONFIG_INPUT_IFORCE_232 is not set
> # CONFIG_INPUT_WARRIOR is not set
> # CONFIG_INPUT_MAGELLAN is not set
> # CONFIG_INPUT_SPACEORB is not set
> # CONFIG_INPUT_SPACEBALL is not set
> # CONFIG_INPUT_STINGER is not set
> # CONFIG_INPUT_DB9 is not set
> # CONFIG_INPUT_GAMECON is not set
> # CONFIG_INPUT_TURBOGRAFX is not set
> # CONFIG_QIC02_TAPE is not set
>
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

-- 

