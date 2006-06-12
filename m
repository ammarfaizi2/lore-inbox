Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751096AbWFLUvx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751096AbWFLUvx (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jun 2006 16:51:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751099AbWFLUvx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jun 2006 16:51:53 -0400
Received: from cantor.suse.de ([195.135.220.2]:63667 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1751096AbWFLUvw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jun 2006 16:51:52 -0400
Date: Mon, 12 Jun 2006 13:49:18 -0700
From: Greg KH <gregkh@suse.de>
To: Mark Lord <lkml@rtr.ca>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: pl2303 ttyUSB0: pl2303_open - failed submitting interrupt urb, error -28
Message-ID: <20060612204918.GA16898@suse.de>
References: <448DC93E.9050200@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <448DC93E.9050200@rtr.ca>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 12, 2006 at 04:06:22PM -0400, Mark Lord wrote:
> Greg,
> 
> With 2.6.17-rc6-git2, I'm seeing this kernel message during start-up:
> 
>  pl2303 ttyUSB0: pl2303_open - failed submitting interrupt urb, error -28
> 
> The pl2303 serial port is part of a USB1.1 Hub/dock device,
> plugged into a USB2 port on my notebook.

Known issue for years.  Either plug it directly into the USB 2.0 root
hub, or disable the ehci driver.

> I get the same failure again when trying to use the port with Kermit.
> This device was working fine here not long ago -- on the -rc5 kernels I 
> think.

It's a flaky thing.

Also, look in the -mm tree, there is a fix for this direct error, and
hopefully some ehci fixes that enable the whole thing to work properly.

thanks,

greg k-h
