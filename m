Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965090AbVJ1Eo2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965090AbVJ1Eo2 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Oct 2005 00:44:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965091AbVJ1Eo2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Oct 2005 00:44:28 -0400
Received: from mail.kroah.org ([69.55.234.183]:32964 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S965090AbVJ1Eo1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Oct 2005 00:44:27 -0400
Date: Thu, 27 Oct 2005 17:57:02 -0700
From: Greg KH <greg@kroah.com>
To: Stephen Hemminger <shemminger@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [patch 1/1] PCI: automatically set device_driver.owner
Message-ID: <20051028005702.GA12535@kroah.com>
References: <20051027211253.457180000@antares.localdomain> <20051027161744.623e1ada@dxpl.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051027161744.623e1ada@dxpl.pdx.osdl.net>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 27, 2005 at 04:17:44PM -0700, Stephen Hemminger wrote:
> On Thu, 27 Oct 2005 23:12:54 +0200
> Laurent riffard <laurent.riffard@free.fr> wrote:
> 
> > A nice feature of sysfs is that it can create the symlink from the
> > driver to the module that is contained in it.
> > 
> > It requires that the device_driver.owner is set, what is not the
> > case for many PCI drivers.
> > 
> > This patch allows pci_register_driver to set automatically the
> > device_driver.owner for any PCI driver.
> > 
> > Credits to Al Viro who suggested the method.
> > 
> > Signed-off-by: Laurent Riffard <laurent.riffard@free.fr>
> > --
> 
> Okay, but a little too much macro trickery for my taste.

Yeah, pci_register_driver() should be a inline function, to make the
compiler warnings a bit easier to figure out.

Other than that, do you have any suggestions on how to not be so
"tricky" and yet, not have to touch every pci driver in the kernel tree?

thanks,

greg k-h
