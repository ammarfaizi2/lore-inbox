Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266154AbRGGMV4>; Sat, 7 Jul 2001 08:21:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263930AbRGGMVq>; Sat, 7 Jul 2001 08:21:46 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:5386 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S266151AbRGGMVg>; Sat, 7 Jul 2001 08:21:36 -0400
Subject: Re: (reposting) how to get DMA'able memory within 4GB on 64-bit m
To: jgarzik@mandrakesoft.com (Jeff Garzik)
Date: Sat, 7 Jul 2001 13:21:25 +0100 (BST)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), davem@redhat.com (David S. Miller),
        bcrl@redhat.com (Ben LaHaise), jes@sunsite.dk (Jes Sorensen),
        hiren_mehta@agilent.com ("MEHTA,HIREN (A-SanJose,ex1)"),
        linux-kernel@vger.kernel.org ('linux-kernel@vger.kernel.org')
In-Reply-To: <3B46FDF1.A38E5BB6@mandrakesoft.com> from "Jeff Garzik" at Jul 07, 2001 08:17:53 AM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15Ir5R-0005lR-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > So add another seven or eight years to your estimate
> 
> Given a little more context, I thought we were talking specifically
> about 64bit-PCI-on-32bit-machines?
> 
> Assuming that, AFAICS Ben's statement seems more correct.
> 
> And IMHO we definitely should not optimize for 64-bit-on-32-bit case. 
> Let CONFIG_HIGHMEM grow dma_addr_t to 64-bits, for that case only...

I see no good way to optimise for 64bit dma on a 32bit box. The existing API
is extremely clean, easy to understand and I don't agree with Dave's desire
to write another whole concoction.

We do need pci_set_dma_mask_bits(), which in itself lets drivers indicate
SAC/DAC capable. We do want a way for nosey or fine tuned drivers to query
SAC/DAC properties, but most drivers should be letting arch code make arch
policy. 

Alan

