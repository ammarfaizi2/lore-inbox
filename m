Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932538AbVHKXCJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932538AbVHKXCJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Aug 2005 19:02:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932468AbVHKXCJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Aug 2005 19:02:09 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:23463 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S932460AbVHKXCH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Aug 2005 19:02:07 -0400
Date: Thu, 11 Aug 2005 18:01:50 -0500
From: Jack Steiner <steiner@sgi.com>
To: Bjorn Helgaas <bjorn.helgaas@hp.com>
Cc: Jeff Garzik <jgarzik@pobox.com>, B.Zolnierkiewicz@elka.pw.edu.pl,
       linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org,
       linux-ia64@vger.kernel.org, Tony Luck <tony.luck@intel.com>
Subject: Re: [PATCH] IDE: don't offer IDE_GENERIC on ia64
Message-ID: <20050811230150.GB9964@sgi.com>
References: <200508111424.43150.bjorn.helgaas@hp.com> <200508111445.41428.bjorn.helgaas@hp.com> <42FBBB6F.1030306@pobox.com> <200508111542.07851.bjorn.helgaas@hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200508111542.07851.bjorn.helgaas@hp.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 11, 2005 at 03:42:07PM -0600, Bjorn Helgaas wrote:
> On Thursday 11 August 2005 2:56 pm, Jeff Garzik wrote:
> > Bjorn Helgaas wrote:
> > > On Thursday 11 August 2005 2:36 pm, Jeff Garzik wrote:
> > >>Bjorn Helgaas wrote:
> > >>> config IDE_GENERIC
> > >>> 	tristate "generic/default IDE chipset support"
> > >>>+	depends on !IA64
> > >>
> > >>hmmmmmmmmm.  Are you POSITIVE that the legacy IDE ports are never enabled?
> > >>
> > >>In modern Intel chipsets, this still occurs with e.g. combined mode.
> > > 
> > > I don't know about combined mode.  If the legacy IDE ports are
> > > enabled, shouldn't they be described via ACPI, and hence usable
> > > via the ide_pnp - PNPACPI - ACPI path?
> > 
> > No idea...  that's more for platform IA64 people to answer :/
> 
> OK, well, I assert that failure to describe an IDE device that
> uses legacy ports would be an ACPI defect.
> 
> Tony, others, does this change give you any heartburn?  On
> the 460GX and 870 boxes I have, IDE is a PCI device.
> 
> (I have been told that the SGI ia64 simulator depends on
> IDE_GENERIC.  But it really should make the IDE device
> appear in PCI (or describe it via ACPI)).

Yes - we use IDE_GENERIC for the simulator. ACPI at this point is not an option
for us because (unfortunately) SN is not ACPI compliant. We plan additional
ACPI support in the future but it will take a while to get there.

I'm checking to see if we have any short term alternatives. More later....


-- 
Thanks

Jack Steiner (steiner@sgi.com)          651-683-5302
Principal Engineer                      SGI - Silicon Graphics, Inc.


