Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262645AbTFGHHR (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Jun 2003 03:07:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262656AbTFGHHQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Jun 2003 03:07:16 -0400
Received: from palrel12.hp.com ([156.153.255.237]:64226 "EHLO palrel12.hp.com")
	by vger.kernel.org with ESMTP id S262645AbTFGHHN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Jun 2003 03:07:13 -0400
From: David Mosberger <davidm@napali.hpl.hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16097.37454.827982.278024@napali.hpl.hp.com>
Date: Sat, 7 Jun 2003 00:20:46 -0700
To: "David S. Miller" <davem@redhat.com>
Cc: davidm@hpl.hp.com, manfred@colorfullife.com, axboe@suse.de,
       linux-kernel@vger.kernel.org
Subject: Re: problem with blk_queue_bounce_limit()
In-Reply-To: <20030606.234401.104035537.davem@redhat.com>
References: <16096.16492.286361.509747@napali.hpl.hp.com>
	<20030606.003230.15263591.davem@redhat.com>
	<200306062013.h56KDcLe026713@napali.hpl.hp.com>
	<20030606.234401.104035537.davem@redhat.com>
X-Mailer: VM 7.07 under Emacs 21.2.1
Reply-To: davidm@hpl.hp.com
X-URL: http://www.hpl.hp.com/personal/David_Mosberger/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> On Fri, 06 Jun 2003 23:44:01 -0700 (PDT), "David S. Miller" <davem@redhat.com> said:

  DaveM>    This sounds all very dramatic, but try as I might, all I
  DaveM> find is three places where PCI_DMA_BUS_IS_PHYS is used:

  DaveM> Fix your grep,

What am I missing?

	--david

$ find . -type f | xargs fgrep PCI_DMA_BUS_IS_PHYS | fgrep -v /SCCS/
./drivers/ide/ide-lib.c:                if (!PCI_DMA_BUS_IS_PHYS)
./drivers/net/tg3.c:#ifndef PCI_DMA_BUS_IS_PHYS
./drivers/net/tg3.c:#define PCI_DMA_BUS_IS_PHYS 1
./drivers/net/tg3.c:#if !PCI_DMA_BUS_IS_PHYS
./drivers/net/tg3.c:#if !PCI_DMA_BUS_IS_PHYS
./drivers/scsi/scsi_lib.c:              if (PCI_DMA_BUS_IS_PHYS && host_dev && host_dev->dma_mask)
./include/asm-alpha/pci.h:#define PCI_DMA_BUS_IS_PHYS  0
./include/asm-arm/pci.h:#define PCI_DMA_BUS_IS_PHYS     (0)
./include/asm-i386/pci.h:#define PCI_DMA_BUS_IS_PHYS    (1)
./include/asm-ia64/pci.h: * PCI_DMA_BUS_IS_PHYS should be set to 1 if there is necessarily a direct corespondence
./include/asm-ia64/pci.h:#define PCI_DMA_BUS_IS_PHYS    pci_dma_bus_is_phys
./include/asm-m68k/pci.h:#define PCI_DMA_BUS_IS_PHYS    (1)
./include/asm-parisc/pci.h:#define PCI_DMA_BUS_IS_PHYS     (1)
./include/asm-ppc/pci.h:#define PCI_DMA_BUS_IS_PHYS     (1)
./include/asm-ppc64/pci.h:#define PCI_DMA_BUS_IS_PHYS   (0)
./include/asm-s390/pci.h:#define PCI_DMA_BUS_IS_PHYS (1)
./include/asm-sparc/pci.h:#define PCI_DMA_BUS_IS_PHYS   (0)
./include/asm-sparc64/pci.h:#define PCI_DMA_BUS_IS_PHYS (0)
./include/asm-um/pci.h:#define PCI_DMA_BUS_IS_PHYS     (1)
./include/asm-x86_64/pci.h:#define PCI_DMA_BUS_IS_PHYS  (0)
./include/asm-x86_64/pci.h:#define PCI_DMA_BUS_IS_PHYS  1
