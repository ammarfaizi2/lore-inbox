Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261500AbUGRWJ4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261500AbUGRWJ4 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Jul 2004 18:09:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264538AbUGRWJ4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Jul 2004 18:09:56 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:36525 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S261500AbUGRWJz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Jul 2004 18:09:55 -0400
Date: Mon, 19 Jul 2004 00:09:54 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Patrick Mochel <mochel@digitalimplant.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [6/25] Merge pmdisk and swsusp
Message-ID: <20040718220954.GB31958@atrey.karlin.mff.cuni.cz>
References: <Pine.LNX.4.50.0407171528280.22290-100000@monsoon.he.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.50.0407171528280.22290-100000@monsoon.he.net>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> +static void calc_order(void)
> +{
> +	int diff;
> +	int order;
> +
> +	order = get_bitmask_order(SUSPEND_PD_PAGES(nr_copy_pages));
> +	nr_copy_pages += 1 << order;
> +	do {
> +		diff = get_bitmask_order(SUSPEND_PD_PAGES(nr_copy_pages)) - order;
> +		if (diff) {
> +			order += diff;
> +			nr_copy_pages += 1 << diff;
> +		}
> +	} while(diff);
> +	pagedir_order = order;
> +}

This code is "interesting". Perhaps at least comment would be good
here?
									Pavel
-- 
Horseback riding is like software...
...vgf orggre jura vgf serr.
