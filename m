Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751200AbVKTJwQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751200AbVKTJwQ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Nov 2005 04:52:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751202AbVKTJwQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Nov 2005 04:52:16 -0500
Received: from witte.sonytel.be ([80.88.33.193]:31469 "EHLO witte.sonytel.be")
	by vger.kernel.org with ESMTP id S1751200AbVKTJwQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Nov 2005 04:52:16 -0500
Date: Sun, 20 Nov 2005 10:52:00 +0100 (CET)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Dmitry Torokhov <dtor_core@ameritech.net>
cc: Linus Torvalds <torvalds@osdl.org>, Vojtech Pavlik <vojtech@suse.cz>,
       Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [git pull 03/14] Wistron - disable for x86_64
In-Reply-To: <20051120064419.680523000.dtor_core@ameritech.net>
Message-ID: <Pine.LNX.4.62.0511201051360.2941@numbat.sonytel.be>
References: <20051120063611.269343000.dtor_core@ameritech.net>
 <20051120064419.680523000.dtor_core@ameritech.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 20 Nov 2005, Dmitry Torokhov wrote:
> From: Andrew Morton <akpm@osdl.org>
> 
> Input: wistron - disable for x86_64
> 
> On x86_64:
> 
> {standard input}:233: Error: suffix or operands invalid for `push'
> {standard input}:233: Error: suffix or operands invalid for `pop'
> 
> Signed-off-by: Andrew Morton <akpm@osdl.org>
> Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
> ---
> 
>  drivers/input/misc/Kconfig |    2 +-
>  1 files changed, 1 insertion(+), 1 deletion(-)
> 
> Index: work/drivers/input/misc/Kconfig
> ===================================================================
> --- work.orig/drivers/input/misc/Kconfig
> +++ work/drivers/input/misc/Kconfig
> @@ -42,7 +42,7 @@ config INPUT_M68K_BEEP
>  
>  config INPUT_WISTRON_BTNS
>  	tristate "x86 Wistron laptop button interface"
> -	depends on X86
> +	depends on X86 && !X86_64
                   ^^^^^^^^^^^^^^
That should be just `X86_32' these days.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
