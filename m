Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751781AbWKBNEV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751781AbWKBNEV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Nov 2006 08:04:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752594AbWKBNEV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Nov 2006 08:04:21 -0500
Received: from pollux.ds.pg.gda.pl ([153.19.208.7]:30212 "EHLO
	pollux.ds.pg.gda.pl") by vger.kernel.org with ESMTP
	id S1752553AbWKBNEU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Nov 2006 08:04:20 -0500
Date: Thu, 2 Nov 2006 13:04:12 +0000 (GMT)
From: "Maciej W. Rozycki" <macro@linux-mips.org>
To: Matthew Wilcox <matthew@wil.cx>
cc: Randy Dunlap <randy.dunlap@oracle.com>, Jun Sun <jsun@junsun.net>,
       linux-scsi@vger.kernel.org, lkml <linux-kernel@vger.kernel.org>
Subject: Re: unchecked_isa_dma and BusLogic SCSI controller
In-Reply-To: <20061102124128.GC31830@parisc-linux.org>
Message-ID: <Pine.LNX.4.64N.0611021302340.7700@blysk.ds.pg.gda.pl>
References: <20061101235330.GA30843@srv.junsun.net>
 <20061101173358.7b027d13.randy.dunlap@oracle.com> <20061102124128.GC31830@parisc-linux.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2 Nov 2006, Matthew Wilcox wrote:

> > > It is hard for me to see why BusLogic controller would only do DMA
> > > in low 16MB.  Is there a fix for this?
> > 
> > Does anyone know that controller hardware and its limitations?
> 
> I don't, but:
> 
> 		if (pci_set_dma_mask(PCI_Device, DMA_32BIT_MASK ))
> 			continue;
> 
> So somebody thinks the device can do 32-bit addressing.  I would expect
> that setting unchecked_isa_dma is a historical mistake.  However, I
> don't have any cards of this type to test.

 It could be related to the non-PCI variations of the board.

  Maciej
