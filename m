Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263310AbSKMUaP>; Wed, 13 Nov 2002 15:30:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263326AbSKMUaP>; Wed, 13 Nov 2002 15:30:15 -0500
Received: from dsl2.external.hp.com ([192.25.206.7]:40719 "EHLO
	dsl2.external.hp.com") by vger.kernel.org with ESMTP
	id <S263310AbSKMUaN>; Wed, 13 Nov 2002 15:30:13 -0500
To: "J.E.J. Bottomley" <James.Bottomley@steeleye.com>
Cc: Miles Bader <miles@gnu.org>, Greg KH <greg@kroah.com>,
       Matthew Wilcox <willy@debian.org>,
       "Adam J. Richter" <adam@yggdrasil.com>, andmike@us.ibm.com, hch@lst.de,
       linux-kernel@vger.kernel.org, mochel@osdl.org,
       parisc-linux@lists.parisc-linux.org
Subject: Re: [parisc-linux] Untested port of parisc_device to generic device interface 
In-Reply-To: Message from "J.E.J. Bottomley" <James.Bottomley@steeleye.com> 
   of "Wed, 13 Nov 2002 15:21:07 EST." <200211132021.gADKL8r02349@localhost.localdomain> 
References: <200211132021.gADKL8r02349@localhost.localdomain> 
Date: Wed, 13 Nov 2002 13:37:09 -0700
From: Grant Grundler <grundler@dsl2.external.hp.com>
Message-Id: <20021113203709.2C61B4829@dsl2.external.hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"J.E.J. Bottomley" wrote:
> Actually, I think dma_mask and consistent memory are orthogonal problems.  

No. consistent memory needs to be reachable by the device as well.
dma_mask constrains which memory pci_alloc_consistent() can use.

> dma_masks are used by the I/O subsystem to determine whether direct DMA to a 
> memory region containing an I/O buffer is possible or whether it has to be 
> bounced.  Consistent memory is usually allocated for driver specific 
> transfers.  The I/O subsystem doesn't usually require the actual I/O buffers 
> to be in consistent memory.

right.

grant
