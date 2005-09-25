Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932281AbVIYTh0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932281AbVIYTh0 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Sep 2005 15:37:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932282AbVIYThZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Sep 2005 15:37:25 -0400
Received: from [85.8.12.41] ([85.8.12.41]:59269 "EHLO smtp.drzeus.cx")
	by vger.kernel.org with ESMTP id S932281AbVIYThZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Sep 2005 15:37:25 -0400
Message-ID: <4336FC72.70103@drzeus.cx>
Date: Sun, 25 Sep 2005 21:37:22 +0200
From: Pierre Ossman <drzeus-list@drzeus.cx>
User-Agent: Mozilla Thunderbird 1.0.6-5 (X11/20050818)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Christoph Hellwig <hch@infradead.org>
CC: rmk+lkml@arm.linux.org.uk, linux-kernel@vger.kernel.org,
       Andi Kleen <ak@suse.de>
Subject: Re: [PATCH] [MMC] wbsd: use dma_alloc insted of kmalloc
References: <20050925191614.23944.2485.stgit@poseidon.drzeus.cx> <20050925192958.GA25848@infradead.org>
In-Reply-To: <20050925192958.GA25848@infradead.org>
X-Enigmail-Version: 0.90.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Hellwig wrote:
> On Sun, Sep 25, 2005 at 09:16:23PM +0200, Pierre Ossman wrote:
> 
>>x86_64 doesn't seem to like being passed pointers allocated using
>>kmalloc to the DMA mapping API.
> 
> 
> How so?  There's not much else that could be passed to dma_map_single.

It kept oopsing on dma_map_single(). I'm guessing it expects som
structures to be present for its IOMMU.

http://list.drzeus.cx/pipermail/wbsd-devel/2005-September/000335.html

> 
> Please try to fix x86_64 instead.

I'm not familiar with the x86_64 IOMMU, I don't even have access to the
hardware. So I figured I'd side-step the problem since there was an API
avaiable that works more reliably.

Andi might be more up to the task?

Rgds
Pierre
