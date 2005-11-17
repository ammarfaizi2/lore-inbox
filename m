Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750701AbVKQIfF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750701AbVKQIfF (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Nov 2005 03:35:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750703AbVKQIfF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Nov 2005 03:35:05 -0500
Received: from [85.8.13.51] ([85.8.13.51]:1693 "EHLO smtp.drzeus.cx")
	by vger.kernel.org with ESMTP id S1750701AbVKQIfE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Nov 2005 03:35:04 -0500
Message-ID: <437C40AE.2020309@drzeus.cx>
Date: Thu, 17 Nov 2005 09:34:54 +0100
From: Pierre Ossman <drzeus-list@drzeus.cx>
User-Agent: Mail/News 1.5 (X11/20051105)
MIME-Version: 1.0
To: LKML <linux-kernel@vger.kernel.org>
Subject: IOMMU and scatterlist limits
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm writing a PCI driver for the first time and I'm trying to wrap my
head around the DMA mappings in that world. I've done a ISA driver which
uses DMA, but this is a bit more complex and the documentation doesn't
explain everything.

What I'm particularly confused about is how the IOMMU should be handled
with regard to scatterlist limits. My hardware cannot handle
scatterlists, only a single DMA address. But from what I understand the
IOMMU can be very similar to a normal "CPU" MMU. So it should be able to
aggregate pages that are non-continuous in physical memory into one
single block in bus memory. Now the question is what do I set
nr_phys_segments and nr_hw_segments to? Of course the code also needs to
handle systems without an IOMMU.

Rgds
Pierre
