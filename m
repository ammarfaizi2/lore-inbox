Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263017AbUDLSzs (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Apr 2004 14:55:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263027AbUDLSzs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Apr 2004 14:55:48 -0400
Received: from mail.kroah.org ([65.200.24.183]:17327 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S263017AbUDLSzr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Apr 2004 14:55:47 -0400
Date: Mon, 12 Apr 2004 11:51:21 -0700
From: Greg KH <greg@kroah.com>
To: viro@parcelfarce.linux.theplanet.co.uk, linux-kernel@vger.kernel.org,
       tim@cyberelk.net
Subject: Re: [PATCH 2.6] Class support for ppdev.c
Message-ID: <20040412185121.GD21502@kroah.com>
References: <20040410135115.GA3612@penguin.localdomain> <20040410170148.GI1317@kroah.com> <20040410180636.GB3612@penguin.localdomain> <20040410194601.GC3612@penguin.localdomain> <20040410202858.GU31500@parcelfarce.linux.theplanet.co.uk> <20040411082553.GA2499@penguin.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040411082553.GA2499@penguin.localdomain>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 11, 2004 at 10:25:53AM +0200, Marcel Sebek wrote:
> On Sat, Apr 10, 2004 at 09:28:59PM +0100, viro@parcelfarce.linux.theplanet.co.uk wrote:
> > On Sat, Apr 10, 2004 at 09:46:01PM +0200, Marcel Sebek wrote:
> > > And new updated patch. partport_find_number() needs to decrement refcount
> > > by parport_put_port().
> > 
> > And it's still broken.  New parports can appear at any point - hell, we even
> > have USB->parport converters.  IOW, if you want to do something useful here -
> > use ->attach()/->detach() of parport_driver.
> > 
> Ok. Here's new one. It uses attach()/detach() callbacks for creating
> udev and devfs files.

Looks much better, thanks.  But please don't modify the current devfs
usage, those users will generally not like that.  Can you redo this
patch to only add the sysfs changes?

thanks,

greg k-h
