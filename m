Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261982AbTHYPkd (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Aug 2003 11:40:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261986AbTHYPkd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Aug 2003 11:40:33 -0400
Received: from mail.kroah.org ([65.200.24.183]:43908 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261982AbTHYPk2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Aug 2003 11:40:28 -0400
Date: Mon, 25 Aug 2003 08:31:47 -0700
From: Greg KH <greg@kroah.com>
To: cb-lkml@fish.zetnet.co.uk
Cc: maxk@qualcomm.com, linux-kernel@vger.kernel.org
Subject: Re: [OOPS] [USB] [2.6.0-test3] crash after inserting bluetooth dongle
Message-ID: <20030825153147.GE27705@kroah.com>
References: <20030821211409.GA2062@fish.zetnet.co.uk> <20030821225614.GA5287@kroah.com> <20030825152529.GB2132@fish.zetnet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030825152529.GB2132@fish.zetnet.co.uk>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 25, 2003 at 04:25:29PM +0100, cb-lkml@fish.zetnet.co.uk wrote:
> On Thu, Aug 21, 2003 at 03:56:14PM -0700, Greg KH wrote:
> > On Thu, Aug 21, 2003 at 10:14:10PM +0100, cb-lkml@fish.zetnet.co.uk wrote:
> > > I got this oops. Suspicious /proc/interrupts is below, as well as
> > > /proc/ioports, dmesg output, config, and lspci -vvv.
> > 
> > This has been fixed in the test3-bk tree, I would suggest either waiting
> > for test4, or downloading the latest -bk patch.
> > 
> > If this still happens in 2.6.0-test4, please let the bluetooth driver
> > author know about it.
> 
> Hi Greg, Maxim,
> 
> 2.6.0-test3-mm3 works fine until APM suspend when the USB controller stops
> delivering interrupts. (I'll report further when I have USB working again)

Try unloading all usb drivers before suspending.

-test4 does have more power management code, but it isn't hooked up to
the USB core just yet.

thanks,

greg k-h
