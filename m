Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261196AbULRQ4y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261196AbULRQ4y (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Dec 2004 11:56:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261198AbULRQ4x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Dec 2004 11:56:53 -0500
Received: from mail.kroah.org ([69.55.234.183]:57018 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261196AbULRQyW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Dec 2004 11:54:22 -0500
Date: Sat, 18 Dec 2004 08:53:31 -0800
From: Greg KH <greg@kroah.com>
To: Mikkel Krautz <krautz@gmail.com>
Cc: linux-kernel@vger.kernel.org, vojtech@suse.cz
Subject: Re: [PATCH] hid-core: Configurable USB HID Mouse Interrupt Polling Interval
Message-ID: <20041218165331.GA7737@kroah.com>
References: <1103335970.15567.15.camel@localhost> <20041218012725.GB25628@kroah.com> <41C46B4D.5040506@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41C46B4D.5040506@gmail.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 18, 2004 at 05:39:25PM +0000, Mikkel Krautz wrote:
> On Fri, 17 Dec 2004 18:59:48 -0800, Greg KH <greg@kroah.com> wrote:
> > What about makeing it a module paramater then, that is exported to
> > sysfs?  That makes it easier to adjust on the fly (before the mouse is
> > inserted), and doesn't require the kernel to be rebuilt.
> 
> I really like the idea. I'm start to think that this is the ideal way to 
> accomplish this.
> 
> Here's a new patch. Let's hope it doesn't wrap!

It was eaten :(

> module_init(hid_init);
> module_exit(hid_exit);
> +module_param(hid_mouse_polling_interval, int, 644);

0644, or use the proper #defines instead.

thanks,

greg k-h
