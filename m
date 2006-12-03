Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1759659AbWLCNGj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759659AbWLCNGj (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Dec 2006 08:06:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759662AbWLCNGj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Dec 2006 08:06:39 -0500
Received: from coyote.holtmann.net ([217.160.111.169]:31427 "EHLO
	mail.holtmann.net") by vger.kernel.org with ESMTP id S1759658AbWLCNGi
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Dec 2006 08:06:38 -0500
Subject: Re: [linux-usb-devel] [GIT PATCH] USB patches for 2.6.19
From: Marcel Holtmann <marcel@holtmann.org>
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Pavel Machek <pavel@suse.cz>, Andrew Morton <akpm@osdl.org>,
       Linus Torvalds <torvalds@osdl.org>, Greg KH <gregkh@suse.de>,
       linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net
In-Reply-To: <Pine.LNX.4.44L0.0612021555530.20254-100000@netrider.rowland.org>
References: <Pine.LNX.4.44L0.0612021555530.20254-100000@netrider.rowland.org>
Content-Type: text/plain
Date: Sun, 03 Dec 2006 14:06:00 +0100
Message-Id: <1165151160.19590.2.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alan,

> > > Here are a bunch of USB patches for 2.6.19.
> > > 
> > > They contain:
> > > 	- new driver for usb debug device (client side only so far)
> > > 	- helper functions to find usb endpoints easier
> > > 	- minor bugfixes
> > > 	- new device support
> > > 	- usb core rework for autosuspend logic
> > > 	- autosuspend logic that should now save a lot of power when no
> > > 	  one is using a USB device.
> > 
> > So we can now go to C3, extending battery life by about 2 hours on
> > x60? Good.
> 
> Try it and see.  You have to turn on CONFIG_USB_SUSPEND.
> 
> You also have to have autosuspend support in all the USB drivers for the
> attached devices.  Right now autosuspend is present only in the host
> controller drivers and the hub driver -- it is not available in USBHID
> (under development).  But if you have a USB device with no driver bound,
> or you unload its driver, then the device will automatically be suspended.

about the USBHID part. Jiri Kosina is just about to finally split the
HID parser and make it available for Bluetooth and USB as an independent
subsystem. This might conflict with any autosuspend changes for the
USBHID. It might be better that this waits until Jiri's patches are
merged.

Regards

Marcel


