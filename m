Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263357AbTD0E0X (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Apr 2003 00:26:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263359AbTD0E0X
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Apr 2003 00:26:23 -0400
Received: from granite.he.net ([216.218.226.66]:29452 "EHLO granite.he.net")
	by vger.kernel.org with ESMTP id S263357AbTD0E0W (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Apr 2003 00:26:22 -0400
Date: Sat, 26 Apr 2003 21:35:21 -0700
From: Greg KH <greg@kroah.com>
To: Ricardo Galli <gallir@uib.es>
Cc: linux-kernel@vger.kernel.org
Subject: Re: BUG: 2.5.68 uhci: host controlled halted and then kills the kernel
Message-ID: <20030427043521.GA4330@kroah.com>
References: <200304252314.13085.gallir@uib.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200304252314.13085.gallir@uib.es>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 25, 2003 at 11:14:13PM +0200, Ricardo Galli wrote:
> Sorry, again me :-(
> 
> Playing aroung with the mouse, I've got the following error:
> 
> usb 1-1: USB disconnect, address 2
> drivers/usb/host/uhci-hcd.c: 8800: host controller halted. very bad
>                                                            ^^^^^^^^

Do you get this error when running 2.4.21-rc1 when using the uhci.o
driver?

> hub 1-0:0: debounce: port 1: delay 100ms stable 4 status 0x301
> ...
> 
> 
> The USB didn't wok anymore, then I stopped hotplug and the system died 
> just after the message "Stopping hotplug subsystem" appeared in the 
> konsole.

That's because there's a nasty bug you hit when unloading the usb host
controller driver.

> It's the same Dell Latitude X200.
> 
> BTW, the usb mouse doesn't work with ohci, altough the modules are loaded.

That's because you probably do not have the ohci hardware :)

thanks,

greg k-h
