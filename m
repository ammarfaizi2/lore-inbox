Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750923AbWGGIrB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750923AbWGGIrB (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Jul 2006 04:47:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750934AbWGGIrA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Jul 2006 04:47:00 -0400
Received: from tim.rpsys.net ([194.106.48.114]:25542 "EHLO tim.rpsys.net")
	by vger.kernel.org with ESMTP id S1750889AbWGGIrA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Jul 2006 04:47:00 -0400
Subject: Re: [PATCH] Integrate asus_acpi LED's with new LED subsystem
From: Richard Purdie <rpurdie@rpsys.net>
To: Thomas Tuttle <thinkinginbinary@gmail.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
In-Reply-To: <20060707012025.GB8900@phoenix>
References: <20060706193157.GC14043@phoenix>
	 <20060706154930.1a8fbad5.akpm@osdl.org>  <20060707012025.GB8900@phoenix>
Content-Type: text/plain
Date: Fri, 07 Jul 2006 09:46:48 +0100
Message-Id: <1152262009.5548.41.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-07-06 at 21:20 -0400, Thomas Tuttle wrote:

> +/* These functions are called by the LED subsystem to update the desired
> + * state of the LED's. */
> +static void led_set_mled(struct led_classdev *led_cdev,
> +                               enum led_brightness value);
> +static void led_set_wled(struct led_classdev *led_cdev,
> +                               enum led_brightness value);
> +static void led_set_tled(struct led_classdev *led_cdev,
> +                               enum led_brightness value);

I don't think you need these anymore.

> +#else
> +
> +static inline int led_initialize(struct device *parent)
> +{
> +}
> +

This turns the code into a game of Russian roulette when
CONFIG_ACPI_ASUS_NEW_LED isn't set (think return values). I'm sure
Andrew was just testing with that ;-)

If you fix these issues, you can add an
Acked-by: Richard Purdie <rpurdie@rpsys.net>

Richard

