Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131097AbRBIXdB>; Fri, 9 Feb 2001 18:33:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131118AbRBIXcv>; Fri, 9 Feb 2001 18:32:51 -0500
Received: from cs.columbia.edu ([128.59.16.20]:54159 "EHLO cs.columbia.edu")
	by vger.kernel.org with ESMTP id <S131097AbRBIXci>;
	Fri, 9 Feb 2001 18:32:38 -0500
Date: Fri, 9 Feb 2001 15:32:35 -0800 (PST)
From: Ion Badulescu <ionut@cs.columbia.edu>
To: Alan Cox <alan@redhat.com>
cc: Donald Becker <becker@scyld.com>, Jeff Garzik <jgarzik@mandrakesoft.com>,
        <linux-kernel@vger.kernel.org>, <jes@linuxcare.com>
Subject: Re: [PATCH] starfire reads irq before pci_enable_device.
In-Reply-To: <200102091049.f19Anjk06651@devserv.devel.redhat.com>
Message-ID: <Pine.LNX.4.30.0102091527380.31024-100000@age.cs.columbia.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 9 Feb 2001, Alan Cox wrote:

> > It's amusing that a full receive copy is added without any concern, in
> > the same discussion where zero-copy transmit is treated as a holy grail!
> 
> For non routing paths its virtually free because the DMA forced the lines
> from cache anyway. 

Are you actually sure about this? I thought DMA from PCI devices reached 
the main memory without polluting the L2 cache. Otherwise any large DMA 
transfer would kill the cache (think frame grabbers...)

Ion

-- 
  It is better to keep your mouth shut and be thought a fool,
            than to open it and remove all doubt.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
