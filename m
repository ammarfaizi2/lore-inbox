Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263335AbVCMF3U@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263335AbVCMF3U (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Mar 2005 00:29:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263354AbVCMF3U
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Mar 2005 00:29:20 -0500
Received: from mail.kroah.org ([69.55.234.183]:11206 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S263335AbVCMF1p (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Mar 2005 00:27:45 -0500
Date: Sat, 12 Mar 2005 21:20:11 -0800
From: Greg KH <greg@kroah.com>
To: Corey Minyard <minyard@acm.org>
Cc: Andrew Morton <akpm@osdl.org>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Add sysfs support to the IPMI driver
Message-ID: <20050313052011.GA18089@kroah.com>
References: <4233C834.40903@acm.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4233C834.40903@acm.org>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 12, 2005 at 10:57:24PM -0600, Corey Minyard wrote:
> The IPMI driver has long needed to tie into the device model (and I've 
> long been hoping someone else would do it).  I finally gave up and spent 
> the time to learn how to do it.  I think this is right, it seems to work 
> on on my system.

Looks good.  One minor question:

> +
> +	snprintf(name, sizeof(name), "ipmi%d", if_num);
> +	class_simple_device_add(ipmi_class, dev, NULL, name);

What do ipmi class devices live on?  pci devices?  i2c devices?
platform devices?  Or are they purely virtual things?

thanks,

greg k-h
