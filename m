Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262838AbREVV1R>; Tue, 22 May 2001 17:27:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262839AbREVV1I>; Tue, 22 May 2001 17:27:08 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:50436 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S262838AbREVV04>; Tue, 22 May 2001 17:26:56 -0400
Subject: Re: alpha iommu fixes
To: jlundell@pobox.com (Jonathan Lundell)
Date: Tue, 22 May 2001 22:24:07 +0100 (BST)
Cc: rth@twiddle.net (Richard Henderson), andrea@suse.de (Andrea Arcangeli),
        ink@jurassic.park.msu.ru (Ivan Kokshaysky),
        linux-kernel@vger.kernel.org, davem@redhat.com (David S. Miller)
In-Reply-To: <p05100314b7308648117b@[207.213.214.37]> from "Jonathan Lundell" at May 22, 2001 02:17:21 PM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E152JdQ-0002VC-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On the main board, and not just the old ones. These days it's 
> typically in the chipset's south bridge. "Third-party DMA" is 
> sometimes called "fly-by DMA". The ISA card is a slave, as is memory, 
> and the DMA chip reads from one ands writes to the other.

There is also another mode which will give the Alpha kittens I suspect. A
few PCI cards do SB emulation by snooping the PCI bus. So the kernel writes
to the ISA DMA controller which does a pointless ISA transfer and the PCI
card sniffs the DMA controller setup (as it goes to pci, then when nobody 
claims it on to the isa bridge) then does bus mastering DMA of its own to fake
the ISA dma


Alan

