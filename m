Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271287AbTHMAYa (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Aug 2003 20:24:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271289AbTHMAYa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Aug 2003 20:24:30 -0400
Received: from mail.kroah.org ([65.200.24.183]:54412 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S271287AbTHMAYY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Aug 2003 20:24:24 -0400
Date: Tue, 12 Aug 2003 17:23:44 -0700
From: Greg KH <greg@kroah.com>
To: Matthew Wilcox <willy@debian.org>
Cc: Dave Jones <davej@redhat.com>, jgarzik@pobox.com, davem@redhat.com,
       linux-kernel@vger.kernel.org,
       kernel-janitor-discuss@lists.sourceforge.net
Subject: Re: C99 Initialisers
Message-ID: <20030813002344.GA2797@kroah.com>
References: <20030812020226.GA4688@zip.com.au> <1060654733.684.267.camel@localhost> <20030812023936.GE3169@parcelfarce.linux.theplanet.co.uk> <20030812053826.GA1488@kroah.com> <20030812112729.GF3169@parcelfarce.linux.theplanet.co.uk> <20030812180158.GA1416@kroah.com> <20030812235324.GA12953@redhat.com> <20030813000841.GP10015@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030813000841.GP10015@parcelfarce.linux.theplanet.co.uk>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 13, 2003 at 01:08:41AM +0100, Matthew Wilcox wrote:
> On Wed, Aug 13, 2003 at 12:53:24AM +0100, Dave Jones wrote:
> > What would be *really* nice, would be the ability to do something
> > to the effect of..

Yeah, that would be cool to do.  2.7 :)

> While we're off in never-never land, it'd be nice to specify default
> values for struct initialisers.  eg, something like:

Yeah, I've wanted that for a while too.  Don't really know how to get
the compiler to do that though :(

> Erm, hang on a second ...  Since when are PCI IDs 32-bit?  What is this
> ridiculous bloat?  You can't even argue that this makes things pack
> better since this packs equally well:

Yeah, it was just a port from 2.4 which says:

	struct pci_device_id {
		unsigned int vendor, device;
		unsigned int subvendor, subdevice;
		unsigned int class, class_mask;
		unsigned long driver_data;
	};

We could probably change it now if you really want to.  Don't know if it
will save much space though.

thanks,

greg k-h
