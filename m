Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281295AbRKLHdC>; Mon, 12 Nov 2001 02:33:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281294AbRKLHcm>; Mon, 12 Nov 2001 02:32:42 -0500
Received: from main.sonytel.be ([195.0.45.167]:41083 "EHLO mail.sonytel.be")
	by vger.kernel.org with ESMTP id <S281295AbRKLHcj>;
	Mon, 12 Nov 2001 02:32:39 -0500
Date: Mon, 12 Nov 2001 08:31:47 +0100 (MET)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: James Simmons <jsimmons@transvirtual.com>
cc: Bakonyi Ferenc <fero@sztalker.hu>,
        Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: isa_* problems (hgafb is broken since 2.4.13)
In-Reply-To: <Pine.LNX.4.10.10111080917360.13456-100000@transvirtual.com>
Message-ID: <Pine.GSO.4.21.0111120828050.11251-100000@mullein.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 8 Nov 2001, James Simmons wrote:
> > I have two questions about asm-i386/io.h:
> > 1. Why #define __ISA_IO_base ((char *)(PAGE_OFFSET)) ?
> > 2. Why not #define __ISA_IO_base ((char *)0) ?
>
> For ix86 the ISA IO space start is at the very begining of memory. On
> other platforms like the PPC the ISA IO space is seperate from the
> regular memory space. It starts after the regular memory space thus the
> __ISA_IO_base will not be 0x0.

He's talking about asm-i386/io.h.

__ISA_IO_base (what's in a name, why not call it __ISA_MEM_base?!?!?) is the
kernel virtual address of the start of ISA _memory_ space. On ia32 PCs, ISA
memory space overlaps with the first 16 MB of real RAM, at CPU physical address
0.

(DISCLAIMER: my ia32 knowledge is limited)

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

