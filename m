Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264389AbTFIOfA (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Jun 2003 10:35:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264394AbTFIOfA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Jun 2003 10:35:00 -0400
Received: from slimnet.xs4all.nl ([194.109.194.192]:9161 "EHLO gatekeeper.slim")
	by vger.kernel.org with ESMTP id S264389AbTFIObn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Jun 2003 10:31:43 -0400
Subject: Re: Completely disable AT/PS2 keyboard support in 2.4?
From: Jurgen Kramer <gtm.kramer@inter.nl.net>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Linux Kernel Development <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.GSO.4.21.0306091529480.1347-100000@vervain.sonytel.be>
References: <Pine.GSO.4.21.0306091529480.1347-100000@vervain.sonytel.be>
Content-Type: text/plain
Organization: 
Message-Id: <1055169922.4052.3.camel@paragon.slim>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 09 Jun 2003 16:45:22 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

My arrow keys are working just fine. The "can't emulate rawmode for
keycode" messages seem to appear without a key being pressed. The
keyboard or the keyboard receiver (it's a wireless keyboard) is probably
just sending out keycodes at will...


On Mon, 2003-06-09 at 15:34, Geert Uytterhoeven wrote:
> On 9 Jun 2003, Jurgen Kramer wrote:
> > Is it possible to completely disable AT/PS2 keyboard support
> > in 2.4 or is this still needed when I only use a USB keyboard?
> > 
> > I am currently getting dozens of keyboard messages:
> > 
> > keyboard.c: can't emulate rawmode for keycode 272
> > keyboard.c: can't emulate rawmode for keycode 272
> > keyboard.c: can't emulate rawmode for keycode 272
> > keyboard.c: can't emulate rawmode for keycode 272
> > keyboard.c: can't emulate rawmode for keycode 272
> > keyboard.c: can't emulate rawmode for keycode 272
> > keyboard.c: can't emulate rawmode for keycode 272
> > keyboard.c: can't emulate rawmode for keycode 272
> > 
> > I am not sure if the comes from the USB keyboard or from
> > the non-connected PS2 port.
> 
> In 2.4.x, the input layer converts input events to PC/AT scancodes, and still
> relies on the PS/2 low-level keyboard driver scancode conversion to interprete
> them. This means you must include the PS/2 low-level keyboard driver. If you
> don't, you may get strange results, especially on architectures where you have
> a different low-level keyboard driver.
> 
> BTW, I guess your arrow keys are not working?
> 
> Gr{oetje,eeting}s,
> 
> 						Geert
> 
> --
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org
> 
> In personal conversations with technical people, I call myself a hacker. But
> when I'm talking to journalists I just say "programmer" or something like that.
> 							    -- Linus Torvalds

