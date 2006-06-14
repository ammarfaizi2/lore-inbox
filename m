Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751258AbWFNMU2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751258AbWFNMU2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jun 2006 08:20:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751281AbWFNMU2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jun 2006 08:20:28 -0400
Received: from witte.sonytel.be ([80.88.33.193]:49864 "EHLO witte.sonytel.be")
	by vger.kernel.org with ESMTP id S1751258AbWFNMU2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jun 2006 08:20:28 -0400
Date: Wed, 14 Jun 2006 14:20:06 +0200 (CEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Greg KH <greg@kroah.com>
cc: Linux Kernel Development <linux-kernel@vger.kernel.org>,
       Greg Kroah-Hartman <gregkh@suse.de>
Subject: Re: [PATCH 16/16] 64bit Resource: finally enable 64bit resource
 sizes
In-Reply-To: <11501587343689-git-send-email-greg@kroah.com>
Message-ID: <Pine.LNX.4.62.0606141417430.1886@pademelon.sonytel.be>
References: <20060613003033.GA10717@kroah.com> <11501586781628-git-send-email-greg@kroah.com>
 <1150158683636-git-send-email-greg@kroah.com> <11501586871870-git-send-email-greg@kroah.com>
 <11501586902008-git-send-email-greg@kroah.com> <11501586942938-git-send-email-greg@kroah.com>
 <11501586982289-git-send-email-greg@kroah.com> <11501587011194-git-send-email-greg@kroah.com>
 <11501587043722-git-send-email-greg@kroah.com> <11501587082203-git-send-email-greg@kroah.com>
 <11501587122736-git-send-email-greg@kroah.com> <11501587153872-git-send-email-greg@kroah.com>
 <11501587193060-git-send-email-greg@kroah.com> <11501587223213-git-send-email-greg@kroah.com>
 <11501587273612-git-send-email-greg@kroah.com> <11501587303683-git-send-email-greg@kroah.com>
 <11501587343689-git-send-email-greg@kroah.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 12 Jun 2006, Greg KH wrote:
> From: Greg Kroah-Hartman <gregkh@suse.de>
> 
> Introduce the Kconfig entry and actually switch to a 64bit value, if
> wanted, for resource_size_t.

> diff --git a/arch/m68k/Kconfig b/arch/m68k/Kconfig
> index 805b81f..22dcaa5 100644
> --- a/arch/m68k/Kconfig
> +++ b/arch/m68k/Kconfig
> @@ -368,6 +368,13 @@ config 060_WRITETHROUGH
>  
>  source "mm/Kconfig"
>  
> +config RESOURCES_32BIT
> +	bool "32 bit Memory and IO resources (EXPERIMENTAL)"
> +	depends on EXPERIMENTAL
> +	help
> +	  By default resources are 64 bit. This option allows memory and IO
> +	  resources to be 32 bit to optimize code size.
> +
>  endmenu

Why is the default 64 bit? Because 32 bit became experimental?

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
