Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263394AbTEPXTm (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 May 2003 19:19:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264616AbTEPXTm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 May 2003 19:19:42 -0400
Received: from e6.ny.us.ibm.com ([32.97.182.106]:65238 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S263394AbTEPXTk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 May 2003 19:19:40 -0400
Date: Fri, 16 May 2003 16:33:24 -0700
From: Greg KH <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.6 must-fix, v4
Message-ID: <20030516233323.GA17240@kroah.com>
References: <20030516161717.1e629364.akpm@digeo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030516161717.1e629364.akpm@digeo.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 16, 2003 at 04:17:17PM -0700, Andrew Morton wrote:
> +drivers/tty
> +-----------
> +
> +- viro: we need to fix refcounting for tty_driver (oopsable race, must fix
> +  anyway, hopefully about a week until it's merged) then we can do
> +  tty/misc/upper levels of sound and hopefully upper level of USB.
> +
> +  USB is a place where we _really_ need to deal with dynamic allocation of
> +  device numbers and that will bite.

Why?  USB serial drivers have been handling dynamic minors since 2.2
days.  Also works for the USB bluetooth driver, and the USB acm driver
which register with tty_register_device() when a new tty minor is to be
used.

Al, any changes that you want to make to the tty layer, I will gladly
fix up the USB drivers so they work again.  Don't let USB drivers worry
you, they can always be changed, as long as the same functionality is
there :)

thanks,

greg k-h
