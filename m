Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261700AbSIXQZV>; Tue, 24 Sep 2002 12:25:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261701AbSIXQZV>; Tue, 24 Sep 2002 12:25:21 -0400
Received: from air-2.osdl.org ([65.172.181.6]:64641 "EHLO cherise.pdx.osdl.net")
	by vger.kernel.org with ESMTP id <S261700AbSIXQZT>;
	Tue, 24 Sep 2002 12:25:19 -0400
Date: Tue, 24 Sep 2002 09:32:10 -0700 (PDT)
From: Patrick Mochel <mochel@osdl.org>
X-X-Sender: mochel@cherise.pdx.osdl.net
To: Greg KH <greg@kroah.com>
cc: linux-kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH-RFC] README 1ST - New problem logging macros (2.5.38)
In-Reply-To: <20020924055814.GA21931@kroah.com>
Message-ID: <Pine.LNX.4.44.0209240926500.966-100000@cherise.pdx.osdl.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 23 Sep 2002, Greg KH wrote:

> One further comment:
> 
> On Mon, Sep 23, 2002 at 06:55:13PM -0700, Larry Kessler wrote:
> > --- linux-2.5.37/drivers/include/linux/net_problem.h	Wed Dec 31 18:00:00 1969
> > +++ linux-2.5.37-net/include/linux/net_problem.h	Mon Sep 23 20:04:23 2002
> 
> 
> > --- linux-2.5.37/drivers/include/linux/pci_problem.h	Wed Dec 31 18:00:00 1969
> > +++ linux-2.5.37-net/include/linux/pci_problem.h	Mon Sep 23 19:56:11 2002
> 
> {sigh}
> 
> Have people been ignoring all of the core driver changes that have been
> happening?  Almost everything that is "struct device" now, with some bus
> specific things tacked on (and those bus specific things are getting
> slowly merged into struct device too.)
> 
> It would make more sense (if you continue this path of changes to the
> kernel) to focus on the device, bus, and class structures.  That way you
> don't have to create a usb_problem.h, iee1394_problem.h, i2c_problem.h,
> i2o_problem.h, scsi_problem.h, ide_problem.h, etc.

On a tangent and ignoring the completely correct statement...

Why do we have such a flat namespace in include/linux/ anyway? Assuming 
introducing a problem.h header for each subsystem was a sound idea, we 
could just have

include/linux/problem/pci.h
include/linux/problem/net.h
...


	-pat

