Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262783AbSLaJJ3>; Tue, 31 Dec 2002 04:09:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262796AbSLaJJ3>; Tue, 31 Dec 2002 04:09:29 -0500
Received: from mail2.sonytel.be ([195.0.45.172]:60141 "EHLO mail.sonytel.be")
	by vger.kernel.org with ESMTP id <S262783AbSLaJJ2>;
	Tue, 31 Dec 2002 04:09:28 -0500
Date: Tue, 31 Dec 2002 10:17:35 +0100 (MET)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Roberto De Leo <deleo@unica.it>
cc: Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: fbdev - boot parameter question
In-Reply-To: <3E10EDC8.4030006@unica.it>
Message-ID: <Pine.GSO.4.21.0212311012320.26852-100000@vervain.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 31 Dec 2002, Roberto De Leo wrote:
> I am developing a mini linux CD distro (movix.sf.net) and I would like 
> to set up the boot in the following way:  by default the CD should boot 
> with the vesa FB support on, but for those cards for which the vesa FB 
> fails the kernel should switch _automatically_ to the standard setting 
> it would use if it had started with the "video=vesa:off" boot parameter.

Do you really need the "video=vesa:off" boot parameter? If no VESA graphics
mode was activated by the boot loader, vesafb will not start. If your kernel
contains both vesafb and vgacon, it will fall back to VGA text mode.

> What I get now when vesa FB fails to load is instead the kernel prompt 
> asking the user to choose among all available console modes, and I would 
> be very happy if I could avoid that.

This is not the kernel prompt, but the prompt of your bootloader. So you should
modify your bootloader to not ask you for a mode if the wanted VESA graphics
mode is not available, but to continue with VGA text.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

