Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265276AbTFZBCm (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Jun 2003 21:02:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265338AbTFZA5H
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Jun 2003 20:57:07 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:24828 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S265247AbTFZAvk
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Jun 2003 20:51:40 -0400
Date: Wed, 25 Jun 2003 18:02:40 -0700
From: Greg KH <greg@kroah.com>
To: Matthew Wilcox <willy@debian.org>
Cc: linux-pci@atrey.karlin.mff.cuni.cz, linux-kernel@vger.kernel.org
Subject: Re: [RFC] pci_name()
Message-ID: <20030626010239.GB15189@kroah.com>
References: <20030625233525.GB451@parcelfarce.linux.theplanet.co.uk> <20030626003620.GB13892@kroah.com> <20030626005315.GD451@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030626005315.GD451@parcelfarce.linux.theplanet.co.uk>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 26, 2003 at 01:53:15AM +0100, Matthew Wilcox wrote:
> On Wed, Jun 25, 2003 at 05:36:20PM -0700, Greg KH wrote:
> > On Thu, Jun 26, 2003 at 12:35:25AM +0100, Matthew Wilcox wrote:
> > > 
> > > I'd kind of like to get rid of pci_dev->slot_name.  It's redundant with
> > > pci_dev->dev.bus_id, but that's one hell of a search and replace job.
> > > So let me propose pci_name(pci_dev) as a replacement.  That has the
> > 
> > That sounds reasonable.  But do we really need to do this for 2.6?
> > 
> > Just trying to keep things sane...
> 
> I think we really do need to introduce pci_name() for 2.6 (and put it
> in 2.4 too).  We don't need to eliminate pci_dev->slot_name for 2.6,
> but drivers that care need to be able to tell the user which card is
> a message is referring to.  With overlapping pci bus numbers, the 8
> bytes of bus:device.func is no longer unique, so we need to report the
> domain number too.
> 
> That information's already placed in bus_id, but as I said, I don't
> want to start converting all the drivers.  We could just make slot_name
> larger (Anton posted a patch for this) but I don't want to make pci_dev
> even bigger.  Having a nice interface like pci_name() makes drivers more
> portable between 2.4, 2.6 and 2.8 (as Jeff pointed out).

Ok, I'll buy that, feel free to send the patch :)

thanks,

greg k-h
