Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282906AbRLDSOM>; Tue, 4 Dec 2001 13:14:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281156AbRLDSMn>; Tue, 4 Dec 2001 13:12:43 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:31749 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S282404AbRLDSLR>; Tue, 4 Dec 2001 13:11:17 -0500
Subject: Re: [Linux-ia64] patch to no longer use ia64's software mmu
To: davidm@hpl.hp.com
Date: Tue, 4 Dec 2001 18:19:55 +0000 (GMT)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), tony.luck@intel.com,
        arjanv@redhat.com (Arjan van de Ven), linux-kernel@vger.kernel.org,
        linux-ia64@linuxia64.org, marcelo@conectiva.com.br, davem@redhat.com
In-Reply-To: <15373.4236.462183.167170@napali.hpl.hp.com> from "David Mosberger" at Dec 04, 2001 10:06:04 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16BKAe-0002x7-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>   Alan> I don't see the need: GFP_DMA is the ISA DMA zone. pci_* API
>   Alan> is used by everyone else [for 2.5].
> 
> Without a 4GB zone, you may end up creating bounce buffers needlessly
> for 32-bit capable DMA devices, no?

Yes - but it becomes an implementation detail. Drivers don't go around
asking for kmalloc in 4Gb zone anymore they ask for PCI memory that a 32bit
pci address can hit. I'm sure a 4Gb zone is what will be there internally
but you don't need GFP_4GBZONE as a visible driver detail.

Alan


