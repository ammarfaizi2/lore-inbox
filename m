Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264665AbUFXOme@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264665AbUFXOme (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Jun 2004 10:42:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264704AbUFXOmd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Jun 2004 10:42:33 -0400
Received: from hqemgate02.nvidia.com ([216.228.112.145]:34054 "EHLO
	hqemgate02.nvidia.com") by vger.kernel.org with ESMTP
	id S264665AbUFXOmb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Jun 2004 10:42:31 -0400
Date: Thu, 24 Jun 2004 09:39:27 -0500
From: Terence Ripperda <tripperda@nvidia.com>
To: Jesse Barnes <jbarnes@engr.sgi.com>
Cc: arjanv@redhat.com, Andi Kleen <ak@muc.de>,
       Terence Ripperda <tripperda@nvidia.com>, discuss@x86-64.org,
       tiwai@suse.de, linux-kernel@vger.kernel.org
Subject: Re: 32-bit dma allocations on 64-bit platforms
Message-ID: <20040624143927.GH983@hygelac>
Reply-To: Terence Ripperda <tripperda@nvidia.com>
References: <200406240948.07234.jbarnes@engr.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200406240948.07234.jbarnes@engr.sgi.com>
User-Agent: Mutt/1.4i
X-Accept-Language: en
X-Operating-System: Linux hrothgar 2.4.23 
X-OriginalArrivalTime: 24 Jun 2004 14:42:27.0738 (UTC) FILETIME=[788BE7A0:01C459F9]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


correct. I checked with my contacts here on the PCI express requirements.
Apparently the spec says "A PCI Express Endpoint operating as the
Requester of a Memory Transaction is required to be capable of
generating addresses greater than 4GB", but my contact claims this is a
"soft" requirement.

but even if all PCI-X and PCI-E devices properly addressed the full
64-bits, legacy 32-bit PCI devices can be plugged into the motherboards as
well. my Intel em64t boards have mostly PCI-X, but 1 PCI slot and my amd
x86_64 have all PCI slots (aside from the main PCI-E slot).

also, at least one motherboard manufacturer claims PCI-E + AGP, but the AGP
is really just an AGP form-factor slot on the PCI bus.

Thanks,
Terence

On Thu, Jun 24, 2004 at 06:48:07AM -0700, jbarnes@engr.sgi.com wrote:
> On Thursday, June 24, 2004 2:18 am, Arjan van de Ven wrote:
> > What is the problem again, can't the driver us the dynamic pci mapping
> > API which does allow more memory to be mapped even on crippled
> machines
> > without iommu ?
> > And isn't this a problem that will vanish since PCI Express and PCI X
> > both *require* support for 64 bit addressing, so all higher speed
> cards
> > are going to be ok in principle ?
> 
> Well, PCI-X may require it, but there certainly are PCI-X devices that
> don't 
> do 64 bit addressing, or if they do, it's a crippled implementation
> (e.g. top 
> 32 bits have to be constant).
> 
> Jesse
