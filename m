Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030324AbWBAFyT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030324AbWBAFyT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Feb 2006 00:54:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030403AbWBAFyT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Feb 2006 00:54:19 -0500
Received: from dsl093-040-174.pdx1.dsl.speakeasy.net ([66.93.40.174]:43951
	"EHLO aria.kroah.org") by vger.kernel.org with ESMTP
	id S1030324AbWBAFyS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Feb 2006 00:54:18 -0500
Date: Tue, 31 Jan 2006 21:54:16 -0800
From: Greg KH <greg@kroah.com>
To: Richard Purdie <rpurdie@rpsys.net>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 6/11] LED: Add LED device support for the zaurus corgi and spitz models
Message-ID: <20060201055416.GA23520@kroah.com>
References: <1138714903.6869.132.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1138714903.6869.132.camel@localhost.localdomain>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 31, 2006 at 01:41:43PM +0000, Richard Purdie wrote:
> Adds LED drivers for LEDs found on the Sharp Zaurus c7x0 (corgi, 
> shepherd, husky) and cxx00 (akita, spitz, borzoi) models.
> 
> Signed-off-by: Richard Purdie <rpurdie@rpsys.net>
> 
> Index: linux-2.6.15/arch/arm/mach-pxa/corgi.c
> ===================================================================
> --- linux-2.6.15.orig/arch/arm/mach-pxa/corgi.c	2006-01-29 16:02:30.000000000 +0000
> +++ linux-2.6.15/arch/arm/mach-pxa/corgi.c	2006-01-29 16:11:47.000000000 +0000
> @@ -165,6 +165,15 @@
>  
>  
>  /*
> + * Corgi LEDs
> + */
> +static struct platform_device corgiled_device = {
> +	.name		= "corgi-led",
> +	.id		= -1,
> +};

Please use the platform device interface to create these dynamically and
don't make static structures.

thanks,

greg k-h
