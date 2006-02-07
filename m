Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750731AbWBGQjJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750731AbWBGQjJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Feb 2006 11:39:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750792AbWBGQjJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Feb 2006 11:39:09 -0500
Received: from dsl093-040-174.pdx1.dsl.speakeasy.net ([66.93.40.174]:43189
	"EHLO aria.kroah.org") by vger.kernel.org with ESMTP
	id S1750731AbWBGQjI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Feb 2006 11:39:08 -0500
Date: Tue, 7 Feb 2006 08:39:21 -0800
From: Greg KH <greg@kroah.com>
To: "Fr?d?ric L. W. Meunier" <2@pervalidus.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: What causes "USB disconnect" ?
Message-ID: <20060207163921.GA10739@kroah.com>
References: <Pine.LNX.4.64.0602062122480.5326@dyndns.pervalidus.net> <20060207002749.GA6774@kroah.com> <964857280602061706n72a9ebbeo9a1930f2b0993e0b@mail.gmail.com> <964857280602061812m748d19bew5ef0777e24359029@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <964857280602061812m748d19bew5ef0777e24359029@mail.gmail.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 07, 2006 at 12:12:58AM -0200, Fr?d?ric L. W. Meunier wrote:
> On 2/6/06, Fr?d?ric L. W. Meunier wrote:
> > When it happened, his lights turned off. I pressed a button, but
> > nothing happened. Then, I ignored it and it returned after the minutes
> > you see from the log.
> 
> It happened again. This, after an uptime of 3 days and a few hours.
> 
> Feb  6 23:59:00 pervalidus kernel: usb 1-2: USB disconnect, address 5
> Feb  6 23:59:39 pervalidus kernel: usb 1-2: new low speed USB device
> using uhci_hcd and address 6
> Feb  6 23:59:40 pervalidus kernel: usb 1-2: configuration #1 chosen
> from 1 choice
> Feb  6 23:59:44 pervalidus kernel: input: Logitech Inc. WingMan
> RumblePad as /class/input/input5
> Feb  6 23:59:44 pervalidus kernel: input: USB HID v1.10 Joystick
> [Logitech Inc. WingMan RumblePad] on usb-0000:00:10.0-2
> Feb  6 23:59:44 pervalidus kernel: usb 1-2: USB disconnect, address 6
> Feb  6 23:59:47 pervalidus kernel: usb 1-2: new low speed USB device
> using uhci_hcd and address 7
> Feb  6 23:59:47 pervalidus kernel: usb 1-2: configuration #1 chosen
> from 1 choice
> Feb  6 23:59:57 pervalidus kernel:
> /usr/local/src/kernel/linux-2.6.16/drivers/usb/input/hid-core.c:
> timeout initializing reports
> Feb  6 23:59:57 pervalidus kernel: input: Logitech Inc. WingMan
> RumblePad as /class/input/input6
> Feb  6 23:59:57 pervalidus kernel: input: USB HID v1.10 Joystick
> [Logitech Inc. WingMan RumblePad] on usb-0000:00:10.0-2
> 
> I changed it to other 2 ports and only see a
> 
> Feb  7 00:09:10 pervalidus kernel: usb 1-2: USB disconnect, address 7
> 
> Any way to know if this is the device's fault ?

I've never seen it to be anything but the device's fault, as it's pretty
much impossible for the kernel to disconnect a device like this from the
bus without specifically sending a command to do so (and that didn't
happen here.)

So I'd blame your device :)

thanks,

greg k-h
