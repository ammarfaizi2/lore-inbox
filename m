Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261232AbVCKR7s@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261232AbVCKR7s (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Mar 2005 12:59:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261222AbVCKR7s
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Mar 2005 12:59:48 -0500
Received: from atlrel6.hp.com ([156.153.255.205]:54201 "EHLO atlrel6.hp.com")
	by vger.kernel.org with ESMTP id S261232AbVCKR7p (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Mar 2005 12:59:45 -0500
Subject: Re: AGP bogosities
From: Bjorn Helgaas <bjorn.helgaas@hp.com>
To: Jesse Barnes <jbarnes@engr.sgi.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Paul Mackerras <paulus@samba.org>, werner@sgi.com,
       Linus Torvalds <torvalds@osdl.org>, davej@redhat.com,
       Linux Kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <200503110839.15995.jbarnes@engr.sgi.com>
References: <16944.62310.967444.786526@cargo.ozlabs.ibm.com>
	 <200503102002.47645.jbarnes@engr.sgi.com>
	 <1110515459.32556.346.camel@gaston>
	 <200503110839.15995.jbarnes@engr.sgi.com>
Content-Type: text/plain
Date: Fri, 11 Mar 2005 10:59:25 -0700
Message-Id: <1110563965.4822.22.camel@eeyore>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-03-11 at 08:39 -0800, Jesse Barnes wrote:
> On Thursday, March 10, 2005 8:30 pm, Benjamin Herrenschmidt wrote:
> > On Thu, 2005-03-10 at 20:02 -0800, Jesse Barnes wrote:
> > > On Thursday, March 10, 2005 6:38 pm, Benjamin Herrenschmidt wrote:
> > > > That one is even worse... from what I see in your lspci output, you
> > > > have no bridge with AGP capability at all, and the various AGP devices
> > > > are all siblings...
> > >
> > > Both of the video cards are sitting on agp busses in agp slots hooked up
> > > to host to agp bridges.
> > >
> > > > Are you sure there is any real AGP slot in there ?
> > >
> > > Yes :)
> >
> > Well, according to your lspci, none of the bridges exposes a device with
> > AGP capabilities...
> 
> There are no bridges listed in my lspci output, that's probably why. :)

HP ia64 and parisc boxes are similar.  The host bridges do not appear
as PCI devices.  We discover them via ACPI on ia64 and PDC on parisc.

> > It looks like you aren't exposing the host "self" 
> > device on the bus. Do you have an AGP driver ? If yes, it certainly
> > can't use any of the generic code anyway ...
> 
> Right, it's a special agp driver, sgi-agp.c.

Where's sgi-agp.c?  The HP (ia64-only at the moment) code is hp-agp.c.
It does make a fake PCI dev for the bridge because DRM still seemed to
want that.

