Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266256AbUGTUFL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266256AbUGTUFL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jul 2004 16:05:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266153AbUGTUEJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jul 2004 16:04:09 -0400
Received: from ffke-campus-gw.mipt.ru ([194.85.82.65]:5289 "EHLO
	ffke-campus-gw.mipt.ru") by vger.kernel.org with ESMTP
	id S266243AbUGTUCL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jul 2004 16:02:11 -0400
Date: Wed, 21 Jul 2004 00:13:53 +0400
From: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Greg Kroah-Hartman <greg@kroah.com>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>,
       Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH] depends on PCI: Matrox 1-wire
Message-Id: <20040721001353.4d4be91d@zanzibar.2ka.mipt.ru>
In-Reply-To: <200407201839.i6KIdpOu015555@anakin.of.borg>
References: <200407201839.i6KIdpOu015555@anakin.of.borg>
Reply-To: johnpol@2ka.mipt.ru
Organization: MIPT
X-Mailer: Sylpheed version 0.9.11claws (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 20 Jul 2004 20:39:51 +0200
Geert Uytterhoeven <geert@linux-m68k.org> wrote:

> Matrox 1-wire unconditionally depends on PCI

You are absulutely right.
Your second patch for matrox_w1.c is also correct.
Please apply.

Thank you.

> Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
> 
> --- linux-2.6.8-rc2/drivers/w1/Kconfig	2004-07-18 15:55:33.000000000 +0200
> +++ linux-m68k-2.6.8-rc2/drivers/w1/Kconfig	2004-07-19 00:03:26.000000000 +0200
> @@ -13,7 +13,7 @@
>  
>  config W1_MATROX
>  	tristate "Matrox G400 transport layer for 1-wire"
> -	depends on W1
> +	depends on W1 && PCI
>  	help
>  	  Say Y here if you want to communicate with your 1-wire devices
>  	  using Matrox's G400 GPIO pins.
> 
> Gr{oetje,eeting}s,
> 
> 						Geert
> 
> --
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 --
> geert@linux-m68k.org
> 
> In personal conversations with technical people, I call myself a
> hacker. But when I'm talking to journalists I just say "programmer" or
> something like that.
> 							    -- Linus Torvalds


	Evgeniy Polyakov ( s0mbre )

Only failure makes us experts. -- Theo de Raadt
