Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750704AbVKKLDx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750704AbVKKLDx (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Nov 2005 06:03:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751246AbVKKLDx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Nov 2005 06:03:53 -0500
Received: from witte.sonytel.be ([80.88.33.193]:58293 "EHLO witte.sonytel.be")
	by vger.kernel.org with ESMTP id S1750704AbVKKLDw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Nov 2005 06:03:52 -0500
Date: Fri, 11 Nov 2005 12:03:47 +0100 (CET)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Matt Mackall <mpm@selenic.com>
cc: Andrew Morton <akpm@osdl.org>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 15/15] misc: Configurable support for PCI serial ports
In-Reply-To: <16.282480653@selenic.com>
Message-ID: <Pine.LNX.4.62.0511111203300.3956@numbat.sonytel.be>
References: <16.282480653@selenic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 11 Nov 2005, Matt Mackall wrote:
> --- 2.6.14-misc.orig/init/Kconfig	2005-11-09 11:27:26.000000000 -0800
> +++ 2.6.14-misc/init/Kconfig	2005-11-09 11:27:28.000000000 -0800
> @@ -473,6 +473,15 @@ config BOOTFLAG
>  	help
>  	  This enables support for the Simple Bootflag Specification.
>  
> +config SERIAL_PCI
> +	depends PCI && SERIAL_8250
> +	default y
> +	bool "Enable standard PCI serial support" if EMBEDDED
> +	help
> +	  This builds standard PCI serial support. You may be able to disable
> +          this feature if you are only need legacy serial support.
                                 ^^^

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
