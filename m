Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422899AbWAMUA6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422899AbWAMUA6 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Jan 2006 15:00:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422900AbWAMUAh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Jan 2006 15:00:37 -0500
Received: from mail.kroah.org ([69.55.234.183]:15256 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1422905AbWAMUAL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Jan 2006 15:00:11 -0500
Date: Fri, 13 Jan 2006 11:59:39 -0800
From: Greg KH <greg@kroah.com>
To: Christoph Hellwig <hch@infradead.org>, Andrew Morton <akpm@osdl.org>,
       "Moore, Eric" <Eric.Moore@lsil.com>, linux-kernel@vger.kernel.org,
       linux-scsi@vger.kernel.org
Subject: Re: [PATCH] - pci_ids - adding pci device id support for FC949ES
Message-ID: <20060113195939.GB18869@kroah.com>
References: <F331B95B72AFFB4B87467BE1C8E9CF5F1AA29A@NAMAIL2.ad.lsil.com> <20060113000323.09cbff98.akpm@osdl.org> <20060113181002.GG20718@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060113181002.GG20718@infradead.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 13, 2006 at 06:10:02PM +0000, Christoph Hellwig wrote:
> On Fri, Jan 13, 2006 at 12:03:23AM -0800, Andrew Morton wrote:
> > >  --- b/include/linux/pci_ids.h	2006-01-11 19:04:18.000000000 -0700
> > >  +++ a/include/linux/pci_ids.h	2006-01-12 14:19:43.000000000 -0700
> > >  @@ -181,6 +181,7 @@
> > >   #define PCI_DEVICE_ID_LSI_FC929X	0x0626
> > >   #define PCI_DEVICE_ID_LSI_FC939X	0x0642
> > >   #define PCI_DEVICE_ID_LSI_FC949X	0x0640
> > >  +#define PCI_DEVICE_ID_LSI_FC949ES	0x0646
> > >   #define PCI_DEVICE_ID_LSI_FC919X	0x0628
> > >   #define PCI_DEVICE_ID_NCR_YELLOWFIN	0x0701
> > >   #define PCI_DEVICE_ID_LSI_61C102	0x0901
> > 
> > That doesn't add support - it just adds the ID.  We've apparently decided
> > not to keep IDs of devices which the kernel doesn't support.
> 
> There's a patch on linux-scsi that adds the actual support.

Then include this as part of that patch please.  Or if you are going to
add ids to this file, at least CC: the PCI kernel maintainer so he knows
to add them.  And also say that an already submitted patch needs it.

> > Also, there's a plan to stop using pci_ids.h - PCI IDs are supposed to go
> > into a driver-private header file.  I guess drivers/scsi/megaraid.h is an
> > example.
> 
> That's new to me.  In either case a single driver should do one thing
> consistantly, and fusion has tons of defines in pci_ids.h already.

Yeah, for older drivers that already do this, I don't have a problem
adding it here.  Then we can move all of the ids to the local file at
once in the future :)

thanks,

greg k-h
