Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132731AbRDMAaU>; Thu, 12 Apr 2001 20:30:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132741AbRDMAaK>; Thu, 12 Apr 2001 20:30:10 -0400
Received: from smtp1.cern.ch ([137.138.128.38]:46087 "EHLO smtp1.cern.ch")
	by vger.kernel.org with ESMTP id <S132731AbRDMAaC>;
	Thu, 12 Apr 2001 20:30:02 -0400
To: Jeff Garzik <jgarzik@mandrakesoft.com>
Cc: modica@sgi.com, linux-kernel@vger.kernel.org
Subject: Re: Proposal for a new PCI function call
In-Reply-To: <3AD601B4.7E0B14E4@sgi.com> <3AD604B0.2713F08B@mandrakesoft.com>
From: Jes Sorensen <jes@linuxcare.com>
Date: 13 Apr 2001 02:29:52 +0200
In-Reply-To: Jeff Garzik's message of "Thu, 12 Apr 2001 15:40:32 -0400"
Message-ID: <d3vgo9ej5r.fsf@lxplus015.cern.ch>
User-Agent: Gnus/5.070096 (Pterodactyl Gnus v0.96) Emacs/20.4
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Jeff" == Jeff Garzik <jgarzik@mandrakesoft.com> writes:

>> I think the function idea would let us do some sanity checking to
>> make sure drivers weren't setting this to 64bit on non-64 bit
>> busses and stuff.

Jeff> pci_set_dma_mask.  Modify that to do the additional checks you
Jeff> need.

Jeff> Nobody should be setting dma_mask directly anymore, it should be
Jeff> done through this function.

Hmmm, I was wondering if could come up with a pretty way to do this on
32 bit boxes that wants to enable highmem DMA. Right now
pci_set_dma_mask() wants a dma_addr_t which means you have to do
#ifdef CONFIG_HIGHMEM <blah> #else <bleh> #endif.

Introducing a new function that takes bit flags as arguments might be
better?

Jes
