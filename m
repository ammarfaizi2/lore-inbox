Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131118AbRBIXgv>; Fri, 9 Feb 2001 18:36:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131170AbRBIXgc>; Fri, 9 Feb 2001 18:36:32 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:3591 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S131118AbRBIXgX>; Fri, 9 Feb 2001 18:36:23 -0500
Subject: Re: [PATCH] starfire reads irq before pci_enable_device.
To: ionut@cs.columbia.edu (Ion Badulescu)
Date: Fri, 9 Feb 2001 23:35:43 +0000 (GMT)
Cc: alan@redhat.com (Alan Cox), becker@scyld.com (Donald Becker),
        jgarzik@mandrakesoft.com (Jeff Garzik), linux-kernel@vger.kernel.org,
        jes@linuxcare.com
In-Reply-To: <Pine.LNX.4.30.0102091527380.31024-100000@age.cs.columbia.edu> from "Ion Badulescu" at Feb 09, 2001 03:32:35 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14RN4r-0008IY-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > For non routing paths its virtually free because the DMA forced the lines
> > from cache anyway. 
> 
> Are you actually sure about this? I thought DMA from PCI devices reached 
> the main memory without polluting the L2 cache. Otherwise any large DMA 
> transfer would kill the cache (think frame grabbers...)

DMA to main memory normally invalidates those lines in the CPU cache rather
than the cache snooping and updating its view of them.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
