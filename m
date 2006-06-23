Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161005AbWFWBs7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161005AbWFWBs7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jun 2006 21:48:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932771AbWFWBs5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jun 2006 21:48:57 -0400
Received: from xenotime.net ([66.160.160.81]:62182 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S932767AbWFWBs4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jun 2006 21:48:56 -0400
Date: Thu, 22 Jun 2006 18:51:42 -0700
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: Jeff Garzik <jeff@garzik.org>
Cc: linux-kernel@vger.kernel.org, gregkh@suse.de, akpm@osdl.org,
       bcasavan@sgi.com
Subject: Re: [PATCH] PCI: Move various PCI IDs to header file
Message-Id: <20060622185142.c8bc1b16.rdunlap@xenotime.net>
In-Reply-To: <449B440B.7010407@garzik.org>
References: <200606222300.k5MN0uPW000741@hera.kernel.org>
	<449B440B.7010407@garzik.org>
Organization: YPO4
X-Mailer: Sylpheed version 2.2.5 (GTK+ 2.8.3; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 22 Jun 2006 21:29:47 -0400 Jeff Garzik wrote:

> Linux Kernel Mailing List wrote:
> > diff --git a/drivers/scsi/sata_vsc.c b/drivers/scsi/sata_vsc.c
> > index 8a29ce3..27d6587 100644
> > --- a/drivers/scsi/sata_vsc.c
> > +++ b/drivers/scsi/sata_vsc.c
> > @@ -433,13 +433,14 @@ err_out:
> >  
> >  
> >  /*
> > - * 0x1725/0x7174 is the Vitesse VSC-7174
> > - * 0x8086/0x3200 is the Intel 31244, which is supposed to be identical
> > - * compatibility is untested as of yet
> > + * Intel 31244 is supposed to be identical.
> > + * Compatibility is untested as of yet.
> >   */
> >  static const struct pci_device_id vsc_sata_pci_tbl[] = {
> > -	{ 0x1725, 0x7174, PCI_ANY_ID, PCI_ANY_ID, 0x10600, 0xFFFFFF, 0 },
> > -	{ 0x8086, 0x3200, PCI_ANY_ID, PCI_ANY_ID, 0x10600, 0xFFFFFF, 0 },
> > +	{ PCI_VENDOR_ID_VITESSE, PCI_DEVICE_ID_VITESSE_VSC7174,
> > +	  PCI_ANY_ID, PCI_ANY_ID, 0x10600, 0xFFFFFF, 0 },
> > +	{ PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_GD31244,
> > +	  PCI_ANY_ID, PCI_ANY_ID, 0x10600, 0xFFFFFF, 0 },
> >  	{ }
> >  };
> >  
> 
> WTF?  This is a REGRESSION from the repeatedly expressed desire -- clear 
> throughout libata -- that single-use PCI device IDs should not ever 
> receive PCI_DEVICE_ID_xxx constants.
> 
> I'm going to queue up a revert patch for this silliness.
> 
> Next time, please let the relevant maintainer(s) know when you are 
> touching their driver, so they have a chance to filter out the crap.
> 
> This was -never- sent to me or linux-ide, or otherwise brought to the 
> attention of the maintainers.

Well, if you could get IDE/ATA traffic moved to linux-ide
and networking traffic moved to netdev  and USB traffic
to linux-usb etc. etc. etc.,
I'd love it.  :)

lkml is like a "melting pot."

---
~Randy
