Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265592AbUBBDZV (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 Feb 2004 22:25:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265595AbUBBDZV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 Feb 2004 22:25:21 -0500
Received: from mail.kroah.org ([65.200.24.183]:15291 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S265592AbUBBDZR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 Feb 2004 22:25:17 -0500
Date: Sun, 1 Feb 2004 19:25:14 -0800
From: Greg KH <greg@kroah.com>
To: Jonas Diemer <diemer@gmx.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Which interface: sysfs, proc, devfs?
Message-ID: <20040202032514.GB20534@kroah.com>
References: <20040129222813.3b22b2c8.diemer@gmx.de> <20040129230250.GA9988@kroah.com> <20040201215721.737ef5a3.diemer@gmx.de> <20040201212802.GA16301@kroah.com> <20040201230010.15874b4c.diemer@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040201230010.15874b4c.diemer@gmx.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 01, 2004 at 11:00:10PM +0100, Jonas Diemer wrote:
> On Sun, 1 Feb 2004 13:28:03 -0800
> Greg KH <greg@kroah.com> wrote:
> 
> > You mean "submit a urb and be notified when it was completed?"  I
> > thought libusb supported that with signals.
> 
> Yeah, thats what I meant. In the html doc shipped with version 0.1.7,
> it says "all functions in libusb v0.1 are synchronous, meaning the
> functions block and wait for the operation to finish or timeout before
> returning execution to the calling application. Asynchronous operation
> will be supported in v1.0, but not v0.1."...

Yet you want to do asynchronous support with sysfs?  How would that
work?

What kind of device are you writing a driver for?

> Thanks for that hint, I'll have a look at it. I only need 1 val per
> file, i.e. a "firmware" file, which I learned is best done with the
> firmware_class.

For firmware only download type devices, I'd really recommend sticking
with libusb, unless you have to.  It's much easier that way.

thanks,

greg k-h
