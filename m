Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262104AbVAYTns@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262104AbVAYTns (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Jan 2005 14:43:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262095AbVAYTla
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Jan 2005 14:41:30 -0500
Received: from gprs213-152.eurotel.cz ([160.218.213.152]:21632 "EHLO
	amd.ucw.cz") by vger.kernel.org with ESMTP id S262090AbVAYTf7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Jan 2005 14:35:59 -0500
Date: Tue, 25 Jan 2005 20:35:40 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Christoph Hellwig <hch@infradead.org>, Andrew Morton <akpm@osdl.org>,
       johnpol@2ka.mipt.ru, greg@kroah.com, linux-kernel@vger.kernel.org
Subject: Re: 2.6.11-rc2-mm1
Message-ID: <20050125193539.GA1563@elf.ucw.cz>
References: <20050124021516.5d1ee686.akpm@osdl.org> <20050125125323.GA19055@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050125125323.GA19055@infradead.org>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> Review of the superio subsystem sneaked in through bk-i2c.patch:
> 
> 
> diff -Nru a/drivers/superio/Kconfig b/drivers/superio/Kconfig
> --- /dev/null	Wed Dec 31 16:00:00 196900
> +++ b/drivers/superio/Kconfig	2005-01-23 22:34:15 -08:00
> @@ -0,0 +1,56 @@
> +menu "SuperIO subsystem support"
> +
> +config SC_SUPERIO
> +	tristate "SuperIO subsystem support"
> +	depends on CONNECTOR
> +	help
> +	  SuperIO subsystem support.
> +	
> +	  This support is also available as a module.  If so, the module
> +          will be called superio.ko.
> 
> This doesn't mention what "SuperIO" is at all.  Also please skip the .ko
> postfix for the module name as the intree Kconfigs do.  The boilerplate has
> changed to:
> 
>   To compile this driver as a module, choose M here: the
>   module will be called <foo>.

Could we kill this boilerplate? Just explain modules in CONFIG_MODULE
or something like that. Or making module name mandatory parameter for
tristates, or something like that...

								Pavel
-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
