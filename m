Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291635AbSBAJRy>; Fri, 1 Feb 2002 04:17:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291628AbSBAJPR>; Fri, 1 Feb 2002 04:15:17 -0500
Received: from mail.sonytel.be ([193.74.243.200]:54949 "EHLO mail.sonytel.be")
	by vger.kernel.org with ESMTP id <S291624AbSBAJOu>;
	Fri, 1 Feb 2002 04:14:50 -0500
Date: Fri, 1 Feb 2002 10:10:42 +0100 (MET)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Simon Richter <Simon.Richter@fs.tum.de>
cc: Roman Zippel <zippel@linux-m68k.org>,
        James Simmons <jsimmons@transvirtual.com>,
        Linux/m68k <linux-m68k@lists.linux-m68k.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] amiga input api drivers
In-Reply-To: <Pine.LNX.4.33.0202010141100.14728-100000@phobos.fachschaften.tu-muenchen.de>
Message-ID: <Pine.GSO.4.21.0202011009480.25104-100000@vervain.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 1 Feb 2002, Simon Richter wrote:
> On Fri, 1 Feb 2002, Roman Zippel wrote:
> > > > > +   scancode = scancode >> 1;       /* lowest bit is release bit */
> > > > > +   down = scancode & 1;
> 
> > He's correct, the up/down event is received in the lsb bit, the other 7
> > bits are the keycode.
> 
> Well, I'm also unsure you mean the LSB here -- The hardware manual says
> that bit 7 indicates that the key had been released.

Yes, but that's after rotating. The old code did

    /* rotate scan code to get up/down bit in proper position */
    scancode = ((scancode >> 1) & 0x7f) | ((scancode << 7) & 0x80);

first.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

