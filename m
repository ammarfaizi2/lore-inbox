Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261244AbUCKNHt (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Mar 2004 08:07:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261234AbUCKNHt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Mar 2004 08:07:49 -0500
Received: from zero.aec.at ([193.170.194.10]:30982 "EHLO zero.aec.at")
	by vger.kernel.org with ESMTP id S261244AbUCKNHs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Mar 2004 08:07:48 -0500
To: Boszormenyi Zoltan <zboszor@freemail.hu>
cc: linux-kernel@vger.kernel.org
Subject: Re: x86_64 IOMMU question
References: <1yxkz-6ct-31@gated-at.bofh.it>
From: Andi Kleen <ak@muc.de>
Date: Thu, 18 Mar 2004 00:14:09 +0100
In-Reply-To: <1yxkz-6ct-31@gated-at.bofh.it> (Boszormenyi Zoltan's message
 of "Thu, 11 Mar 2004 13:20:15 +0100")
Message-ID: <m3ptbbawxq.fsf@averell.firstfloor.org>
User-Agent: Gnus/5.110002 (No Gnus v0.2) Emacs/21.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Boszormenyi Zoltan <zboszor@freemail.hu> writes:

> is it possible to use the IOMMU to help 32 bit devices
> that limit their capabilities with pci_set_dma_mask()?
> E.g. the emu10k1 limits itself under 256MB. Can the IOMMU
> pass the data to/from the card from/to above 256MB?

It can only remap to the AGP aperture, which is usually
just below the 4GB boundary. In theory you could move the aperture
to a very low address and remap to that (see 
arch/x86_64/kernel/aperture.c), but that would waste memory.

-Andi

