Return-Path: <linux-kernel-owner+w=401wt.eu-S965003AbWL1Ijl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965003AbWL1Ijl (ORCPT <rfc822;w@1wt.eu>);
	Thu, 28 Dec 2006 03:39:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965005AbWL1IjB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Dec 2006 03:39:01 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:3819 "EHLO spitz.ucw.cz"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S965003AbWL1Iin (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Dec 2006 03:38:43 -0500
Date: Wed, 27 Dec 2006 18:24:39 +0000
From: Pavel Machek <pavel@ucw.cz>
To: David Brownell <david-b@pacbell.net>
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Andrew Victor <andrew@sanpeople.com>,
       Bill Gatliff <bgat@billgatliff.com>,
       Haavard Skinnemoen <hskinnemoen@atmel.com>, jamey.hicks@hp.com,
       Kevin Hilman <khilman@mvista.com>, Nicolas Pitre <nico@cam.org>,
       Russell King <rmk@arm.linux.org.uk>, Tony Lindgren <tony@atomide.com>,
       pHilipp Zabel <philipp.zabel@gmail.com>
Subject: Re: [patch 2.6.20-rc1 5/6] SA1100 GPIO wrappers
Message-ID: <20061227182439.GD4088@ucw.cz>
References: <200611111541.34699.david-b@pacbell.net> <200612201304.03912.david-b@pacbell.net> <200612201313.22572.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200612201313.22572.david-b@pacbell.net>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> +static inline int gpio_direction_input(unsigned gpio)
> +{
> +	if (gpio > GPIO_MAX)
> +		return -EINVAL;
> +	GPDR = (GPDR_In << gpio) 0
> +}

Missing return 0.

> +static inline int gpio_direction_output(unsigned gpio)
> +{
> +	if (gpio > GPIO_MAX)
> +		return -EINVAL;
> +	GPDR = (GPDR_Out << gpio) 0
> +}

Here too.

-- 
Thanks for all the (sleeping) penguins.
