Return-Path: <linux-kernel-owner+w=401wt.eu-S964988AbWL1Ii5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964988AbWL1Ii5 (ORCPT <rfc822;w@1wt.eu>);
	Thu, 28 Dec 2006 03:38:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965002AbWL1Iik
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Dec 2006 03:38:40 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:3798 "EHLO spitz.ucw.cz"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S964988AbWL1Iif (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Dec 2006 03:38:35 -0500
Date: Wed, 27 Dec 2006 17:53:44 +0000
From: Pavel Machek <pavel@ucw.cz>
To: David Brownell <david-b@pacbell.net>
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Andrew Victor <andrew@sanpeople.com>,
       Bill Gatliff <bgat@billgatliff.com>,
       Haavard Skinnemoen <hskinnemoen@atmel.com>, jamey.hicks@hp.com,
       Kevin Hilman <khilman@mvista.com>, Nicolas Pitre <nico@cam.org>,
       Russell King <rmk@arm.linux.org.uk>, Tony Lindgren <tony@atomide.com>,
       pHilipp Zabel <philipp.zabel@gmail.com>
Subject: Re: [patch 2.6.20-rc1 4/6] PXA GPIO wrappers
Message-ID: <20061227175344.GC4088@ucw.cz>
References: <200611111541.34699.david-b@pacbell.net> <200612201304.03912.david-b@pacbell.net> <200612201312.36616.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200612201312.36616.david-b@pacbell.net>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> Arch-neutral GPIO calls for PXA.
> 
> From: Philipp Zabel <philipp.zabel@gmail.com>

Missing s-o-b?


> +static inline int gpio_direction_input(unsigned gpio)
> +{
> +	if (gpio > PXA_LAST_GPIO)
> +		return -EINVAL;
> +	pxa_gpio_mode(gpio | GPIO_IN);
> +}

Missing return 0?

> +static inline int gpio_direction_output(unsigned gpio)
> +{
> +	if (gpio > PXA_LAST_GPIO)
> +		return -EINVAL;
> +	pxa_gpio_mode(gpio | GPIO_OUT);
> +}
> +

And here?

						Pavel
-- 
Thanks for all the (sleeping) penguins.
