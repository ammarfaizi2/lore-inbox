Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267148AbSKMI6u>; Wed, 13 Nov 2002 03:58:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267149AbSKMI6t>; Wed, 13 Nov 2002 03:58:49 -0500
Received: from TYO202.gate.nec.co.jp ([210.143.35.52]:57545 "EHLO
	TYO202.gate.nec.co.jp") by vger.kernel.org with ESMTP
	id <S267148AbSKMI6t>; Wed, 13 Nov 2002 03:58:49 -0500
To: Greg KH <greg@kroah.com>
Cc: "J.E.J. Bottomley" <James.Bottomley@steeleye.com>,
       Matthew Wilcox <willy@debian.org>,
       "Adam J. Richter" <adam@yggdrasil.com>, andmike@us.ibm.com, hch@lst.de,
       linux-kernel@vger.kernel.org, mochel@osdl.org,
       parisc-linux@lists.parisc-linux.org
Subject: Re: [parisc-linux] Untested port of parisc_device to generic device interface
References: <20021109060342.GA7798@kroah.com>
	<200211091533.gA9FXuW02017@localhost.localdomain>
	<20021113061310.GD2106@kroah.com>
	<buon0odsyh9.fsf@mcspd15.ucom.lsi.nec.co.jp>
	<20021113075223.GZ2106@kroah.com>
	<buoisz1sxr4.fsf@mcspd15.ucom.lsi.nec.co.jp>
	<20021113081008.GC2106@kroah.com>
	<buoadkdswn9.fsf@mcspd15.ucom.lsi.nec.co.jp>
	<20021113082510.GA3064@kroah.com>
Reply-To: Miles Bader <miles@gnu.org>
System-Type: i686-pc-linux-gnu
Blat: Foop
From: Miles Bader <miles@lsi.nec.co.jp>
Date: 13 Nov 2002 18:05:26 +0900
In-Reply-To: <20021113082510.GA3064@kroah.com>
Message-ID: <buo65v1suuh.fsf@mcspd15.ucom.lsi.nec.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH <greg@kroah.com> writes:
> > Currently, it ignores the pci_dev argument entirely (I've never had a
> > device that needed the mask, so I haven't bothered with it).  It just
> > allocates a block from the special memory region and returns the result.
> 
> So merely renaming that function to dev_alloc_consistent(), changing the
> first paramater to be a struct device, and proving a macro for all of
> the pci drivers for the old pci_alloc_consistent() name would work just
> fine for you?

Except that this function doesn't make any sense except for PCI devices.

I don't know whether there will ever be any devices that (1) call
`dev_alloc_consistent', (2) aren't PCI devices, and (3) would stand a
chance of ever working on this platform -- probably not.

Never-the-less, it provides (a non-artificial) example of a case where
it's wrong to assume that all busses are the same, and I think that
merits some attention.

-Miles
-- 
97% of everything is grunge
