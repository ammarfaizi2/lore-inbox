Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262818AbULRDAV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262818AbULRDAV (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Dec 2004 22:00:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262825AbULRDAV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Dec 2004 22:00:21 -0500
Received: from mail.kroah.org ([69.55.234.183]:3518 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262818AbULRDAN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Dec 2004 22:00:13 -0500
Date: Fri, 17 Dec 2004 18:59:48 -0800
From: Greg KH <greg@kroah.com>
To: Mikkel Krautz <krautz@gmail.com>
Cc: linux-kernel@vger.kernel.org, vojtech@suse.cz
Subject: Re: [PATCH] hid-core: Configurable USB HID Mouse Interrupt Polling Interval
Message-ID: <20041218025948.GB27152@kroah.com>
References: <1103335970.15567.15.camel@localhost> <20041218012725.GB25628@kroah.com> <41C3B546.2040105@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41C3B546.2040105@gmail.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 18, 2004 at 04:42:46AM +0000, Mikkel Krautz wrote:
> Greg KH wrote:
> >On Sat, Dec 18, 2004 at 02:12:50AM +0000, Mikkel Krautz wrote:
> >>
> >>This patch adds the option "USB HID Mouse Interrupt Polling Interval"
> >>to drivers/usb/input/Kconfig, and a few lines of code to
> >>drivers/usb/input/hid-core.c, to make the config option function.
> >>
> >>It allows people to change the interval, at which their USB HID mice
> >>are polled at. This is extremely useful for people who require high
> >>precision, or just likes the feeling of a very precise mouse. ;)
> >>
> >>As the Kconfig help implies, setting a lower polling interval is known
> >>to work on several mice produced by Logitech and Microsoft. I only
> >>have a Logitech MX500 to test it on. My results have been positive,
> >>and so have many other people's.
> >
> >Why not just make it a sysfs file, so you can tune it per device?  That
> >way you also don't have to make it a Kconfig option.
> >
> I'm not too familiar with sysfs, so I really don't know.

Poke around in it, I think it's the natural place for stuff like this.

> The interval is set when the device is configured - that's only once.

So it can never change?  Why not add that feature at the same time?

> Therefore I think a static value in Kconfig is fine. Wouldn't a sysfs 
> entry be a little overkill for this?

What about makeing it a module paramater then, that is exported to
sysfs?  That makes it easier to adjust on the fly (before the mouse is
inserted), and doesn't require the kernel to be rebuilt.

Just trying to make things easier for users :)

thanks,

greg k-h
