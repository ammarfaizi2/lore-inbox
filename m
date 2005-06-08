Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261213AbVFHNfS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261213AbVFHNfS (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Jun 2005 09:35:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261215AbVFHNfR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Jun 2005 09:35:17 -0400
Received: from cantor.suse.de ([195.135.220.2]:17614 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S261213AbVFHNfE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Jun 2005 09:35:04 -0400
Date: Wed, 8 Jun 2005 15:35:03 +0200
From: Andi Kleen <ak@suse.de>
To: Andrew Grover <andy.grover@gmail.com>
Cc: Jeff Garzik <jgarzik@pobox.com>, Greg KH <gregkh@suse.de>,
       "David S. Miller" <davem@davemloft.net>, tom.l.nguyen@intel.com,
       roland@topspin.com, linux-pci@atrey.karlin.mff.cuni.cz,
       linux-kernel@vger.kernel.org, ak@suse.de
Subject: Re: [RFC PATCH] PCI: remove access to pci_[enable|disable]_msi() for drivers - take 2
Message-ID: <20050608133503.GT23831@wotan.suse.de>
References: <20050607002045.GA12849@suse.de> <20050607202129.GB18039@kroah.com> <42A61CDE.6090906@pobox.com> <c0a09e5c05060722558a86ac8@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c0a09e5c05060722558a86ac8@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 07, 2005 at 10:55:27PM -0700, Andrew Grover wrote:
> On 6/7/05, Jeff Garzik <jgarzik@pobox.com> wrote:
> > If the driver has to _undo_ something that it did not do, that's pretty
> > lame.  Non-orthogonal.
> 
> I would think the number of MSI and MSI-X capable devices is going to
> explode over the next five years. I'm not sure it's right to make all
> these device's drivers pay a complexity cost because some of the first
> attempted MSI implementations were buggy.

Exactly. Couldnt agree more.
> 
> > Also, it looks like all the PCI MSI drivers need touching for this
> > scheme -- which defeats the original intention.  At this rate, the best
> > API is the one we've already got.
> 
> For now...but I'm bringing this up again in five years!! *sets egg timer*

I think we should have the right (default MSI) API by default.
If we wait 5 years we end up with lots of mess in the drivers.

-Andi
