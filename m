Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281489AbRLDRxK>; Tue, 4 Dec 2001 12:53:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280956AbRLDRvw>; Tue, 4 Dec 2001 12:51:52 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:18693 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S281042AbRLDRus>; Tue, 4 Dec 2001 12:50:48 -0500
Subject: Re: [Linux-ia64] patch to no longer use ia64's software mmu
To: davidm@hpl.hp.com
Date: Tue, 4 Dec 2001 17:59:28 +0000 (GMT)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), tony.luck@intel.com,
        arjanv@redhat.com (Arjan van de Ven), linux-kernel@vger.kernel.org,
        linux-ia64@linuxia64.org, marcelo@conectiva.com.br, davem@redhat.com
In-Reply-To: <15373.2854.619707.822462@napali.hpl.hp.com> from "David Mosberger" at Dec 04, 2001 09:43:02 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16BJqq-0002qu-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>   Alan> ISA DMA. While there is no ISA DMA on ia64 (thankfully) many
>   Alan> PCI cards have 26-31 bit limits.
> 
> We could do this if we there was a GFP_4GB zone.  Now that 2.5 is open
> for business, it won't be long, right?

I don't see the need: GFP_DMA is the ISA DMA zone. pci_* API is used by
everyone else [for 2.5]. You want a 32bit zone purely so you can fulfill
allocations in 32bit PCI space, and an ISA DMA zone for back compat and to
cover broken PCI cards (of which there are lots)

Alan
