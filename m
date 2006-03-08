Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964835AbWCHA2Z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964835AbWCHA2Z (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Mar 2006 19:28:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964837AbWCHA2Z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Mar 2006 19:28:25 -0500
Received: from gate.crashing.org ([63.228.1.57]:1251 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S964835AbWCHA2Y (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Mar 2006 19:28:24 -0500
Subject: Re: [TG3]: Add DMA address workaround
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Michael Chan <mchan@broadcom.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       "David S. Miller" <davem@davemloft.net>,
       Anton Blanchard <anton@samba.org>, Paul Mackerras <paulus@samba.org>
In-Reply-To: <1141769938.8146.19.camel@rh4>
References: <200603071900.k27J0YSP023014@hera.kernel.org>
	 <1141773668.11221.110.camel@localhost.localdomain>
	 <1141769938.8146.19.camel@rh4>
Content-Type: text/plain
Date: Wed, 08 Mar 2006 11:28:04 +1100
Message-Id: <1141777685.11221.129.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.5.92 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-03-07 at 14:18 -0800, Michael Chan wrote:

> So how does powerpc handle 32-bit PCI devices that don't support dual
> address cycles? Such devices will set the dma_mask to 32-bit. Shouldn't
> 40-bit be handled in a similar way?

I've double checked that our current DMA code always stays below 32
bits. I was more wondering about some not-yet there stuff but it looks
like we are safe on that side too.

One thing i've been looking into doing with the iommu code is to make it
capable of respecting the DMA mask precisely (by constraining the
allocator to any arbitrary mask, not just 32 vs. 64 bits) to make it
more useful for bcm44xx and 43xx... but that's a different story.

Ben.


