Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270848AbTHLQyU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Aug 2003 12:54:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270987AbTHLQyU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Aug 2003 12:54:20 -0400
Received: from smtp-node1.eclipse.net.uk ([212.104.129.76]:35591 "EHLO
	smtp1.ex.eclipse.net.uk") by vger.kernel.org with ESMTP
	id S270848AbTHLQyS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Aug 2003 12:54:18 -0400
From: Ian Hastie <ianh@iahastie.clara.net>
To: Matthew Wilcox <willy@debian.org>, Greg KH <greg@kroah.com>
Subject: Re: C99 Initialisers
Date: Tue, 12 Aug 2003 17:54:14 +0100
User-Agent: KMail/1.5.3
Cc: Matthew Wilcox <willy@debian.org>, Robert Love <rml@tech9.net>,
       CaT <cat@zip.com.au>, linux-kernel@vger.kernel.org,
       kernel-janitor-discuss@lists.sourceforge.net
References: <20030812020226.GA4688@zip.com.au> <20030812053826.GA1488@kroah.com> <20030812112729.GF3169@parcelfarce.linux.theplanet.co.uk>
In-Reply-To: <20030812112729.GF3169@parcelfarce.linux.theplanet.co.uk>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200308121754.16216.ianh@iahastie.local.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 12 Aug 2003 12:27, Matthew Wilcox wrote:
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

Which is OK for those very familiar with the code, but not so good for anyone 
else.

> It's also not subject to change, unlike say file_operations, so the
> argument of adding new elements without breaking anything is also not
> relevant.

Even if it is not subject to change, which can never be a total certainty, it 
will need to be applied in new code.  The greater clarity provided by the 
C-99 format will make it easier to ensure the appropriate values are put into 
the right fields.

> In tg3, the table definition is already 32 lines long with 2 lines per
> device_id.  In the scheme you favour so much, that becomes 92 lines, for
> no real gain that I can see.

Smaller source code is not everything.  A consistant style is also very 
important.

-- 
Ian.

