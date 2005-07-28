Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261313AbVG1G7Q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261313AbVG1G7Q (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Jul 2005 02:59:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261310AbVG1G7P
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Jul 2005 02:59:15 -0400
Received: from lyle.provo.novell.com ([137.65.81.174]:10052 "EHLO
	lyle.provo.novell.com") by vger.kernel.org with ESMTP
	id S261313AbVG1G7K (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Jul 2005 02:59:10 -0400
Date: Wed, 27 Jul 2005 23:58:47 -0700
From: Greg KH <gregkh@suse.de>
To: "Michael S. Tsirkin" <mst@mellanox.co.il>
Cc: linux-pci@atrey.karlin.mff.cuni.cz, linux-kernel@vger.kernel.org,
       mj@ucw.cz, openib-general@openib.org
Subject: Re: [PATCH] arch/xx/pci: remap_pfn_range -> io_remap_pfn_range
Message-ID: <20050728065847.GA18003@suse.de>
References: <20050725223200.GA1545@mellanox.co.il> <20050728042607.GA12799@suse.de> <20050728064859.GA11644@mellanox.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050728064859.GA11644@mellanox.co.il>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 28, 2005 at 09:48:59AM +0300, Michael S. Tsirkin wrote:
> Quoting r. Greg KH <gregkh@suse.de>:
> > Subject: Re: [PATCH] arch/xx/pci: remap_pfn_range -> io_remap_pfn_range
> > 
> > On Tue, Jul 26, 2005 at 01:32:00AM +0300, Michael S. Tsirkin wrote:
> > > Greg, Martin, does the following make sense?
> > > If it does, should other architectures be updated as well?
> > > 
> > Hm, you do realize that io_remap_pfn_range() is the same thing as
> > remap_pfn_range() on i386, right?
> > 
> > So, why would this patch change anything?
> > 
> > thanks,
> > 
> > greg k-h
> > 
> 
> It doesnt change any behaviour.
> Its a style issue I'm trying to fix: even in arch specific code, isnt it better
> to use a generic io_remap_pfn_range to map PCI memory?

As I said above, it's the same thing on i386.
But, if you are getting picky, you should fix all of the other arches
too, right?

Anyway, why change this, I don't really see the need.

thanks,

greg k-h
