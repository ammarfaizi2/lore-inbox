Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267650AbSLFWtM>; Fri, 6 Dec 2002 17:49:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267654AbSLFWtM>; Fri, 6 Dec 2002 17:49:12 -0500
Received: from h-64-105-35-8.SNVACAID.covad.net ([64.105.35.8]:52880 "EHLO
	freya.yggdrasil.com") by vger.kernel.org with ESMTP
	id <S267650AbSLFWtL>; Fri, 6 Dec 2002 17:49:11 -0500
From: "Adam J. Richter" <adam@yggdrasil.com>
Date: Fri, 6 Dec 2002 14:52:21 -0800
Message-Id: <200212062252.OAA07111@adam.yggdrasil.com>
To: James.Bottomley@steeleye.com
Subject: Re: [RFC] generic device DMA implementation
Cc: davem@redhat.com, linux-kernel@vger.kernel.org, willy@debian.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

James Bottomley wrote:
>how about dma_alloc to take two flags

>DRIVER_SUPPORTS_CONSISTENT_ONLY

	It's pretty much impossible not to support consistent memory.

	I'd suggest a shorter name for code readability and particularly
to hint that this is the standard usage.  I'd suggest DMA_CONSISTENT
or "0".

>and

>DRIVER_SUPPORTS_NON_CONSISTENT

	There is a pretty strong convention for medium to short names
in the kernel, although this name will be used much less, so its
length is not as important.  I'd like something that would match the
names of the corresponding cache flushing and invalidation functions.
I think I had previously suggested DMA_MAYBE_CONSISTENT and wmb_maybe
or dma_sync_maybe but I'm not that attached to the "maybe" word.

[...]

>and dma_alloc_consistent to be equivalent to dma_alloc with  
>DRIVER_SUPPORTS_CONSISTENT_ONLY (and hence equivalent to pci_alloc_consistent)

Why have a separate dma_alloc_consistent function?

Adam J. Richter     __     ______________   575 Oroville Road
adam@yggdrasil.com     \ /                  Milpitas, California 95035
+1 408 309-6081         | g g d r a s i l   United States of America
                         "Free Software For The Rest Of Us."


