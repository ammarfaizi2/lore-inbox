Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262811AbULRB2M@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262811AbULRB2M (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Dec 2004 20:28:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262812AbULRB2M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Dec 2004 20:28:12 -0500
Received: from e31.co.us.ibm.com ([32.97.110.129]:5352 "EHLO e31.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S262811AbULRB2G (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Dec 2004 20:28:06 -0500
Date: Fri, 17 Dec 2004 17:27:25 -0800
From: Greg KH <greg@kroah.com>
To: Mikkel Krautz <krautz@gmail.com>
Cc: linux-kernel@vger.kernel.org, vojtech@suse.cz
Subject: Re: [PATCH] hid-core: Configurable USB HID Mouse Interrupt Polling Interval
Message-ID: <20041218012725.GB25628@kroah.com>
References: <1103335970.15567.15.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1103335970.15567.15.camel@localhost>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 18, 2004 at 02:12:50AM +0000, Mikkel Krautz wrote:
> Hi!
> 
> This patch adds the option "USB HID Mouse Interrupt Polling Interval"
> to drivers/usb/input/Kconfig, and a few lines of code to
> drivers/usb/input/hid-core.c, to make the config option function.
> 
> It allows people to change the interval, at which their USB HID mice
> are polled at. This is extremely useful for people who require high
> precision, or just likes the feeling of a very precise mouse. ;)
> 
> As the Kconfig help implies, setting a lower polling interval is known
> to work on several mice produced by Logitech and Microsoft. I only
> have a Logitech MX500 to test it on. My results have been positive,
> and so have many other people's.

Why not just make it a sysfs file, so you can tune it per device?  That
way you also don't have to make it a Kconfig option.

thanks,

greg k-h
