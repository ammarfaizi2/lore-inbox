Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750700AbVHXKJA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750700AbVHXKJA (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Aug 2005 06:09:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750715AbVHXKJA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Aug 2005 06:09:00 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:48912 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1750700AbVHXKJA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Aug 2005 06:09:00 -0400
Date: Wed, 24 Aug 2005 12:08:57 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Christoph Hellwig <hch@infradead.org>, linux-kernel@vger.kernel.org
Subject: Re: [RFC: 2.6 patch] #include <asm/irq.h> in interrupt.h
Message-ID: <20050824100857.GH5603@stusta.de>
References: <20050824085750.GG5603@stusta.de> <20050824092250.GA26726@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050824092250.GA26726@infradead.org>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 24, 2005 at 10:22:50AM +0100, Christoph Hellwig wrote:
> On Wed, Aug 24, 2005 at 10:57:50AM +0200, Adrian Bunk wrote:
> > If #includ'ing interrupt.h should be enough for getting the prototype of 
> > e.g. enable_irq() on all architectures, we need this patch.
> 
> Per defintion you need to include <asm/irq.h> right now.  I'd like to change
> that to <linux/interrupt.h>, but not my including <asm/irq.h> there.
> We should just make the prototypes in <linux/interrupt.h> unconditional
> and get rid of the macro/inline tricks some architectures do, these calls
> aren't exactly fastpathes where that matters.

Looking at 2.6.13-rc6-mm2, the only architectures with own enable_irq() 
implementations are m68knommu and sparc.

On m68knommu, enable_irq() does nothing unless a hook is used that has 
no in-kernel users.

The 32bit sparc arch seems to be the only arch doing funky things.

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

