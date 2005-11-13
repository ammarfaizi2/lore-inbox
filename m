Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751347AbVKMRrb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751347AbVKMRrb (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Nov 2005 12:47:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751357AbVKMRrb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Nov 2005 12:47:31 -0500
Received: from witte.sonytel.be ([80.88.33.193]:62668 "EHLO witte.sonytel.be")
	by vger.kernel.org with ESMTP id S1751347AbVKMRra (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Nov 2005 12:47:30 -0500
Date: Sun, 13 Nov 2005 18:47:20 +0100 (CET)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Paul Mackerras <paulus@samba.org>
cc: Linux/PPC Development <linuxppc-dev@ozlabs.org>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ppc64: Thermal control for SMU based machines
In-Reply-To: <200511080502.jA852dWI011502@hera.kernel.org>
Message-ID: <Pine.LNX.4.62.0511131845230.17491@numbat.sonytel.be>
References: <200511080502.jA852dWI011502@hera.kernel.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 7 Nov 2005, Linux Kernel Mailing List wrote:
> tree d3f63b3ea80790c2f29ea435781c1331f17d269e
> parent 7d49697ef92bd2cf84ab53bd4cea82fefb197fb9
> author Benjamin Herrenschmidt <benh@kernel.crashing.org> Mon, 07 Nov 2005 16:08:17 +1100
> committer Paul Mackerras <paulus@samba.org> Tue, 08 Nov 2005 11:17:56 +1100
> 
> [PATCH] ppc64: Thermal control for SMU based machines
> 
> This adds a new thermal control framework for PowerMac, along with the
> implementation for PowerMac8,1, PowerMac8,2 (iMac G5 rev 1 and 2), and
> PowerMac9,1 (latest single CPU desktop). In the future, I expect to move
> the older G5 thermal control to the new framework as well.
> 
> Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Signed-off-by: Paul Mackerras <paulus@samba.org>

> --- a/drivers/macintosh/Kconfig
> +++ b/drivers/macintosh/Kconfig
> @@ -169,6 +169,25 @@ config THERM_PM72
>  	  This driver provides thermostat and fan control for the desktop
>  	  G5 machines. 
>  
> +config WINDFARM
> +	tristate "New PowerMac thermal control infrastructure"

Shouldn't this depend on some PowerMac-related variables, to prevent it from
showing up on m68k?

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
