Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291576AbSBHODX>; Fri, 8 Feb 2002 09:03:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291578AbSBHODM>; Fri, 8 Feb 2002 09:03:12 -0500
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.176.19]:26860 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id <S291576AbSBHODE>; Fri, 8 Feb 2002 09:03:04 -0500
Date: Fri, 8 Feb 2002 15:00:01 +0100 (CET)
From: Adrian Bunk <bunk@fs.tum.de>
X-X-Sender: bunk@mimas.fachschaften.tu-muenchen.de
To: Jeff Garzik <jgarzik@mandrakesoft.com>
cc: Marcelo Tosatti <marcelo@conectiva.com.br>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.4.18-pre9
In-Reply-To: <3C633608.2D0CDC51@mandrakesoft.com>
Message-ID: <Pine.NEB.4.44.0202081453220.5795-100000@mimas.fachschaften.tu-muenchen.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 7 Feb 2002, Jeff Garzik wrote:

> What driver are you having problems with?
>
> Typically this problem is solved by a one-line fix to a specific driver,
> in 2.4.x.

Hi Jeff,

I tried to compile a non-modular 2.4.18-pre9 with as much as possible
enabled. With this kernel the final linking shows the following .text.exit
errors:

drivers/char/char.o: In function `mwave_init':
drivers/char/char.o(.text.init+0x10128): undefined reference to `local symbols in discarded section .text.exit'
drivers/char/char.o(.data+0x8214): undefined reference to `local symbols in discarded section .text.exit'
drivers/char/char.o(.data+0xafb4): undefined reference to `local symbols in discarded section .text.exit'
drivers/net/net.o(.data+0xab4): undefined reference to `local symbols in discarded section .text.exit'
drivers/net/net.o(.data+0xd7d4): undefined reference to `local symbols in discarded section .text.exit'
drivers/media/media.o(.text.init+0xc85): more undefined references to `local symbols in discarded section .text.exit' follow
drivers/atm/atm.o: In function `firestream_remove_one':
/home/bunk/linux/kernel-2.4/linux/drivers/atm/firestream.c:2009: undefined reference to `local symbols in discarded section .text.exit'
/home/bunk/linux/kernel-2.4/linux/drivers/atm/firestream.c:2010: undefined reference to `local symbols in discarded section .text.exit'
/home/bunk/linux/kernel-2.4/linux/drivers/atm/firestream.c:2011: undefined reference to `local symbols in discarded section .text.exit'
/home/bunk/linux/kernel-2.4/linux/drivers/atm/firestream.c:2012: undefined reference to `local symbols in discarded section .text.exit'
drivers/atm/atm.o:/home/bunk/linux/kernel-2.4/linux/drivers/atm/firestream.c:2018: more undefined references to `local symbols in discarded section .text.exit' follow
drivers/sound/sounddrivers.o: In function `unload_sbmpu':
drivers/sound/sounddrivers.o(.text+0x1507c): undefined reference to `unload_mpu401'
drivers/sound/sounddrivers.o(.data+0xd374): undefined reference to `local symbols in discarded section .text.exit'
drivers/sound/sounddrivers.o(.data+0x204b4): undefined reference to `local symbols in discarded section .text.exit'
drivers/sound/sounddrivers.o(.data+0x237d4): undefined reference to `local symbols in discarded section .text.exit'
drivers/mtd/mtdlink.o: In function `init_elan_104nc':
drivers/mtd/mtdlink.o(.text.init+0x201): undefined reference to `local symbols in discarded section .text.exit'
drivers/mtd/mtdlink.o: In function `init_sbc_gxx':
drivers/mtd/mtdlink.o(.text.init+0x7a9): undefined reference to `local symbols in discarded section .text.exit'

> 	Jeff

cu
Adrian


