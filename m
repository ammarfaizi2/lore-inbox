Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286821AbSBKC6z>; Sun, 10 Feb 2002 21:58:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286825AbSBKC6p>; Sun, 10 Feb 2002 21:58:45 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:49417 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S286821AbSBKC6b>; Sun, 10 Feb 2002 21:58:31 -0500
Subject: Re: pci_pool reap?
To: zaitcev@redhat.com (Pete Zaitcev)
Date: Mon, 11 Feb 2002 03:12:06 +0000 (GMT)
Cc: stodden@in.tum.de, linux-kernel@vger.kernel.org (Linux Kernel)
In-Reply-To: <200202110249.g1B2nfx27479@devserv.devel.redhat.com> from "Pete Zaitcev" at Feb 10, 2002 09:49:41 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16a6sw-0005Jw-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> There is a certain controversy about pci_free_consistent called
> from an interrupt. It seems that most architectures would
> have no problems, and only arm is problematic. RMK says that

The discussion was about pci_alloc_consistent. The free case seems to be
explicitly disallowed in all cases.

(from DMA-mapping.txt)

To unmap and free such a DMA region, you call:

        pci_free_consistent(dev, size, cpu_addr, dma_handle);

where dev, size are the same as in the above call and cpu_addr and
dma_handle are the values pci_alloc_consistent returned to you.
This function may not be called in interrupt context.
