Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265857AbTBTNH3>; Thu, 20 Feb 2003 08:07:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265863AbTBTNH3>; Thu, 20 Feb 2003 08:07:29 -0500
Received: from mail2.sonytel.be ([195.0.45.172]:50851 "EHLO mail.sonytel.be")
	by vger.kernel.org with ESMTP id <S265857AbTBTNH2>;
	Thu, 20 Feb 2003 08:07:28 -0500
Date: Thu, 20 Feb 2003 14:16:46 +0100 (MET)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Linus Torvalds <torvalds@transmeta.com>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: PATCH: clean up the IDE iops, add ones for a dead iface
In-Reply-To: <E18lC5R-00067P-00@the-village.bc.nu>
Message-ID: <Pine.GSO.4.21.0302201415070.18109-100000@vervain.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 18 Feb 2003, Alan Cox wrote:
> -static void ide_outb (u8 value, ide_ioreg_t port)
> +static void ide_outb (u8 addr, unsigned long port)

> -static void ide_outw (u16 value, ide_ioreg_t port)
> +static void ide_outw (u16 addr, unsigned long port)

> -static void ide_outl (u32 value, ide_ioreg_t port)
> +static void ide_outl (u32 addr, unsigned long port)

The first parameter should be called `value', not `addr'.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

