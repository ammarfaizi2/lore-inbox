Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267815AbUG3UHT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267815AbUG3UHT (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Jul 2004 16:07:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267817AbUG3UHS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Jul 2004 16:07:18 -0400
Received: from web14925.mail.yahoo.com ([216.136.225.11]:27272 "HELO
	web14925.mail.yahoo.com") by vger.kernel.org with SMTP
	id S267815AbUG3UF6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Jul 2004 16:05:58 -0400
Message-ID: <20040730200557.30128.qmail@web14925.mail.yahoo.com>
Date: Fri, 30 Jul 2004 13:05:57 -0700 (PDT)
From: Jon Smirl <jonsmirl@yahoo.com>
Subject: Re: Exposing ROM's though sysfs
To: Greg KH <greg@kroah.com>, Jesse Barnes <jbarnes@engr.sgi.com>
Cc: linux-pci@atrey.karlin.mff.cuni.cz, Matthew Wilcox <willy@debian.org>,
       Christoph Hellwig <hch@infradead.org>, Jon Smirl <jonsmirl@yahoo.com>,
       lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <20040730195539.GA30466@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The ROMs are definitely different sizes from 2K minimum to 128KB, maybe
even larger. Varying sizes needs to be handled.

--- Greg KH <greg@kroah.com> wrote:

> On Fri, Jul 30, 2004 at 11:49:39AM -0700, Jesse Barnes wrote:
> > +
> > +	/* If the device has a ROM, map it */
> > +	if (pci_resource_len(pdev, PCI_ROM_RESOURCE)) {
> > +		pci_rom_attr.size = pci_resource_len(pdev, PCI_ROM_RESOURCE);
> > +		sysfs_create_bin_file(&pdev->dev.kobj, &pci_rom_attr);
> > +	}
> 
> Doesn't this code cause _all_ rom sizes to be the same, as you only
> have
> 1 pci_rom_attr variable?  You should create a new one for every pci
> device (making sure to clean it up when the device is removed.)
> 
> thanks,
> 
> greg k-h
> 


=====
Jon Smirl
jonsmirl@yahoo.com


		
__________________________________
Do you Yahoo!?
Yahoo! Mail is new and improved - Check it out!
http://promotions.yahoo.com/new_mail
