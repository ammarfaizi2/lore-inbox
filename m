Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264791AbTFERnp (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jun 2003 13:43:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264803AbTFERnp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jun 2003 13:43:45 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:10513 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S264791AbTFERno (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jun 2003 13:43:44 -0400
Date: Thu, 5 Jun 2003 18:57:12 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: Greg KH <greg@kroah.com>
Cc: linux-kernel@vger.kernel.org, pcihpd-discuss@lists.sourceforge.net
Subject: Re: [PATCH] PCI and PCI Hotplug changes and fixes for 2.5.70
Message-ID: <20030605185712.B4125@flint.arm.linux.org.uk>
Mail-Followup-To: Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org,
	pcihpd-discuss@lists.sourceforge.net
References: <10547787473026@kroah.com> <10547787472263@kroah.com> <20030605101936.D960@flint.arm.linux.org.uk> <20030605170410.GA5284@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030605170410.GA5284@kroah.com>; from greg@kroah.com on Thu, Jun 05, 2003 at 10:04:10AM -0700
X-Message-Flag: Your copy of Microsoft Outlook is vulnerable to viruses. See www.mutt.org for more details.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 05, 2003 at 10:04:10AM -0700, Greg KH wrote:
> On Thu, Jun 05, 2003 at 10:19:36AM +0100, Russell King wrote:
> > On Wed, Jun 04, 2003 at 07:05:47PM -0700, Greg KH wrote:
> > > diff -Nru a/drivers/pci/bus.c b/drivers/pci/bus.c
> > > --- a/drivers/pci/bus.c	Wed Jun  4 18:11:51 2003
> > > +++ b/drivers/pci/bus.c	Wed Jun  4 18:11:51 2003
> > > @@ -129,6 +129,5 @@
> > >  	}
> > >  }
> > >  
> > > -EXPORT_SYMBOL(pci_bus_alloc_resource);
> > >  EXPORT_SYMBOL(pci_bus_add_devices);
> > >  EXPORT_SYMBOL(pci_enable_bridges);
> > 
> > Please don't remove this one.  Its there for stuff like:
> > 
> > drivers/pcmcia/cardbus.c
> 
> Sorry, I don't see that in the current kernel version of cardbus.c,
> otherwise I would not have moved it out.  Feel free to put it back, if
> you need it for any future cardbus changes.

Well, if people are going to remove stuff, I'm not going to be bothered
to even submit the changes.  I've got enough to do at the moment to go
around putting stuff back into the kernel which I've already submitted.

> /*
>  * This file is going away.  Cardbus handling has been re-written to be
>  * more of a PCI bridge thing, and the PCI code basically does all the
>  * resource handling. This has wrappers to make the rest of the PCMCIA
>  * subsystem not notice that it's not here any more.
>  *
>  *              Linus, Jan 2000
>  */
> 
> Is that ever going to happen?  Just curious, because if so, I can remove
> some more functions from pci.h :)

It doesn't look like it.

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

