Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265405AbUFXPC6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265405AbUFXPC6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Jun 2004 11:02:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265418AbUFXPC5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Jun 2004 11:02:57 -0400
Received: from cantor.suse.de ([195.135.220.2]:62093 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S265405AbUFXPBc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Jun 2004 11:01:32 -0400
Date: Thu, 24 Jun 2004 17:01:31 +0200
From: Andi Kleen <ak@suse.de>
To: Terence Ripperda <tripperda@nvidia.com>
Cc: Jesse Barnes <jbarnes@engr.sgi.com>, arjanv@redhat.com,
       Andi Kleen <ak@muc.de>, discuss@x86-64.org, tiwai@suse.de,
       linux-kernel@vger.kernel.org
Subject: Re: [discuss] Re: 32-bit dma allocations on 64-bit platforms
Message-ID: <20040624150131.GA8085@wotan.suse.de>
References: <200406240948.07234.jbarnes@engr.sgi.com> <20040624143927.GH983@hygelac>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040624143927.GH983@hygelac>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 24, 2004 at 09:39:27AM -0500, Terence Ripperda wrote:
> but even if all PCI-X and PCI-E devices properly addressed the full
> 64-bits, legacy 32-bit PCI devices can be plugged into the motherboards as
> well. my Intel em64t boards have mostly PCI-X, but 1 PCI slot and my amd
> x86_64 have all PCI slots (aside from the main PCI-E slot).

For the older AGP devices you can always map the data through the AGP
aperture, no ? (It also has a size limit, but that can be usually
increased in the BIOS setup) 

This won't work for graphic cards put into PCI slots, but these
can probably tolerate some performance degradation.

For AMD all PCI IO can be done through the aperture anyways, only
Intel is more crippled in this regard.

> also, at least one motherboard manufacturer claims PCI-E + AGP, but the AGP
> is really just an AGP form-factor slot on the PCI bus.

With no aperture I guess? 

-Andi

