Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263571AbUAIU1Y (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jan 2004 15:27:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263609AbUAIU1Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jan 2004 15:27:24 -0500
Received: from colo.lackof.org ([198.49.126.79]:61600 "EHLO colo.lackof.org")
	by vger.kernel.org with ESMTP id S263571AbUAIU1U (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jan 2004 15:27:20 -0500
Date: Fri, 9 Jan 2004 13:27:18 -0700
From: Grant Grundler <grundler@parisc-linux.org>
To: Jochen Friedrich <jochen@scram.de>
Cc: Jesse Barnes <jbarnes@sgi.com>, linux-kernel@vger.kernel.org,
       jeremy@sgi.com, linux-pci@atrey.karlin.mff.cuni.cz,
       Jame.Bottomley@steeleye.com
Subject: Re: [RFC] Relaxed PIO read vs. DMA write ordering
Message-ID: <20040109202718.GB14165@colo.lackof.org>
References: <20040107175801.GA4642@sgi.com> <20040107190206.GK17182@parcelfarce.linux.theplanet.co.uk> <20040107222142.GB14951@colo.lackof.org> <20040107230712.GB6837@sgi.com> <20040108063829.GC22317@colo.lackof.org> <20040108173655.GA11168@sgi.com> <Pine.LNX.4.58.0401090833480.4454@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0401090833480.4454@localhost>
User-Agent: Mutt/1.3.28i
X-Home-Page: http://www.parisc-linux.org/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 09, 2004 at 08:39:28AM +0100, Jochen Friedrich wrote:
> And there are reasons for drivers still using the pci_* API. In tms380tr,
> i support both PCI and ISA cards. The pci_* API supports mapping ISA cards
> for bus master DMA by passing a NULL for pdev. The new API still fails
> because of the BUG_ON(dev->bus != &pci_bus_type).

I don't think that's a problem of API, rather the implementation.

>  Unfortunately, on 64 bit
> platforms like Alpha, the mapping is required to set up the IOMMU.

Not just alpha.
ia64, parisc, x86_64, sparc64, mips, (and a few others) also have IO MMUs.

grant
