Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751083AbWDJWNP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751083AbWDJWNP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Apr 2006 18:13:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751213AbWDJWNP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Apr 2006 18:13:15 -0400
Received: from pilet.ens-lyon.fr ([140.77.167.16]:26504 "EHLO
	pilet.ens-lyon.fr") by vger.kernel.org with ESMTP id S1751083AbWDJWNO
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Apr 2006 18:13:14 -0400
Date: Tue, 11 Apr 2006 00:13:59 +0200
From: Benoit Boissinot <benoit.boissinot@ens-lyon.org>
To: Michael Buesch <mb@bu3sch.de>, netdev@vger.kernel.org,
       bcm43xx-dev@lists.berlios.de, linux-kernel@vger.kernel.org,
       benh@kernel.crashing.org
Subject: Re: [RFC/PATCH] remove unneeded check in bcm43xx
Message-ID: <20060410221359.GC27596@ens-lyon.fr>
References: <20060410040120.GA4860@ens-lyon.fr> <200604100607.33362.mb@bu3sch.de> <20060410042228.GN27596@ens-lyon.fr> <200604100628.01483.mb@bu3sch.de> <20060410134625.GA25360@tuxdriver.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060410134625.GA25360@tuxdriver.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 10, 2006 at 09:46:30AM -0400, John W. Linville wrote:
> On Mon, Apr 10, 2006 at 06:28:00AM +0200, Michael Buesch wrote:
> 
> > To summerize: I actually added these messages, because people were
> > hitting "this does not work with >1G" issues and did not get an error message.
> > So I decided to insert warnings until the issue is fixed inside the arch code.
> > I will remove them once the issue is fixed.
> 
> This sounds like the same sort of problems w/ the b44 driver.
> I surmise that both use the same (broken) DMA engine from Broadcom.
> 
> Unfortunately, I don't know of any good solution to this.  There are
> a few hacks in b44 that deal with the issue.  I don't like them,
> although I am the perpetrator of at least one of them.  It might be
> worth looking at what was done there?

The hacks i see there is reallocating a buffer with GFP_DMA, so that
means that if the ppc dma_alloc_coherent did the same thing as the i386
counterpart (adding GFP_DMA if dma_mask is less than 32bits) it should
work, no ?

regards,

Benoit

ps: i do not have the hardware so i sadly cannot test.

-- 
powered by bash/screen/(urxvt/fvwm|linux-console)/gentoo/gnu/linux OS
