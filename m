Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132988AbRDMAjM>; Thu, 12 Apr 2001 20:39:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132992AbRDMAjB>; Thu, 12 Apr 2001 20:39:01 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:5897 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S132988AbRDMAir>; Thu, 12 Apr 2001 20:38:47 -0400
Subject: Re: Proposal for a new PCI function call
To: jes@linuxcare.com (Jes Sorensen)
Date: Fri, 13 Apr 2001 01:40:25 +0100 (BST)
Cc: jgarzik@mandrakesoft.com (Jeff Garzik), modica@sgi.com,
        linux-kernel@vger.kernel.org
In-Reply-To: <d3vgo9ej5r.fsf@lxplus015.cern.ch> from "Jes Sorensen" at Apr 13, 2001 02:29:52 AM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14nrdT-0001po-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Hmmm, I was wondering if could come up with a pretty way to do this on
> 32 bit boxes that wants to enable highmem DMA. Right now
> pci_set_dma_mask() wants a dma_addr_t which means you have to do
> #ifdef CONFIG_HIGHMEM <blah> #else <bleh> #endif.
> 
> Introducing a new function that takes bit flags as arguments might be
> better?

pci_set_dma_mask_bits() ? So you could do

pci_set_dma_mask_bits(pdev, 64);

We want everything to go through pci_set_dma_mask... type functions either way
so that we can and the mask with upstream bridges when we hit address range 
limits in some peoples hardware

Alan

