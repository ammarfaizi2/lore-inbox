Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314077AbSEISXw>; Thu, 9 May 2002 14:23:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314078AbSEISXv>; Thu, 9 May 2002 14:23:51 -0400
Received: from chaos.physics.uiowa.edu ([128.255.34.189]:56967 "EHLO
	chaos.physics.uiowa.edu") by vger.kernel.org with ESMTP
	id <S314077AbSEISXu>; Thu, 9 May 2002 14:23:50 -0400
Date: Thu, 9 May 2002 13:23:30 -0500 (CDT)
From: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>
X-X-Sender: kai@chaos.physics.uiowa.edu
To: Patrick Mochel <mochel@osdl.org>
cc: Greg KH <greg@kroah.com>, Linus Torvalds <torvalds@transmeta.com>,
        James Bottomley <James.Bottomley@steeleye.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [BK PATCH] PCI reorg fix
In-Reply-To: <Pine.LNX.4.33.0205091058120.762-100000@segfault.osdl.org>
Message-ID: <Pine.LNX.4.44.0205091320260.11642-100000@chaos.physics.uiowa.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 9 May 2002, Patrick Mochel wrote:

> I would suggest something like:
> 
> void * 
> dev_alloc_consistent(struct device * dev, size_t size, dma_addr_t * dma_handle);
> 
> and moving dma_mask to struct device. 
> 
> To handle differences in arch-specific implementations, we could have a 
> callback that the generic code calls.
> 
> Implementing the generic code is ~5 minutes work. However, it will break 
> everything. OTOH, it would be the best motivation for modernizing these 
> drivers...

Certainly sounds reasonable. I'd guess it's trivial enough to provide
wrappers for pci_alloc_consistent(), pci_set_dma_mask() etc., so I don't 
see why everything would break?

--Kai

