Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129480AbQLRMiT>; Mon, 18 Dec 2000 07:38:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129581AbQLRMiJ>; Mon, 18 Dec 2000 07:38:09 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:28947 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S129480AbQLRMh4>; Mon, 18 Dec 2000 07:37:56 -0500
Subject: Re: reg memory allocated by kmalloc
To: mohammedazad@nestec.net (MOHAMMED AZAD)
Date: Mon, 18 Dec 2000 12:09:09 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org ("Linux-Kernel (E-mail)")
In-Reply-To: <F6E1228667B6D411BAAA00306E00F2A548461A@pdc2.nestec.net> from "MOHAMMED AZAD" at Dec 18, 2000 02:16:34 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E147z6O-0005Tf-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I would like to know.. is memory allocated by kmalloc always double word
> aligned????.. and is this suitable for dma only if i use GFP_DMA priority...
> i mean dma for a pci device... or can i just specify GFP_KERNEL and use
> it.... is it safe to proceed in this way???

The alignment should be fine yes. GFP_DMA is for ISA bus 24bit DMA, 
GFP_KERNEL is 32bit so if your PCI card has true 32bit DMA it will do. 2.4
has the pci_alloc_* interface

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
