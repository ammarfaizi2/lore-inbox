Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311252AbSCLPo6>; Tue, 12 Mar 2002 10:44:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311253AbSCLPol>; Tue, 12 Mar 2002 10:44:41 -0500
Received: from mail.sonytel.be ([193.74.243.200]:27546 "EHLO mail.sonytel.be")
	by vger.kernel.org with ESMTP id <S311252AbSCLPoW>;
	Tue, 12 Mar 2002 10:44:22 -0500
Date: Tue, 12 Mar 2002 16:43:39 +0100 (MET)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.4.19-pre3
In-Reply-To: <Pine.LNX.4.21.0203111805480.2492-100000@freak.distro.conectiva>
Message-ID: <Pine.GSO.4.21.0203121639340.23527-100000@vervain.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 11 Mar 2002, Marcelo Tosatti wrote:
> Here goes -pre3, with the new IDE code. It has been stable enough time in
> the -ac tree, in my and Alan's opinion.
> 
> The inclusion of the new IDE code makes me want to have a longer 2.4.19
> release cycle, for stress-testing reasons.

It looks like {IN,OUT}_{BYTE,WORD}() are now the arch-specific routines to
access the IDE registers, controlled by HAVE_ARCH_{IN,OUT}_BYTE?

If yes,
  - Why not call them ide_{in,out}[bw]()?
  - What about {in,out}s[wl]{,_swapw}()? Don't we need abstractions for those
    as well?
  - The old (ISA/PCI I/O only) {in,out}[bwl]() are still used in many places.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

