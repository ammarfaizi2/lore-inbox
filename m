Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263197AbTDGCfs (for <rfc822;willy@w.ods.org>); Sun, 6 Apr 2003 22:35:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263198AbTDGCfs (for <rfc822;linux-kernel-outgoing>); Sun, 6 Apr 2003 22:35:48 -0400
Received: from granite.he.net ([216.218.226.66]:46606 "EHLO granite.he.net")
	by vger.kernel.org with ESMTP id S263197AbTDGCfr (for <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Apr 2003 22:35:47 -0400
Date: Sun, 6 Apr 2003 13:16:38 -0700
From: Greg KH <greg@kroah.com>
To: Jens Ansorg <jens@ja-web.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: USB devices in 2.5.xx do not show in /dev
Message-ID: <20030406201638.GC18279@kroah.com>
References: <1049632582.3405.0.camel@lisaserver>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1049632582.3405.0.camel@lisaserver>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 06, 2003 at 02:36:23PM +0200, Jens Ansorg wrote:
> I'm trying an 2.5.66-mm kernel on 1386
> 
> I have 3 USB devices connected.
> The mouse works - mostly (no wheel support)
> But scanner and printer do not work.
> 
> The modules scanner and usblp seem to load fine
> 
> Apr  6 14:14:37 lisaserver kernel: drivers/usb/core/usb.c: registered
> new driver usbscanner
> Apr  6 14:14:37 lisaserver kernel: drivers/usb/image/scanner.c:
> 0.4.11:USB Scanner Driver
> Apr  6 14:15:50 lisaserver kernel: drivers/usb/core/usb.c: registered
> new driver usblp
> Apr  6 14:15:50 lisaserver kernel: drivers/usb/class/usblp.c: v0.13: USB
> Printer Device Class driver
> 
> 
> but I do not get the devices under /dev to actually use them

You have to have an actual device for the /dev node to show up.  Do you
have any USB devices plugged in?  What does:
	tree /sys/bus/usb/
show?

thanks,

greg k-h
