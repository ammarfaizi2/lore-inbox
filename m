Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291296AbSAaU4e>; Thu, 31 Jan 2002 15:56:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291292AbSAaU4X>; Thu, 31 Jan 2002 15:56:23 -0500
Received: from mail.sonytel.be ([193.74.243.200]:452 "EHLO mail.sonytel.be")
	by vger.kernel.org with ESMTP id <S291294AbSAaU4J>;
	Thu, 31 Jan 2002 15:56:09 -0500
Date: Thu, 31 Jan 2002 21:54:51 +0100 (MET)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: James Simmons <jsimmons@transvirtual.com>, Vojtech Pavlik <vojtech@ucw.cz>
cc: Linux/m68k <linux-m68k@lists.linux-m68k.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] amiga input api drivers
In-Reply-To: <Pine.LNX.4.10.10201310712130.20956-100000@www.transvirtual.com>
Message-ID: <Pine.GSO.4.21.0201312153250.24581-100000@vervain.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 31 Jan 2002, James Simmons wrote:
>   The amiga mouse and amiga joystick have been already ported over to the
> input api. Now for the keyboard. This patch is the input api amiga
> keyboard. I wanted people to try it out before I send it off to be
> included in the DJ tree. Have fun!!!

> diff -urN -X /home/jsimmons/dontdiff linux-2.5.2-dj7/drivers/input/keyboard/amikbd.c linux/drivers/input/keyboard/amikbd.c
> --- linux-2.5.2-dj7/drivers/input/keyboard/amikbd.c	Wed Dec 31 16:00:00 1969
> +++ linux/drivers/input/keyboard/amikbd.c	Thu Jan 31 07:44:05 2002

> +static char *amikbd_messages[] = {
> +	KERN_ALERT "amikbd: Ctrl-Amiga-Amiga reset warning!!\n",
> +	KERN_WARNING "amikbd: keyboard lost sync\n",
> +	KERN_WARNING "amikbd: keyboard buffer overflow\n",
> +	KERN_WARNING "amikbd: keyboard controller failure\n",
> +	KERN_ERR "amikbd: keyboard selftest failure\n",
> +	KERN_INFO "amikbd: initiate power-up key stream\n",
> +	KERN_INFO "amikbd: terminate power-up key stream\n",
> +	KERN_WARNING "amikbd: keyboard interrupt\n"
> +};

> +	if (scancode < 0x78) {		/* scancodes < 0x78 are keys */

  [...]

> +	}
> +
> +	printk(amikbd_messages[scancode]);	/* scancodes >= 0x78 are error codes */

Oops, amikbd_messages[scancode-0x78]?

Gr{oetje,eeting}s,

						Geert (just reading patches)

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

