Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264797AbRF1W3l>; Thu, 28 Jun 2001 18:29:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264791AbRF1W3b>; Thu, 28 Jun 2001 18:29:31 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:50961 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S264779AbRF1W3S>; Thu, 28 Jun 2001 18:29:18 -0400
Subject: Re: (reposting) how to get DMA'able memory within 4GB on 64-bit m achi ne
To: jes@sunsite.dk (Jes Sorensen)
Date: Thu, 28 Jun 2001 23:28:31 +0100 (BST)
Cc: davem@redhat.com (David S. Miller),
        hiren_mehta@agilent.com ("MEHTA,HIREN (A-SanJose,ex1)"),
        linux-kernel@vger.kernel.org ('linux-kernel@vger.kernel.org')
In-Reply-To: <d3u2109rho.fsf@lxplus015.cern.ch> from "Jes Sorensen" at Jun 29, 2001 12:20:03 AM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15FkH1-0007l5-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> The interface we use works well, so why should it be changed for other
> architecures? Instead it would make a lot more sense to support it on
> other architectures that can do 64 bit DMA.

The changes needed are small IMHO. The big problem wa the pci_dma_mask
not being pci_dma_mask_bit(foo) - a minor oversight we can fix in 2.5 without
breaking anything else.

It can even default to 32 for non DAC cards.

We will also have to address those cards that have 28/30/31 bit limits (yes
they exist) when we start doing direct I/O for 32bits of memory - one reason
I'm very wary of Jens patch ever being in 2.4


Alan

