Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261199AbULAAnd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261199AbULAAnd (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Nov 2004 19:43:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261215AbULAAks
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Nov 2004 19:40:48 -0500
Received: from mail.kroah.org ([69.55.234.183]:37000 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261192AbULAAfm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Nov 2004 19:35:42 -0500
Date: Tue, 30 Nov 2004 16:34:31 -0800
From: Greg KH <greg@kroah.com>
To: Jeffrey Lim <jfs.world@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net
Subject: Re: help with writing a usb mouse driver
Message-ID: <20041201003431.GC27772@kroah.com>
Reply-To: linux-usb-devel@lists.sourceforge.net
References: <4b3125cc041127073956f967de@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4b3125cc041127073956f967de@mail.gmail.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 27, 2004 at 11:39:37PM +0800, Jeffrey Lim wrote:
> Note: pls cc me in any replies as i'm not subscribed to the list.
> 
> hi guys, i've been trying to write a usb mouse driver for a custom
> mouse, but i'm getting stuck.
> 
> I previously started out with trying to hack usbmouse.c, but
> apparently after a wild goose chase, it seems that that is not the
> recommended path to take. It supposedly conflicts with the hid driver,
> though in what way i do not know. (If somebody could enlighten me on
> this, pls do. Documentation/input/input.txt does not really explain
> why).

The Kconfig documentation for that driver should explain why.
usbmouse.c is for USB Boot Protocol Mice only.  Only if you understand
what this protocol is, should you use that driver.  Everyone else should
use the hid driver.

> So now it almost seems as if the only code i have for analysis and as
> a sample is the hid code (hid-core.c, hid-input.c, i assume). But the
> problem for me is that this code is too complex for me, and really
> doesn't offer the easiest way to get started on this project. I'm not
> too sure usb-skeleton.c does it either, because it doesn't have the
> code for interfacing with the input layer.

What kind of usb mouse do you have?  Is it a HID mouse?  Or some custom
protocol?

Also, this should be discussed on the linux-usb-devel mailing list,
there are more Linux usb developers there than on linux-kernel.

> I'm using kernel 2.4.20.

Ick, why?  What's wrong with the latest 2.4 or 2.6 kernel?

thanks,

greg k-h
