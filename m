Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262740AbTLQA4L (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Dec 2003 19:56:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262760AbTLQA4L
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Dec 2003 19:56:11 -0500
Received: from mail.kroah.org ([65.200.24.183]:44684 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262740AbTLQA4D (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Dec 2003 19:56:03 -0500
Date: Tue, 16 Dec 2003 16:55:52 -0800
From: Greg KH <greg@kroah.com>
To: Carlos =?iso-8859-1?Q?Jim=E9nez?= <lordeath@linuxspain.net>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: UHCI-HCD && mosedev on 2.6.0-test11
Message-ID: <20031217005552.GA8753@kroah.com>
References: <1071536070.12406.5.camel@localhost> <20031216174639.GD2716@kroah.com> <1071621227.11193.69.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1071621227.11193.69.camel@localhost>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 17, 2003 at 01:33:48AM +0100, Carlos Jiménez wrote:
> ok thanx I'll try it, and i'll notify you
> 
> Excuse my english (I am from spain, and I not practice english too much
> :)
> 
> On 2.6.0-alltest (not yet probed with bk) all usb devices works good
> (usb-storage with an aiptek cam, and usbfloppy).
> 
> When I plug in that mouse, usbview shows it as an unrecognized device.

What does /proc/bus/usb/devices show with the mouse plugged in?  Do you
have the usb hid driver loaded?

> The device does not work at all, cat /dev/input/mice , cat
> /dev/input/mouse0 and cat /dev/usbmouse shows anything when I move the
> usbmouse, (on 2.4.2x kernel device works good, and I was wathcing ascii
> characters, when I  was moving it).
> 
> Then, when I removed the device, or when i try to unload uhci-hcd (while
> device is plugged) kernel show that info, and all about usb goes down. I
> cant unload, load, anything about modules, and I have to use sync before
> poweroff to power off the system whithout breakin filesystems.

Yeah, there are still some races there.  Hopefully the latest -bk tree
(or test11) will fix a lot of these.

thanks,

greg k-h
