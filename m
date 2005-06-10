Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261530AbVFJIuw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261530AbVFJIuw (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Jun 2005 04:50:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262514AbVFJIuw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Jun 2005 04:50:52 -0400
Received: from mail.kroah.org ([69.55.234.183]:27788 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261530AbVFJIup (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Jun 2005 04:50:45 -0400
Date: Fri, 10 Jun 2005 01:50:34 -0700
From: Greg KH <greg@kroah.com>
To: "J.A. Magallon" <jamagallon@able.es>
Cc: Lista Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Problems with usb and digital camera
Message-ID: <20050610085033.GA16936@kroah.com>
References: <1118359189l.15128l.0l@werewolf.able.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1118359189l.15128l.0l@werewolf.able.es>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 09, 2005 at 11:19:49PM +0000, J.A. Magallon wrote:
> Hi...
> 
> I have a Canon Powershot A70 and it used to work nicely with linux and
> gnome. But now it has stopped working.
> 
> When I plug the camera, gthumb pops and try to import photos. But I get a
> window with this message:
> 
> An error occurred in the io-library ('Error updating the port settings'): Could not set config 0/1 (Device or resource busy)
> 
> syslog shows this:
> 
> Jun  6 23:43:04 werewolf kernel: usb 5-2: new full speed USB device using uhci_hcd and address 6
> Jun  6 23:45:38 werewolf kernel: usb 5-2: usbfs: interface 0 claimed by usbfs while 'gthumb' sets config #1

That looks fine.

> I have now 2.6.12-rc6-mm1. My USB pendrive works nicely.
> 
> Are you aware of any strange behaviour of USB in this kernel ?

Nope :)

> What means the syslog message ? The kernel grabs the device to show in usbfs
> and nobody can open it ?

No, gthumb uses libusb to grab it (thats the usbfs bind message.)

How about enabling CONFIG_USB_DEBUG in your kernel and posting the
results of your syslog to the linux-usb-devel mailing list when you try
this?

thanks,

greg k-h
