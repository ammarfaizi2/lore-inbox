Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750987AbWHGDMP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750987AbWHGDMP (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Aug 2006 23:12:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750992AbWHGDMP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Aug 2006 23:12:15 -0400
Received: from mail.kroah.org ([69.55.234.183]:31416 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1750987AbWHGDMO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Aug 2006 23:12:14 -0400
Date: Sun, 6 Aug 2006 20:09:58 -0700
From: Greg KH <greg@kroah.com>
To: Matthew Wilcox <matthew@wil.cx>
Cc: linux-kernel@vger.kernel.org
Subject: Re: dev_printk() is now GPL-only
Message-ID: <20060807030958.GA638@kroah.com>
References: <20060807025723.GK4379@parisc-linux.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060807025723.GK4379@parisc-linux.org>
User-Agent: Mutt/1.5.12-2006-07-14
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 06, 2006 at 08:57:23PM -0600, Matthew Wilcox wrote:
> 
> Does dev_driver_string() really need to be GPL-only?  Up to this point,
> proprietary modules have been entitled to call dev_printk(), but now:
> 
> #define dev_printk(level, dev, format, arg...)  \
>         printk(level "%s %s: " format , dev_driver_string(dev) , (dev)->bus_id , ## arg)
> 
> with
> 
> EXPORT_SYMBOL_GPL(dev_driver_string);
> 
> means that they're not allowed to.

Oops, good point, I never noticed, as I don't have an closed source
drivers here to test with :)

Care to send me a patch to fix it up?

thanks,

greg k-h
