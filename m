Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261167AbVFCHK1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261167AbVFCHK1 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Jun 2005 03:10:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261164AbVFCHK1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Jun 2005 03:10:27 -0400
Received: from mail.kroah.org ([69.55.234.183]:7081 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261167AbVFCHKN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Jun 2005 03:10:13 -0400
Date: Fri, 3 Jun 2005 00:20:27 -0700
From: Greg KH <greg@kroah.com>
To: Matt Porter <mporter@kernel.crashing.org>
Cc: torvalds@osdl.org, akpm@osdl.org, linux-kernel@vger.kernel.org,
       linuxppc-embedded@ozlabs.org
Subject: Re: [PATCH][1/5] RapidIO support: core
Message-ID: <20050603072027.GD30292@kroah.com>
References: <20050602140359.B24818@cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050602140359.B24818@cox.net>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 02, 2005 at 02:03:59PM -0700, Matt Porter wrote:
> +static struct device rio_bus = {
> +	.bus_id = "rapidio",
> +};

Why do you need this device?  You shouldn't have a static struct device
to start with.  Or you just don't like having your root rio device
showing up in /sys/devices/ ?
If so, just create a kobject and put it there, and then base your
devices off of it, no need for a real device.

Oh wait, that's what the platform and system code does.  bah,
nevermind...

thanks,

greg k-h
