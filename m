Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1162467AbWLBVAT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1162467AbWLBVAT (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Dec 2006 16:00:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1162469AbWLBVAT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Dec 2006 16:00:19 -0500
Received: from firewall.rowland.harvard.edu ([140.247.233.35]:18683 "HELO
	netrider.rowland.org") by vger.kernel.org with SMTP
	id S1162467AbWLBVAS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Dec 2006 16:00:18 -0500
Date: Sat, 2 Dec 2006 16:00:16 -0500 (EST)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@netrider.rowland.org
To: Pavel Machek <pavel@suse.cz>
cc: Greg KH <gregkh@suse.de>, Andrew Morton <akpm@osdl.org>,
       Linus Torvalds <torvalds@osdl.org>, <linux-kernel@vger.kernel.org>,
       <linux-usb-devel@lists.sourceforge.net>
Subject: Re: [linux-usb-devel] [GIT PATCH] USB patches for 2.6.19
In-Reply-To: <20061202162818.GE4773@ucw.cz>
Message-ID: <Pine.LNX.4.44L0.0612021555530.20254-100000@netrider.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2 Dec 2006, Pavel Machek wrote:

> Hi!
> 
> > Here are a bunch of USB patches for 2.6.19.
> > 
> > They contain:
> > 	- new driver for usb debug device (client side only so far)
> > 	- helper functions to find usb endpoints easier
> > 	- minor bugfixes
> > 	- new device support
> > 	- usb core rework for autosuspend logic
> > 	- autosuspend logic that should now save a lot of power when no
> > 	  one is using a USB device.
> 
> So we can now go to C3, extending battery life by about 2 hours on
> x60? Good.

Try it and see.  You have to turn on CONFIG_USB_SUSPEND.

You also have to have autosuspend support in all the USB drivers for the
attached devices.  Right now autosuspend is present only in the host
controller drivers and the hub driver -- it is not available in USBHID
(under development).  But if you have a USB device with no driver bound,
or you unload its driver, then the device will automatically be suspended.

Alan Stern

