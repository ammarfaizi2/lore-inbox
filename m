Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267635AbSLFWTX>; Fri, 6 Dec 2002 17:19:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267636AbSLFWTX>; Fri, 6 Dec 2002 17:19:23 -0500
Received: from host194.steeleye.com ([66.206.164.34]:13839 "EHLO
	pogo.mtv1.steeleye.com") by vger.kernel.org with ESMTP
	id <S267635AbSLFWTW>; Fri, 6 Dec 2002 17:19:22 -0500
Message-Id: <200212062226.gB6MQsr04565@localhost.localdomain>
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
To: "Adam J. Richter" <adam@yggdrasil.com>
cc: willy@debian.org, davem@redhat.com, James.Bottomley@SteelEye.com,
       linux-kernel@vger.kernel.org
Subject: Re: [RFC] generic device DMA implementation 
In-Reply-To: Message from "Adam J. Richter" <adam@yggdrasil.com> 
   of "Fri, 06 Dec 2002 14:17:21 PST." <200212062217.OAA07073@adam.yggdrasil.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Fri, 06 Dec 2002 16:26:54 -0600
From: James Bottomley <James.Bottomley@steeleye.com>
X-AntiVirus: scanned for viruses by AMaViS 0.2.1 (http://amavis.org/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

adam@yggdrasil.com said:
> 	This makes me lean infinitesmally more toward a parameter to
> dma_alloc rather than a separate dma_alloc_not_necessarily_consistent
> function, because if there ever are other dma_alloc variations that we
> want to support, it is more likely that there may be overlap between
> the users of those features and then the number of different function
> calls would have to grow exponentially (or we might then talk about
> changing the API again, which is not the end of the world, but is
> certainly more difficult than not having to do so). 

I think I like this.

how about dma_alloc to take two flags

DRIVER_SUPPORTS_CONSISTENT_ONLY

and

DRIVER_SUPPORTS_NON_CONSISTENT

The meaning of which are hopefully obvious this time

and dma_alloc_consistent to be equivalent to dma_alloc with  
DRIVER_SUPPORTS_CONSISTENT_ONLY (and hence equivalent to pci_alloc_consistent)

James


