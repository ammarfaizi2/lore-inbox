Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261555AbUJaLcw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261555AbUJaLcw (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 31 Oct 2004 06:32:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261554AbUJaLcv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 31 Oct 2004 06:32:51 -0500
Received: from gprs187-64.eurotel.cz ([160.218.187.64]:51842 "EHLO
	midnight.suse.cz") by vger.kernel.org with ESMTP id S261561AbUJaKOd
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 31 Oct 2004 05:14:33 -0500
Date: Sun, 31 Oct 2004 11:14:25 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 517] M68k: Disable SERIO_I8042, except on Q40/Q60
Message-ID: <20041031101425.GA1343@ucw.cz>
References: <200410311003.i9VA3f6H009703@anakin.of.borg>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200410311003.i9VA3f6H009703@anakin.of.borg>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 31, 2004 at 11:03:41AM +0100, Geert Uytterhoeven wrote:

> M68k: Disable SERIO_I8042, except on Q40/Q60

I thought Q40 uses the q40kbd.c driver and shouldn't need i8042 either?

> 
> Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
> 
> --- linux-2.6.10-rc1/drivers/input/serio/Kconfig	2004-09-30 12:53:37.000000000 +0200
> +++ linux-m68k-2.6.10-rc1/drivers/input/serio/Kconfig	2004-10-27 23:16:43.000000000 +0200
> @@ -20,7 +20,7 @@ config SERIO_I8042
>  	tristate "i8042 PC Keyboard controller" if EMBEDDED || !X86
>  	default y
>  	select SERIO
> -	depends on !PARISC && (!ARM || ARCH_SHARK || FOOTBRIDGE_HOST)
> +	depends on !PARISC && (!ARM || ARCH_SHARK || FOOTBRIDGE_HOST) && (!M68K || Q40)
>  	---help---
>  	  i8042 is the chip over which the standard AT keyboard and PS/2
>  	  mouse are connected to the computer. If you use these devices,
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
> 

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
