Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261780AbULUQOj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261780AbULUQOj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Dec 2004 11:14:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261781AbULUQOj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Dec 2004 11:14:39 -0500
Received: from gate.crashing.org ([63.228.1.57]:27827 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S261780AbULUQOe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Dec 2004 11:14:34 -0500
Subject: Re: [PATCH] add PCI API to sysfs
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Matthew Wilcox <matthew@wil.cx>
Cc: Jesse Barnes <jbarnes@engr.sgi.com>, linux-pci@atrey.karlin.mff.cuni.cz,
       Greg KH <greg@kroah.com>,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       Bjorn Helgaas <bjorn.helgaas@hp.com>, willy@debian.org
In-Reply-To: <20041221123146.GA16109@parcelfarce.linux.theplanet.co.uk>
References: <200412201450.47952.jbarnes@engr.sgi.com>
	 <20041220225817.GA21404@kroah.com>
	 <200412201501.12575.jbarnes@engr.sgi.com>
	 <1103613121.21771.28.camel@gaston>
	 <20041221123146.GA16109@parcelfarce.linux.theplanet.co.uk>
Content-Type: text/plain
Date: Tue, 21 Dec 2004 17:13:58 +0100
Message-Id: <1103645638.28670.43.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-12-21 at 12:31 +0000, Matthew Wilcox wrote:
> On Tue, Dec 21, 2004 at 08:12:01AM +0100, Benjamin Herrenschmidt wrote:
> > treat all busses of a domain the same, but it leaves us with the
> > necessary flexibility for setups with bridges that can remap the legacy
> > space or that kind of thing.
> 
> Do any such bridges exist?  I've never heard of them.  io space accesses
> are implemented by the host bridge, so I think the most generic we need
> to support is one per host bridge, ie root bus.

I've seen PCI->ISA stuffs that could remap the legacy ISA memory space
at some random place, though don't ask me the details, I forgot.

Also, per-bus avoids the work of having to walk the tree up, etc... and
doesn't make thing more complicated for the sysfs code so ...

Ben


