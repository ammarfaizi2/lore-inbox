Return-Path: <linux-kernel-owner+w=401wt.eu-S932920AbWLNVQv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932920AbWLNVQv (ORCPT <rfc822;w@1wt.eu>);
	Thu, 14 Dec 2006 16:16:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932921AbWLNVQv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Dec 2006 16:16:51 -0500
Received: from ns.suse.de ([195.135.220.2]:33927 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932920AbWLNVQu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Dec 2006 16:16:50 -0500
Date: Thu, 14 Dec 2006 13:16:23 -0800
From: Greg KH <gregkh@suse.de>
To: Alan <alan@lxorguk.ukuu.org.uk>
Cc: Hans-J??rgen Koch <hjk@linutronix.de>, Hua Zhong <hzhong@gmail.com>,
       "'Martin J. Bligh'" <mbligh@mbligh.org>,
       "'Linus Torvalds'" <torvalds@osdl.org>,
       "'Jonathan Corbet'" <corbet@lwn.net>, "'Andrew Morton'" <akpm@osdl.org>,
       "'Michael K. Edwards'" <medwards.linux@gmail.com>,
       linux-kernel@vger.kernel.org
Subject: Re: GPL only modules [was Re: [GIT PATCH] more Driver core patches for 2.6.19]
Message-ID: <20061214211623.GA2204@suse.de>
References: <4580E37F.8000305@mbligh.org> <200612141231.17331.hjk@linutronix.de> <20061214124241.44347df6@localhost.localdomain> <200612141354.26506.hjk@linutronix.de> <20061214165954.GA23138@suse.de> <20061214182626.6b07c6ad@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061214182626.6b07c6ad@localhost.localdomain>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 14, 2006 at 06:26:26PM +0000, Alan wrote:
> > Think of uio as just a "class" of driver, like input or v4l.  It's still
> > up to the driver writer to provide a proper bus interface to the
> > hardware (pci, usb, etc.) in order for the device to work at all.
> 
> Understood. That leads me to ask another question of the folks who deal
> with a lot of these cards. How many could reasonably be described by the
> following
> 
> 		bar to map, offset, length, ro/rw, root/user, local-offset
> (x n ?)
> 		interrupt function or null
> 
> It seems if we have a lot of this kind of card that all fit that pattern
> it might actually get more vendors submitting updates if we had a single
> pci driver that took a struct of the above as the device_id field so
> vendors had to write five lines of IRQ code, a struct and update a PCI
> table ? That seems to have mostly worked with all the parallel/serial
> boards.

I think that something like this might work out, and it would be a good
goal to get there eventually.  But I would like to see a few drivers
using the uio core to see where we can consolidate things like this
first.

thanks,

greg k-h
