Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263136AbUDLWEd (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Apr 2004 18:04:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263138AbUDLWEd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Apr 2004 18:04:33 -0400
Received: from mail.kroah.org ([65.200.24.183]:28815 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S263136AbUDLWE3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Apr 2004 18:04:29 -0400
Date: Mon, 12 Apr 2004 15:03:53 -0700
From: Greg KH <greg@kroah.com>
To: Martin Hermanowski <martin@mh57.de>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.5-mm4 (hci_usb module unloading oops)
Message-ID: <20040412220353.GC23692@kroah.com>
References: <20040410200551.31866667.akpm@osdl.org> <20040412101911.GA3823@mh57.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040412101911.GA3823@mh57.de>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 12, 2004 at 12:19:11PM +0200, Martin Hermanowski wrote:
> I get an oops when I try to unload the hci_usb module.

{sigh}  I'm hating that driver right now...

There are a number of pending bluetooth patches for that driver that fix
a number of different bugs, so I'm leary of trying to see if this is a
different one or not at this point in time.  Care to apply all of the
bluetooth patches and if this still happens, can you report it to the
linux-usb-devel and bluez-devel mailing lists?

> What other useful information can I provide?

CONFIG_DEBUG_DRIVER might be good to set, and then we can see if we are
not trying to remove the same device twice for some odd reason.  If you
do duplicate this, please include all of the debug log entries that
happen from when you unplug the device.

Also CONFIG_USB_DEBUG might help out.

> Apr 12 12:07:48 localhost udev[22216]: removing device node '/dev/hci0'

Nice, glad to see udev is working for you :)

thanks,

greg k-h
