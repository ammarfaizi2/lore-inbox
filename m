Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269493AbUJFVlT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269493AbUJFVlT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Oct 2004 17:41:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269492AbUJFViU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Oct 2004 17:38:20 -0400
Received: from mail.kroah.org ([69.55.234.183]:18614 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S269493AbUJFVdx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Oct 2004 17:33:53 -0400
Date: Wed, 6 Oct 2004 14:33:25 -0700
From: Greg KH <greg@kroah.com>
To: Alan Kilian <kilian@bobodyne.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Solaris developer wants a Linux Mentor for drivers.
Message-ID: <20041006213325.GA25817@kroah.com>
References: <200410061821.i96IL9a07610@raceme.attbi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200410061821.i96IL9a07610@raceme.attbi.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 06, 2004 at 01:21:09PM -0500, Alan Kilian wrote:
> Forwarded message:
> > From: Greg KH <greg@kroah.com>
> > 
> > Why not 2.6?  No new Linux distros are shipping 2.4 kernels anymore...
> 
>   Well, I down loaded and installed RedHat-9 5 weeks ago, and it
>   is a 2.4 kernel, so I thought that would be fine.
>   (See what a novice I am?)

Heh, Red Hat 9 is quite old now (a few years old I think.)  Try the
latest Red Hat Fedora Core 2 for a more up to date distro if you like to
use Red Hat.

> > And a PCI bus driver?  
> > What kind of hardware is this?  
> > Is this a driver for a pci card, or a pci bus controller?
> 
>   This is a driver for talking to my hardware which is a PCI bus card.

So, it's a card, not a PCI bus controller, right?  That's much simpler.

>   This card has 5 large FPGAs, SRAM and dram on it which is used to
>   accelerate bioinformatics search algorithms.
> 
>   The card works under Sun Solaris and Windows/2000, and of course,
>   we would like to add Linux to the list.
> 
>   Eventually, I'll need to support DMA to and from the card, but
>   I can get by for a while just doing single-dword I/O.
> 
>   I just hacked in dev->bus->ops->read_dword(dev,1,&retval);
>   and I can read memory on the card! (Well, things don't crash anyway)

What's wrong with using readl() instead?  Use pci_read_config_dword() if
you want access to the config space.

>   If this is absolutely the wrong way to do this, please let me know!
> 
>   Note: I have no idea what the second parameter to read_dword() is!

Try getting a copy of the Linux Device Drivers book (it's also online if
you don't want to buy it) and taking a look at the pci chapter.  It
should help you out.

Do you have a pointer to your Linux driver that we might be able to help
you out with?

Good luck,

greg k-h
