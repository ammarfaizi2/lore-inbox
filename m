Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269621AbUICLcZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269621AbUICLcZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Sep 2004 07:32:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269622AbUICLcZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Sep 2004 07:32:25 -0400
Received: from witte.sonytel.be ([80.88.33.193]:5588 "EHLO witte.sonytel.be")
	by vger.kernel.org with ESMTP id S269621AbUICLcX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Sep 2004 07:32:23 -0400
Date: Fri, 3 Sep 2004 13:32:19 +0200 (MEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Kalin KOZHUHAROV <kalin@thinrope.net>
cc: Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2.6.8.1 0/2] leds: new class for led devices
In-Reply-To: <ch8tdd$1uf$1@sea.gmane.org>
Message-ID: <Pine.GSO.4.58.0409031331210.24343@waterleaf.sonytel.be>
References: <1094157190l.4235l.2l@hydra> <ch8tdd$1uf$1@sea.gmane.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 3 Sep 2004, Kalin KOZHUHAROV wrote:
> > function : a read/write attribute that sets the current function of
> > this led.  The available options are
> >
> >  timer : the led blinks on and off on a timer
> >  idle : the led turns off when the system is idle and on when not idle
> >  power : the led represents the current power state
> >  user : the led is controlled by user space
>
> Please put the power comment in the source too, e.g. :
>
> +enum led_functions {
> +	leds_user = 0,	/* user has control of this led through sysfs */
> +	leds_timer,	/* led blinks on a timer */
> +	leds_idle,	/* led is on when the system is not idle */
> +	leds_power,	/* led is on when ?????????????????????? */
> +};
>
> To be honest, I don't get the meaning of any of the led_functions except leds_user...

leds_timer means something like a heartbeat (cfr. PPC and m68k)? Or do you need
a separate `heartbeat' option for that?

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
