Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264938AbSLFSVm>; Fri, 6 Dec 2002 13:21:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264945AbSLFSVm>; Fri, 6 Dec 2002 13:21:42 -0500
Received: from host194.steeleye.com ([66.206.164.34]:9485 "EHLO
	pogo.mtv1.steeleye.com") by vger.kernel.org with ESMTP
	id <S264938AbSLFSVl>; Fri, 6 Dec 2002 13:21:41 -0500
Message-Id: <200212061829.gB6ITAt03038@localhost.localdomain>
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
To: "David S. Miller" <davem@redhat.com>
cc: adam@yggdrasil.com, James.Bottomley@SteelEye.com,
       linux-kernel@vger.kernel.org, willy@debian.org
Subject: Re: [RFC] generic device DMA implementation 
In-Reply-To: Message from "David S. Miller" <davem@redhat.com> 
   of "Fri, 06 Dec 2002 10:17:15 PST." <20021206.101715.113691767.davem@redhat.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Fri, 06 Dec 2002 12:29:10 -0600
From: James Bottomley <James.Bottomley@steeleye.com>
X-AntiVirus: scanned for viruses by AMaViS 0.2.1 (http://amavis.org/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

davem@redhat.com said:
> Specifically, it took years to get most developers confortable with
> pci_alloc_consitent() and friends.  I totally fear that asking them to
> now add cache flushing stuff to their drivers takes the complexity way
> over the edge. 

I have no plans ever to do that.  It's only a tiny minority of drivers that 
should ever need to know the awful guts of cache flushing, and such drivers 
are already implementing the cache flushes now.

How about (as Adam suggested) two dma allocation API's

1) dma_alloc_consistent which behaves identically to pci_alloc_consistent
2) dma_alloc which can take the conformance flag and can be used to tidy up 
the drivers that need to know about cache flushing.

James


