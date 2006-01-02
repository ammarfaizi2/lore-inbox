Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750992AbWABTyP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750992AbWABTyP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Jan 2006 14:54:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750995AbWABTyP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Jan 2006 14:54:15 -0500
Received: from ns.suse.de ([195.135.220.2]:20685 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1750992AbWABTyO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Jan 2006 14:54:14 -0500
From: Andi Kleen <ak@suse.de>
To: Robert Hancock <hancockr@shaw.ca>
Subject: Re: X86_64 + VIA + 4g problems
Date: Mon, 2 Jan 2006 20:53:31 +0100
User-Agent: KMail/1.8.2
Cc: linux-kernel <linux-kernel@vger.kernel.org>
References: <5qvTv-8f-17@gated-at.bofh.it> <5qAKf-7n4-19@gated-at.bofh.it> <43B97C6D.7010902@shaw.ca>
In-Reply-To: <43B97C6D.7010902@shaw.ca>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200601022053.31534.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 02 January 2006 20:18, Robert Hancock wrote:
> Andi Kleen wrote:
> > When you not compile in the SKGE network driver does everything else work?
> > skge supports 64bit DMA, so it shouldn't use any IOMMU.
> 
> Are you sure this is skge? 

I grepped for the output in that badly truncated logfile and skge hit.

> Anyway, even if the driver does support  
> 64-bit DMA, I would be surprised if a desktop motherboard had the 
> Ethernet chip connected via a 64-bit PCI bus.

I meant 64bit DMA, aka double address cycle, not a 64bit wide PCI-X bus.
That works on a 32bit PCI bus too. On modern boards it's likely PCI
Express anyways for on board devices.

> 
> This brings up something I've been wondering. It's possible to run most 
> 64-bit capable PCI devices in a 32-bit slot (i.e. with the 64-bit part 
> hanging out of the slot). In this configuration the device will not be 
> able to use 64-bit DMA (unless it supports dual address cycle). However, 
> who is supposed to detect this and know to not try to use DMA addresses 
> above 4GB on that device? 

64bit PCI-X bus has nothing to do with the addressing capability. It
just gives you more bandwidth.

-Andi
