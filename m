Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129318AbRCLBOO>; Sun, 11 Mar 2001 20:14:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129323AbRCLBOF>; Sun, 11 Mar 2001 20:14:05 -0500
Received: from saturn.cs.uml.edu ([129.63.8.2]:33287 "EHLO saturn.cs.uml.edu")
	by vger.kernel.org with ESMTP id <S129318AbRCLBN4>;
	Sun, 11 Mar 2001 20:13:56 -0500
From: "Albert D. Cahalan" <acahalan@cs.uml.edu>
Message-Id: <200103120112.f2C1Csj165543@saturn.cs.uml.edu>
Subject: Re: [PATCH] Penguin logos
To: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Sun, 11 Mar 2001 20:12:54 -0500 (EST)
Cc: linux-kernel@vger.kernel.org (Linux Kernel Development),
        linux-fbdev-devel@lists.sourceforge.net (Linux Frame Buffer Device
	Development)
In-Reply-To: <Pine.LNX.4.05.10103082052340.432-100000@callisto.of.borg> from "Geert Uytterhoeven" at Mar 08, 2001 09:12:32 PM
X-Mailer: ELM [version 2.5 PL2]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Geert Uytterhoeven writes:

>   - The colors for the 16 color logo are wrong. We used a hack to
>     give the logo its own color palette, but this no longer works
>     as a side effect of a console color map bug being fixed a while
>     ago. The solution is to replace the logo with a new one that
>     uses the standard VGA console palette.

Good idea, but the feet don't look too good. Either dither a bit,
or pick a single color for the feet. Maybe a checkerboard-dither
would get close to the right color without looking grainy.

>   - There are still some politically-incorrect (PI) logos of a penguin
>     holding a glass of beer or wine (or perhaps even worse? :-).

Those also just look bad. The drink sort of floats above the penguin's
foot. It really looks like it was just pasted onto the image.

The arch-specific logos look bad in general, and the swirly gray
background isn't so great either. Why not use the original image?

> Changes:
>  1. Update the frame buffer console code to no longer change the
>     palette when displaying the 16 color logo. Remove the tricks
>     to load the logo palette in unused palette entries on displays
>     with >= 32 colors.

I used to have only 256 colors on my display. I upgraded because
there still isn't a global system palette. I'd have been happy
enough with 256 colors allocated in a sane way, for kernel & X:

1. the 16 VGA colors and extra 4 Windows colors (so Wine can work)
2. the 216 Netscape colors
3. gray: 0x00, 0x11, 0x22... 0xff, plus both 0x7f and 0x80
4. everything else reserved for future global allocation

The current situation is way too painful to use.

