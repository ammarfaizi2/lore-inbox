Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270519AbTHLQwY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Aug 2003 12:52:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270818AbTHLQwY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Aug 2003 12:52:24 -0400
Received: from fmr06.intel.com ([134.134.136.7]:58603 "EHLO
	caduceus.jf.intel.com") by vger.kernel.org with ESMTP
	id S270519AbTHLQwV convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Aug 2003 12:52:21 -0400
Content-Class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
X-MimeOLE: Produced By Microsoft Exchange V6.0.6375.0
Subject: RE: C99 Initialisers
Date: Tue, 12 Aug 2003 09:52:17 -0700
Message-ID: <032EB457B9DBC540BFB1B7B519C78B0E0165FCE7@orsmsx404.jf.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: C99 Initialisers
Thread-Index: AcNgxThWYjpEqN2TRSSFkR0wJDLVLAALG5Rg
From: "Shureih, Tariq" <tariq.shureih@intel.com>
To: "Matthew Wilcox" <willy@debian.org>, "Greg KH" <greg@kroah.com>
Cc: "Robert Love" <rml@tech9.net>, "CaT" <cat@zip.com.au>,
       <linux-kernel@vger.kernel.org>,
       <kernel-janitor-discuss@lists.sourceforge.net>
X-OriginalArrivalTime: 12 Aug 2003 16:52:18.0243 (UTC) FILETIME=[1719E130:01C360F2]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I personally see a difference and an advantage in making it easier to
read therefore easier to manage and maintain.

Sure it's a whole conversion process and may be a bit shocking to
existing drivers and people used to the struct in this format, but
that's nothing new to the kernel to yank something we're all so used to
and replace it with something that we would all benefit from in the long
term.


--
Tariq Shureih
 

*Opinions are my own and don't reflect those of my employer*
*But my two cents and what's left of my stock options :P*

> -----Original Message-----
> From: Matthew Wilcox [mailto:willy@debian.org]
> Sent: Tuesday, August 12, 2003 4:27 AM
> To: Greg KH
> Cc: Matthew Wilcox; Robert Love; CaT; linux-kernel@vger.kernel.org;
> kernel-janitor-discuss@lists.sourceforge.net
> Subject: Re: C99 Initialisers
> 
> On Mon, Aug 11, 2003 at 10:38:27PM -0700, Greg KH wrote:
> > On Tue, Aug 12, 2003 at 03:39:36AM +0100, Matthew Wilcox wrote:
> > > I don't think anyone would appreciate you converting that to:
> > >
> > > static struct pci_device_id tg3_pci_tbl[] __devinitdata = {
> > > 	{
> > > 		.vendor		= PCI_VENDOR_ID_BROADCOM,
> > > 		.device		= PCI_DEVICE_ID_TIGON3_5700,
> > > 		.subvendor	= PCI_ANY_ID,
> > > 		.subdevice	= PCI_ANY_ID,
> > > 		.class		= 0,
> > > 		.class_mask	= 0,
> > > 		.driver_data	= 0,
> > > 	},
> >
> > I sure would.  Oh, you can drop the .class, .class_mask, and
> > .driver_data lines, and then it even looks cleaner.
> >
> > I would love to see that kind of change made for pci drivers.
> 
> I really strongly disagree.  For a struct that's as well-known as
> pci_device_id, the argument of making it clearer doesn't make sense.
> It's also not subject to change, unlike say file_operations, so the
> argument of adding new elements without breaking anything is also not
> relevant.
> 
> In tg3, the table definition is already 32 lines long with 2 lines per
> device_id.  In the scheme you favour so much, that becomes 92 lines,
for
> no real gain that I can see.
> 
> --
> "It's not Hollywood.  War is real, war is primarily not about defeat
or
> victory, it is about death.  I've seen thousands and thousands of dead
> bodies.
> Do you think I want to have an academic debate on this subject?" --
Robert
> Fisk
> -
> To unsubscribe from this list: send the line "unsubscribe
linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
