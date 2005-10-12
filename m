Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932487AbVJLXq7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932487AbVJLXq7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Oct 2005 19:46:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932488AbVJLXq7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Oct 2005 19:46:59 -0400
Received: from mail.kroah.org ([69.55.234.183]:31925 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S932487AbVJLXq6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Oct 2005 19:46:58 -0400
Date: Wed, 12 Oct 2005 16:46:27 -0700
From: Greg KH <gregkh@suse.de>
To: Jason Gunthorpe <jgunthorpe@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Misconfiguration of 64 bit MMIO Prefetch BARs in 2.6.13
Message-ID: <20051012234626.GA26484@suse.de>
References: <da2267130510112014g692f9620i8cb269c19e1802ec@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <da2267130510112014g692f9620i8cb269c19e1802ec@mail.gmail.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 11, 2005 at 09:14:38PM -0600, Jason Gunthorpe wrote:
> --- linux-2.6.13/drivers/pci/setup-bus.c 2005-08-28 23:41:01.000000000000
> +++ /usr/src/linux-2.6.13/drivers/pci/setup-bus.c 2005-10-12
> 03:03:09.000000+0000
> @@ -148,6 +148,7 @@
> struct pci_dev *bridge = bus->self;
> struct pci_bus_region region;
> u32 l, io_upper16;
> + u32 pf_upperbase64;
> 
> DBG(KERN_INFO "PCI: Bridge: %s\n", pci_name(bridge));
> 
> @@ -203,15 +204,23 @@
> l |= region.end & 0xfff00000;
> DBG(KERN_INFO " PREFETCH window: %08lx-%08lx\n",
> region.start, region.end);
> +

Your email client ate the tabs and spaces for this patch, care to try
again?

And have you tried 2.6.14-rc4?

thanks,

greg k-h
