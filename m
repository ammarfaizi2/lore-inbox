Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264560AbUGRWSR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264560AbUGRWSR (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Jul 2004 18:18:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264561AbUGRWSQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Jul 2004 18:18:16 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:27822 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S264560AbUGRWSE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Jul 2004 18:18:04 -0400
Date: Mon, 19 Jul 2004 00:18:02 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Patrick Mochel <mochel@digitalimplant.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [14/25] Merge pmdisk and swsusp
Message-ID: <20040718221802.GE31958@atrey.karlin.mff.cuni.cz>
References: <Pine.LNX.4.50.0407171530410.22290-100000@monsoon.he.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.50.0407171530410.22290-100000@monsoon.he.net>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!


> +#ifdef DEBUG
> +static void dump_info(void)
> +{
> +	printk(" swsusp: Version: %u\n",swsusp_info.version_code);
> +	printk(" swsusp: Num Pages: %ld\n",swsusp_info.num_physpages);
> +	printk(" swsusp: UTS Sys: %s\n",swsusp_info.uts.sysname);
> +	printk(" swsusp: UTS Node: %s\n",swsusp_info.uts.nodename);
> +	printk(" swsusp: UTS Release: %s\n",swsusp_info.uts.release);
> +	printk(" swsusp: UTS Version: %s\n",swsusp_info.uts.version);
> +	printk(" swsusp: UTS Machine: %s\n",swsusp_info.uts.machine);
> +	printk(" swsusp: UTS Domain: %s\n",swsusp_info.uts.domainname);
> +	printk(" swsusp: CPUs: %d\n",swsusp_info.cpus);
> +	printk(" swsusp: Image: %ld Pages\n",swsusp_info.image_pages);
> +	printk(" swsusp: Pagedir: %ld Pages\n",swsusp_info.pagedir_pages);
> +}
> +#else
> +static void dump_info(void)
> +{
> +
> +}
> +#endif

Moving #ifdef inside function will result with a little less code...

-- 
Horseback riding is like software...
...vgf orggre jura vgf serr.
