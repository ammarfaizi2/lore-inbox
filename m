Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267289AbTABW5M>; Thu, 2 Jan 2003 17:57:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266652AbTABW5M>; Thu, 2 Jan 2003 17:57:12 -0500
Received: from mail2.sonytel.be ([195.0.45.172]:24263 "EHLO mail.sonytel.be")
	by vger.kernel.org with ESMTP id <S266622AbTABW5K>;
	Thu, 2 Jan 2003 17:57:10 -0500
Date: Fri, 3 Jan 2003 00:05:08 +0100 (MET)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Tomas Szepe <szepe@pinerecords.com>
cc: Linus Torvalds <torvalds@transmeta.com>, Jeff Garzik <jgarzik@pobox.com>,
       zaitcev@redhat.com, "David S. Miller" <davem@redhat.com>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>,
       sparclinux@vger.kernel.org,
       Linux/m68k <linux-m68k@lists.linux-m68k.org>,
       netfilter-devel@lists.samba.org, phillim2@comcast.net,
       Russell King <rmk@arm.linux.org.uk>
Subject: Re: [PATCHSET] Multiarch kconfig cleanup
In-Reply-To: <20030102182038.GZ17053@louise.pinerecords.com>
Message-ID: <Pine.GSO.4.21.0301022358340.6446-100000@vervain.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2 Jan 2003, Tomas Szepe wrote:
> On with the [mainly networking oriented] Kconfig clean-up saga.
> 
> This is the first time I'm trying to get more than 3 people to work
> together so I'd be grateful if you didn't kick me too hard should I have
> screwed up.

> 19/36  x15-arch-m68k          SPECIAL: Tear down m68k NETDEVICES config 

Looks OK.

> 20/36  x15-arch-m68k_nommu    Tear down m68k_nommu NETDEVICES config

Not under our jurisdiction.

> 34/36  x15-net.2-m68k         2/2 -""- (and re-add m68k specific drivers)

Actually CONFIG_ARIADNE2 and CONFIG_NE2K_ZORRO are the same. We introduced the
latter in the old Configure.help when the Ariadne II driver got X-Surf support,
but forgot to replace the former in the Makefile logic. And the driver is still
called ariadne2.c.

linux-m68k: Should we kill CONFIG_NE2K_ZORRO, or kill CONFIG_ARIADNE2 and
rename the driver to ne2k-zorro.c?

> 35/36  x16                    Add the unified NETDEVICES submenu

Looks OK.

> sparc32 and m68k are special in that they define their specific netdevices
> in arch/{sparc,m68k}/Kconfig.

Mainly to avoid seeing too many entries for devices we can't support (e.g. old
ISA adapters)...

> ACKLIST is as follows, i.e. people listed please ACK at least:
> 	(m68k people)		#19, #20, #34, #35

> x86 seems to work as expected.  I also tried to compile sparc32 but found
> out 2.5.54 vanilla itself was broken for it -- the .config looked sane,
> though.

Disclaimer: I didn't try to compile, I just looked at the patches.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

