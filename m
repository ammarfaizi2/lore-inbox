Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261850AbTJ2VPz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Oct 2003 16:15:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261959AbTJ2VPz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Oct 2003 16:15:55 -0500
Received: from mail.kroah.org ([65.200.24.183]:3547 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261850AbTJ2VP1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Oct 2003 16:15:27 -0500
Date: Wed, 29 Oct 2003 12:01:12 -0800
From: Greg KH <greg@kroah.com>
To: Soeren Sonnenburg <kernel@nn7.de>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: usb devices get redetected all the time in 2.6.0-test{7,9}
Message-ID: <20031029200112.GB4434@kroah.com>
References: <1067411725.1577.19.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1067411725.1577.19.camel@localhost>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 29, 2003 at 08:15:26AM +0100, Soeren Sonnenburg wrote:
> Hi.
> 
> When I attach a camera to a 2.4. based machine hotplug starts up some
> script to download images of that camera and fine thats it.
> 
> In 2.6.0-testX I see kernel messages like:
> 
> hub 2-0:1.0: new USB device on port 1, assigned address 2
> bus usb: add device 2-1
> bound device '2-1' to driver 'usb'
> bus usb: add device 2-1:1.0
> bus usb: remove device 2-1:1.0
> bus usb: add device 2-1:1.0
> bus usb: remove device 2-1:1.0
> bus usb: add device 2-1:1.0
> bus usb: remove device 2-1:1.0
> bus usb: add device 2-1:1.0
> [...]
> 
> and several of these hotplug scripts get started... Is this a wanted
> behaviour and something has to be fixed in userspace or is it a kernel
> bug ?

Does this settle down after a bit, or does the add/remove stuff keep
going on for a while?

Can you enable CONFIG_USB_DEBUG and see if you get any more information
in the kernel debug log as to why this is happening?

thanks,

greg k-h
