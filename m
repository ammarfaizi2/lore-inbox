Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265677AbTABFv6>; Thu, 2 Jan 2003 00:51:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265689AbTABFv6>; Thu, 2 Jan 2003 00:51:58 -0500
Received: from dsl2.external.hp.com ([192.25.206.7]:50706 "EHLO
	dsl2.external.hp.com") by vger.kernel.org with ESMTP
	id <S265677AbTABFv5>; Thu, 2 Jan 2003 00:51:57 -0500
Date: Wed, 1 Jan 2003 23:00:30 -0700
To: linux-kernel@vger.kernel.org, parisc-linux@parisc-linux.org
Subject: Re: [parisc-linux] "vmalloc", friends and GFP flags
Message-ID: <20030102060030.GA14071@dsl2.external.hp.com>
References: <20030101214933.A26434@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030101214933.A26434@flint.arm.linux.org.uk>
User-Agent: Mutt/1.3.28i
From: grundler@dsl2.external.hp.com (Grant Grundler)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 01, 2003 at 09:49:33PM +0000, Russell King wrote:
> a) parisc.  Looking at pa11_dma_alloc_consistent:

If James is wrong and it's un-safe to call dma_alloc_consistent() on
the interrupt path, I'm only slightly worried since I've only seen
dma_alloc_consistent() get called during driver initialization.
DMA-mapping.txt does not restrict what context "driver initialization"
might take place in.

grant
