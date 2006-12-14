Return-Path: <linux-kernel-owner+w=401wt.eu-S1751946AbWLNRAV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751946AbWLNRAV (ORCPT <rfc822;w@1wt.eu>);
	Thu, 14 Dec 2006 12:00:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751948AbWLNRAV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Dec 2006 12:00:21 -0500
Received: from ns2.suse.de ([195.135.220.15]:35470 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751947AbWLNRAU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Dec 2006 12:00:20 -0500
Date: Thu, 14 Dec 2006 08:59:54 -0800
From: Greg KH <gregkh@suse.de>
To: Hans-J??rgen Koch <hjk@linutronix.de>
Cc: Alan <alan@lxorguk.ukuu.org.uk>, Hua Zhong <hzhong@gmail.com>,
       "'Martin J. Bligh'" <mbligh@mbligh.org>,
       "'Linus Torvalds'" <torvalds@osdl.org>,
       "'Jonathan Corbet'" <corbet@lwn.net>, "'Andrew Morton'" <akpm@osdl.org>,
       "'Michael K. Edwards'" <medwards.linux@gmail.com>,
       linux-kernel@vger.kernel.org
Subject: Re: GPL only modules [was Re: [GIT PATCH] more Driver core patches for 2.6.19]
Message-ID: <20061214165954.GA23138@suse.de>
References: <4580E37F.8000305@mbligh.org> <200612141231.17331.hjk@linutronix.de> <20061214124241.44347df6@localhost.localdomain> <200612141354.26506.hjk@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200612141354.26506.hjk@linutronix.de>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 14, 2006 at 01:54:24PM +0100, Hans-J??rgen Koch wrote:
> Am Donnerstag, 14. Dezember 2006 13:42 schrieb Alan:
> > > > uio also doesn't handle hotplug, pci and other "small" matters.
> > > 
> > > uio is supposed to be a very thin layer. Hotplug and PCI are already
> > > handled by other subsystems. 
> > 
> > And if you have a PCI or a hotplug card ? How many industrial I/O cards
> > are still ISA btw ?
> 
> Who is talking about ISA? All cards we had in mind are PCI. Of course
> you have to do the usual initialization work in your probe/release or
> init/exit functions. These are just a few lines you find in any
> beginners device-driver-writing book. I don't think that the UIO 
> framework could simplify that in a sensible way.

Agreed, you still have to write a kernel driver to handle the pci
probe/disconnect functions and the pci id stuff to use the uio core
properly.  That's not in question here at all and please don't think
that uio even attempts to handle this, as that is not what it's job is.

Think of uio as just a "class" of driver, like input or v4l.  It's still
up to the driver writer to provide a proper bus interface to the
hardware (pci, usb, etc.) in order for the device to work at all.

thanks,

greg k-h
