Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267136AbSL3X4M>; Mon, 30 Dec 2002 18:56:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267141AbSL3X4M>; Mon, 30 Dec 2002 18:56:12 -0500
Received: from 12-231-249-244.client.attbi.com ([12.231.249.244]:64271 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S267136AbSL3X4H>;
	Mon, 30 Dec 2002 18:56:07 -0500
Date: Mon, 30 Dec 2002 15:59:34 -0800
From: Greg KH <greg@kroah.com>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] pnp & pci structure cleanups
Message-ID: <20021230235934.GE814@kroah.com>
References: <Pine.LNX.4.33.0212291228200.532-100000@pnote.perex-int.cz> <20021230221212.GE32324@kroah.com> <1041289960.13684.180.camel@irongate.swansea.linux.org.uk> <20021230225012.GA19633@gtf.org> <20021230225134.GD814@kroah.com> <20021230231436.GA20810@gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021230231436.GA20810@gtf.org>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 30, 2002 at 06:14:36PM -0500, Jeff Garzik wrote:
> On Mon, Dec 30, 2002 at 02:51:34PM -0800, Greg KH wrote:
> > On Mon, Dec 30, 2002 at 05:50:12PM -0500, Jeff Garzik wrote:
> > > Note that we need a way to do field replacement of PCI id tables.
> > > 
> > > I've been harping on that to various ears for years :)
> > 
> > And USB id tables.  A number of usb drivers are slowly adding module
> > paramater hacks to get around this, but it would be really nice to do
> > this "correctly" for all drivers.  Somehow...
> 
> Surely there is a sysfs path we can devise to do
> 
> 	echo "add <pci_device_id line>" > /sys/pci/driver/tulip
> 
> (or replace that with a file-oriented interface that inputs an entire
> table)
> 
> and internally just refer to, and update, a kmalloc'd copy of the
> original driver's pci (or usb) table.

Yes, that would be a good thing to have, I sure would like that.

(hint, hint, hint, for anyone wanting a way to contribute...)

> > > <tangent>
> > > I also want to add PCI revision id and mask to struct pci_device_id.
> > > </tangent>
> > 
> > Do any drivers need that today?  It shouldn't be that hard to do it, and
> > now is the time :)
> 
> Yes.  tulip driver could find this useful, but that's currently a small
> case worked around in the driver.
> 
> The big and annoying case is 8139C+ (8139cp.c), which has the same
> PCI id as old 8139 boards, but additionally includes dramatically new
> and better functionality.  The distinguishing characteristic at the
> probe phase is the PCI revision id, as the PCI id is the same as another
> driver.

Ok, sounds like a good enough reason to add these fields :)

thanks,

greg k-h
