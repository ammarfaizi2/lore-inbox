Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316523AbSE3JLV>; Thu, 30 May 2002 05:11:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316526AbSE3JLU>; Thu, 30 May 2002 05:11:20 -0400
Received: from h-64-105-136-78.SNVACAID.covad.net ([64.105.136.78]:3764 "EHLO
	freya.yggdrasil.com") by vger.kernel.org with ESMTP
	id <S316523AbSE3JLU>; Thu, 30 May 2002 05:11:20 -0400
From: "Adam J. Richter" <adam@yggdrasil.com>
Date: Thu, 30 May 2002 02:11:12 -0700
Message-Id: <200205300911.CAA01655@adam.yggdrasil.com>
To: linux-kernel@vger.kernel.org
Subject: Does pci_alloc_consisent really need to zero memory?
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	Is it really necessary for pci_alloc_consistent() to
fill the memory that it returns with all zeroes?  I don't
see anything in Documentation/DMA-mapping.txt that specifies
it.  I have been on the lookout for drivers that rely on it
for the past couple of months, and I haven't seen any.  It's
only one line of code in arch/i386/kernel/pci-dma.c, but it
is potentially a lot of cycles, even if only zeroes the
space you requested (rather than the full pages that it
actually allocates).

	If nobody objects in the next half day or so (or asks
me to follow some other course of action), I'll submit a patch for
2.5 for all architectures.

Adam J. Richter     __     ______________   575 Oroville Road
adam@yggdrasil.com     \ /                  Milpitas, California 95035
+1 408 309-6081         | g g d r a s i l   United States of America
                         "Free Software For The Rest Of Us."
