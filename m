Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262470AbTFJI5v (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jun 2003 04:57:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262482AbTFJI5v
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jun 2003 04:57:51 -0400
Received: from mail2.sonytel.be ([195.0.45.172]:32405 "EHLO witte.sonytel.be")
	by vger.kernel.org with ESMTP id S262470AbTFJI5u (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jun 2003 04:57:50 -0400
Date: Tue, 10 Jun 2003 11:11:27 +0200 (MEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Jurgen Kramer <gtm.kramer@inter.nl.net>
cc: Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: Completely disable AT/PS2 keyboard support in 2.4?
In-Reply-To: <1055169922.4052.3.camel@paragon.slim>
Message-ID: <Pine.GSO.4.21.0306101110320.1661-100000@vervain.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 9 Jun 2003, Jurgen Kramer wrote:
> My arrow keys are working just fine. The "can't emulate rawmode for
> keycode" messages seem to appear without a key being pressed. The
> keyboard or the keyboard receiver (it's a wireless keyboard) is probably
> just sending out keycodes at will...

OK, so the arrow-keys (and other keys generating E0/E1-prefixed scancodes) not
working happens on `other' architectures only (e.g. MIPS with dummy
keyboard.c).

> On Mon, 2003-06-09 at 15:34, Geert Uytterhoeven wrote:
> > On 9 Jun 2003, Jurgen Kramer wrote:
> > > Is it possible to completely disable AT/PS2 keyboard support
> > > in 2.4 or is this still needed when I only use a USB keyboard?
> > > 
> > > I am currently getting dozens of keyboard messages:
> > > 
> > > keyboard.c: can't emulate rawmode for keycode 272
> > > keyboard.c: can't emulate rawmode for keycode 272
> > > keyboard.c: can't emulate rawmode for keycode 272
> > > keyboard.c: can't emulate rawmode for keycode 272
> > > keyboard.c: can't emulate rawmode for keycode 272
> > > keyboard.c: can't emulate rawmode for keycode 272
> > > keyboard.c: can't emulate rawmode for keycode 272
> > > keyboard.c: can't emulate rawmode for keycode 272
> > > 
> > > I am not sure if the comes from the USB keyboard or from
> > > the non-connected PS2 port.
> > 
> > In 2.4.x, the input layer converts input events to PC/AT scancodes, and still
> > relies on the PS/2 low-level keyboard driver scancode conversion to interprete
> > them. This means you must include the PS/2 low-level keyboard driver. If you
> > don't, you may get strange results, especially on architectures where you have
> > a different low-level keyboard driver.
> > 
> > BTW, I guess your arrow keys are not working?

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

