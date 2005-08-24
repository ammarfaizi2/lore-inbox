Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751072AbVHXPcq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751072AbVHXPcq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Aug 2005 11:32:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751073AbVHXPcq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Aug 2005 11:32:46 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:37836 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S1751071AbVHXPcp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Aug 2005 11:32:45 -0400
Date: Wed, 24 Aug 2005 16:35:49 +0100
From: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>
To: Adrian Bunk <bunk@stusta.de>
Cc: torvalds@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] (11/43) Kconfig fix (infiniband and PCI)
Message-ID: <20050824153549.GJ9322@parcelfarce.linux.theplanet.co.uk>
References: <E1E7gaT-00079k-Ax@parcelfarce.linux.theplanet.co.uk> <20050824112655.GQ5603@stusta.de> <20050824145736.GI9322@parcelfarce.linux.theplanet.co.uk> <20050824152609.GB4851@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050824152609.GB4851@stusta.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 24, 2005 at 05:26:09PM +0200, Adrian Bunk wrote:
> As I said, on i386.

Builds due to stubs being still present, doesn't do anything since it
doesn't even try to look for any hardware in that case.

> > have PCI at all - same situation as with firewire.  Note that you won't
> > get any low-level drivers on PCI-less config even on i386, so while I
> > agree that more accurate dependency would be nice here (as well as for
> > drivers/ieee1394), for all practical purposes the same dependency works
> > here.
> > 
> > BTW, this is more general question - do we expect pci helpers to be present
> > on all platforms and do we consider their use acceptable in code that does
> > not depend on PCI?
> >...
> 
> Are you talking about the ones that already have dummy functions for the 
> PCI=n case in include/linux/pci.h, or about other functions?

pci_map.../pci_unmap..., for one thing.
