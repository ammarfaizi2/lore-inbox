Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266377AbRGFLM5>; Fri, 6 Jul 2001 07:12:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266384AbRGFLMs>; Fri, 6 Jul 2001 07:12:48 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:27921 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S266377AbRGFLMf>; Fri, 6 Jul 2001 07:12:35 -0400
Subject: Re: DMA memory limitation?
To: sp@scali.no (Steffen Persvold)
Date: Fri, 6 Jul 2001 12:08:51 +0100 (BST)
Cc: helgehaf@idb.hist.no (Helge Hafting),
        pvvvarma@techmas.hcltech.com (Vasu Varma P V),
        linux-kernel@vger.kernel.org
In-Reply-To: <3B458888.75C50552@scali.no> from "Steffen Persvold" at Jul 06, 2001 11:44:40 AM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15ITTf-0004Dz-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> A problem arises on 64 bit platforms (such as IA64) if your PCI card is only 32bit (can
> address the first 4G) and you don't wan't to use bounce buffers. If you use GFP_DMA on

GFP_DMA is ISA dma reachable, Forget the IA64, their setup is weird and 
should best be ignored until 2.5 as and when they sort it out.

> bounce buffers are needed. On Alpha GFP_DMA is not limited at all (I think). Correct me if

Alpha has various IOMMU facilities

> I'm wrong, but I really think there should be a general way of allocating memory that is
> 32bit addressable (something like GFP_32BIT?) so you don't need a lot of #ifdef's in your
> code.

No ifdefs are needed

	GFP_DMA - ISA dma reachable
	pci_alloc_* and friends - PCI usable memory


