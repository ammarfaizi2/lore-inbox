Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315902AbSEGQ7j>; Tue, 7 May 2002 12:59:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315903AbSEGQ7i>; Tue, 7 May 2002 12:59:38 -0400
Received: from mail.sonytel.be ([193.74.243.200]:25078 "EHLO mail.sonytel.be")
	by vger.kernel.org with ESMTP id <S315902AbSEGQ7i>;
	Tue, 7 May 2002 12:59:38 -0400
Date: Tue, 7 May 2002 18:59:04 +0200 (MEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
cc: Roman Zippel <zippel@linux-m68k.org>,
        Martin Dalecki <dalecki@evision-ventures.com>,
        Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.5.14 IDE 55
In-Reply-To: <Pine.SOL.4.30.0205071653140.29509-100000@mion.elka.pw.edu.pl>
Message-ID: <Pine.GSO.4.21.0205071853400.14470-100000@vervain.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 7 May 2002, Bartlomiej Zolnierkiewicz wrote:
> On Tue, 7 May 2002, Roman Zippel wrote:
> > > BTW.> It should indeed take both in to account as far as I can
> > > see.(Despite the fact that I could affort an ATARI I hardly
> > > can find one...)
> >
> > That's not necessary, but I'm only afraid that functionality gets lost,
> > which isn't needed on the latest hardware.
> >
> > bye, Roman
> 
> we should fix atari byte-swapped ide in ata_read() like we do in
> atapi_read() then ide_fix_driveid() will make rest...
> (or I am missing something?)

Here you can mix two different issues:
  - Ataris have a byte-swapped IDE interface. Hence we need support to swap
    data for interoperability (not only on Atari: imagine an Atari disk
    connected to a PC)
  - IDE is little endian, so the drive identification is little endian too.
    To make things more complex, not only multibyte objects, but also text
    strings are byteswapped.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

