Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264765AbTFERDK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jun 2003 13:03:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264768AbTFERDK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jun 2003 13:03:10 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.101]:23712 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S264765AbTFERDJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jun 2003 13:03:09 -0400
Date: Thu, 5 Jun 2003 10:04:10 -0700
From: Greg KH <greg@kroah.com>
To: linux-kernel@vger.kernel.org, pcihpd-discuss@lists.sourceforge.net
Subject: Re: [PATCH] PCI and PCI Hotplug changes and fixes for 2.5.70
Message-ID: <20030605170410.GA5284@kroah.com>
References: <10547787473026@kroah.com> <10547787472263@kroah.com> <20030605101936.D960@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030605101936.D960@flint.arm.linux.org.uk>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 05, 2003 at 10:19:36AM +0100, Russell King wrote:
> On Wed, Jun 04, 2003 at 07:05:47PM -0700, Greg KH wrote:
> > diff -Nru a/drivers/pci/bus.c b/drivers/pci/bus.c
> > --- a/drivers/pci/bus.c	Wed Jun  4 18:11:51 2003
> > +++ b/drivers/pci/bus.c	Wed Jun  4 18:11:51 2003
> > @@ -129,6 +129,5 @@
> >  	}
> >  }
> >  
> > -EXPORT_SYMBOL(pci_bus_alloc_resource);
> >  EXPORT_SYMBOL(pci_bus_add_devices);
> >  EXPORT_SYMBOL(pci_enable_bridges);
> 
> Please don't remove this one.  Its there for stuff like:
> 
> drivers/pcmcia/cardbus.c

Sorry, I don't see that in the current kernel version of cardbus.c,
otherwise I would not have moved it out.  Feel free to put it back, if
you need it for any future cardbus changes.

Oh, and I was looking at cardbus.c when doing these changes and saw this
old comment:

/*
 * This file is going away.  Cardbus handling has been re-written to be
 * more of a PCI bridge thing, and the PCI code basically does all the
 * resource handling. This has wrappers to make the rest of the PCMCIA
 * subsystem not notice that it's not here any more.
 *
 *              Linus, Jan 2000
 */

Is that ever going to happen?  Just curious, because if so, I can remove
some more functions from pci.h :)

thanks,

greg k-h
