Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261352AbTIBRtL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Sep 2003 13:49:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263590AbTIBRRh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Sep 2003 13:17:37 -0400
Received: from mail.kroah.org ([65.200.24.183]:28856 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S263290AbTIBRRf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Sep 2003 13:17:35 -0400
Date: Tue, 2 Sep 2003 10:17:29 -0700
From: Greg KH <greg@kroah.com>
To: Pavel Machek <pavel@ucw.cz>
Cc: Linus Torvalds <torvalds@osdl.org>,
       kernel list <linux-kernel@vger.kernel.org>,
       Patrick Mochel <mochel@osdl.org>, rmk@arm.linux.org.uk
Subject: Re: Fix up power managment in 2.6
Message-ID: <20030902171729.GB17807@kroah.com>
References: <20030831232812.GA129@elf.ucw.cz> <Pine.LNX.4.44.0309010925230.7908-100000@home.osdl.org> <20030901211220.GD342@elf.ucw.cz> <20030901225243.D22682@flint.arm.linux.org.uk> <20030901221920.GE342@elf.ucw.cz> <20030901233023.F22682@flint.arm.linux.org.uk> <20030901224018.GA470@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030901224018.GA470@elf.ucw.cz>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 02, 2003 at 12:40:18AM +0200, Pavel Machek wrote:
> > I don't think PCI device support broke - Pat seems to have fixed up
> > all that fairly nicely, so the driver model change should be
> > transparent.
> 
> As far as I can test, yes, at least UHCI looks broken :-(. It is true
> that calling convention at PCI level did not change.

UHCI is broken?  How?  

Hey, I don't think that the USB code will work at all with suspend
without just unloading the whole USB core.

But I now have some patches in my tree that hook up the usb tree with
the power model to allow usb drivers to be notified that they should
save state in order to try to work on fixing this "problem".

greg k-h
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/
On Tue, Sep 02, 2003 at 12:40:18AM +0200, Pavel Machek wrote:
> > I don't think PCI device support broke - Pat seems to have fixed up
> > all that fairly nicely, so the driver model change should be
> > transparent.
> 
> As far as I can test, yes, at least UHCI looks broken :-(. It is true
> that calling convention at PCI level did not change.

UHCI is broken?  How?  

Hey, I don't think that the USB code will work at all with suspend
without just unloading the whole USB core.

But I now have some patches in my tree that hook up the usb tree with
the power model to allow usb drivers to be notified that they should
save state in order to try to work on fixing this "problem".

greg k-h
