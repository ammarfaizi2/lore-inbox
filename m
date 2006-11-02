Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752364AbWKBVWp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752364AbWKBVWp (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Nov 2006 16:22:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752455AbWKBVWp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Nov 2006 16:22:45 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:1546 "EHLO spitz.ucw.cz")
	by vger.kernel.org with ESMTP id S1752440AbWKBVWo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Nov 2006 16:22:44 -0500
Date: Thu, 2 Nov 2006 20:51:17 +0000
From: Pavel Machek <pavel@ucw.cz>
To: Yu Luming <luming.yu@gmail.com>
Cc: Andrew Morton <akpm@osdl.org>, len.brown@intel.com,
       Matt Domsch <Matt_Domsch@dell.com>,
       Alessandro Guido <alessandro.guido@gmail.com>,
       linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
       jengelh@linux01.gwdg.de, gelma@gelma.net, ismail@pardus.org.tr,
       Richard Hughes <hughsient@gmail.com>
Subject: Re: [patch 2/6] Add display output class support
Message-ID: <20061102205117.GA4887@ucw.cz>
References: <200611042113.56913.luming.yu@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <200611042113.56913.luming.yu@gmail.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> Add display output class support
> 
> signed-off-by   Luming.yu@gmail.com

Hmm, strange characters inside signoff, and I guessthis should be Real
Name <my@ddress>.


> @@ -0,0 +1,129 @@
> +/*
> + *  output.c - Display output swither driver

Switcher?

> +static ssize_t video_output_store_state(struct class_device *dev,
> +	const char *buf,size_t count)
> +{
> +	char *endp;
> +	struct output_device *od = to_output_device(dev);
> +	int request_state = simple_strtoul(buf,&endp,0);
> +	size_t size = endp - buf;
> +
> +        if (*endp && isspace(*endp))
> +                size++;
> +        if (size != count)
> +                return -EINVAL;

spaces vs. tabs...

> --- /dev/null
> +++ b/include/linux/output.h

I'm not sure if linux/output.h is not little too generic...

							Pavel
-- 
Thanks for all the (sleeping) penguins.
