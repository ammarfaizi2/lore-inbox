Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264276AbTFINUo (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Jun 2003 09:20:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264277AbTFINUo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Jun 2003 09:20:44 -0400
Received: from mail2.sonytel.be ([195.0.45.172]:8190 "EHLO witte.sonytel.be")
	by vger.kernel.org with ESMTP id S264276AbTFINUn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Jun 2003 09:20:43 -0400
Date: Mon, 9 Jun 2003 15:34:19 +0200 (MEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Jurgen Kramer <gtm.kramer@inter.nl.net>
cc: Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: Completely disable AT/PS2 keyboard support in 2.4?
In-Reply-To: <1055156075.3824.7.camel@paragon.slim>
Message-ID: <Pine.GSO.4.21.0306091529480.1347-100000@vervain.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 9 Jun 2003, Jurgen Kramer wrote:
> Is it possible to completely disable AT/PS2 keyboard support
> in 2.4 or is this still needed when I only use a USB keyboard?
> 
> I am currently getting dozens of keyboard messages:
> 
> keyboard.c: can't emulate rawmode for keycode 272
> keyboard.c: can't emulate rawmode for keycode 272
> keyboard.c: can't emulate rawmode for keycode 272
> keyboard.c: can't emulate rawmode for keycode 272
> keyboard.c: can't emulate rawmode for keycode 272
> keyboard.c: can't emulate rawmode for keycode 272
> keyboard.c: can't emulate rawmode for keycode 272
> keyboard.c: can't emulate rawmode for keycode 272
> 
> I am not sure if the comes from the USB keyboard or from
> the non-connected PS2 port.

In 2.4.x, the input layer converts input events to PC/AT scancodes, and still
relies on the PS/2 low-level keyboard driver scancode conversion to interprete
them. This means you must include the PS/2 low-level keyboard driver. If you
don't, you may get strange results, especially on architectures where you have
a different low-level keyboard driver.

BTW, I guess your arrow keys are not working?

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

