Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261762AbVCAIQ5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261762AbVCAIQ5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Mar 2005 03:16:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261743AbVCAIQ0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Mar 2005 03:16:26 -0500
Received: from mail.kroah.org ([69.55.234.183]:29630 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261448AbVCAIOS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Mar 2005 03:14:18 -0500
Date: Mon, 28 Feb 2005 23:54:13 -0800
From: Greg KH <greg@kroah.com>
To: James Chapman <jchapman@katalix.com>
Cc: sensors@Stimpy.netroedge.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH: 2.6.11-rc5] i2c chips: ds1337 RTC driver
Message-ID: <20050301075413.GC3791@kroah.com>
References: <42235171.80500@katalix.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42235171.80500@katalix.com>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 28, 2005 at 05:14:25PM +0000, James Chapman wrote:
> +/* Define to compile in pr_debug() trace */
> +#undef DEBUG

Not needed, we do this in the makefile now.

> +	if (debug >= 1)
> +		pr_debug("%s: client=%p, dt=%p\n", __FUNCTION__, client, dt);

Please use the dev_dbg(), dev_err() and friend functions instead of
pr_debug().  It provides a sane user interface that all of the other
drivers use.

thanks,

greg k-h
