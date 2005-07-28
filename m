Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261572AbVG1QTZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261572AbVG1QTZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Jul 2005 12:19:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261456AbVG1QRw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Jul 2005 12:17:52 -0400
Received: from lyle.provo.novell.com ([137.65.81.174]:22372 "EHLO
	lyle.provo.novell.com") by vger.kernel.org with ESMTP
	id S261556AbVG1QRf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Jul 2005 12:17:35 -0400
Date: Thu, 28 Jul 2005 09:17:20 -0700
From: Greg KH <gregkh@suse.de>
To: Ian Pratt <m+Ian.Pratt@cl.cam.ac.uk>
Cc: Roland Dreier <rolandd@cisco.com>,
       "Michael S. Tsirkin" <mst@mellanox.co.il>,
       linux-pci@atrey.karlin.mff.cuni.cz, openib-general@openib.org,
       linux-kernel@vger.kernel.org, mj@ucw.cz, ian.pratt@cl.cam.ac.uk
Subject: Re: [openib-general] Re: [PATCH] arch/xx/pci: remap_pfn_range -> io_remap_pfn_range
Message-ID: <20050728161720.GA23507@suse.de>
References: <A95E2296287EAD4EB592B5DEEFCE0E9D282808@liverpoolst.ad.cl.cam.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <A95E2296287EAD4EB592B5DEEFCE0E9D282808@liverpoolst.ad.cl.cam.ac.uk>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 28, 2005 at 12:57:51PM +0100, Ian Pratt wrote:
> > >     Greg> Hm, you do realize that io_remap_pfn_range() is the same
> > >     Greg> thing as remap_pfn_range() on i386, right?
> > > 
> > >     Greg> So, why would this patch change anything?
> > > 
> > > It's not the same thing under Xen.  I think this patch 
> > fixes userspace 
> > > access to PCI memory for XenLinux.
> > 
> > But Xen is a separate arch, and hence, will get different pci 
> > arch specific functions, right?
> > 
> > In short, what is this patch trying to fix?  What is the 
> > problem anyone is seeing with the existing code?
> 
> As I understand it, remap_pfn_range should be used for mapping pages
> that are backed by memory, and io_remap_pfn_range should be used for
> mapping MMIO regions.
> There's a distinciton between the two for architectures like Sparc and
> xen/x86. 

I agree, but not for i386, which is what the patch was trying to change.

If this is a fix for xen, fine, then say so in the changelog information
for the patch, as it is, no such information was given.

thanks,

greg k-h
