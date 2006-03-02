Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750871AbWCBMYf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750871AbWCBMYf (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Mar 2006 07:24:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751335AbWCBMYf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Mar 2006 07:24:35 -0500
Received: from ns2.suse.de ([195.135.220.15]:16521 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1750871AbWCBMYf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Mar 2006 07:24:35 -0500
From: Andi Kleen <ak@suse.de>
To: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: PCI-DMA: Out of IOMMU space on x86-64 (Athlon64x2), with solution
Date: Thu, 2 Mar 2006 13:26:32 +0100
User-Agent: KMail/1.9.1
Cc: Jens Axboe <axboe@suse.de>, Michael Monnerie <m.monnerie@zmi.at>,
       linux-kernel@vger.kernel.org
References: <200603020023.21916@zmi.at> <200603021316.38077.ak@suse.de> <4406E226.4050806@pobox.com>
In-Reply-To: <4406E226.4050806@pobox.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200603021326.33220.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 02 March 2006 13:16, Jeff Garzik wrote:

> > Yes I've been thinking about adding a new sleeping interface to the IOMMU
> > that would block for new space to handle this. If I did that - would
> > libata be able to use it?
>
> No :(  We map inside a spin_lock_irqsave.

Would it be easily possible to change that or is it difficult?

Also with the blocking interface there might be possible deadlock issues 
because it will be essentially similar to allocating memory during IO.
But I think it's probably safe.

-Andi
