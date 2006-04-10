Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750867AbWDJEhN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750867AbWDJEhN (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Apr 2006 00:37:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750879AbWDJEhN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Apr 2006 00:37:13 -0400
Received: from pilet.ens-lyon.fr ([140.77.167.16]:31158 "EHLO
	pilet.ens-lyon.fr") by vger.kernel.org with ESMTP id S1750867AbWDJEhL convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Apr 2006 00:37:11 -0400
Date: Mon, 10 Apr 2006 06:38:08 +0200
From: Benoit Boissinot <benoit.boissinot@ens-lyon.org>
To: Michael Buesch <mb@bu3sch.de>
Cc: netdev@vger.kernel.org, bcm43xx-dev@lists.berlios.de,
       linux-kernel@vger.kernel.org, linville@tuxdriver.com,
       benh@kernel.crashing.org
Subject: Re: [RFC/PATCH] remove unneeded check in bcm43xx
Message-ID: <20060410043808.GP27596@ens-lyon.fr>
References: <20060410040120.GA4860@ens-lyon.fr> <200604100607.33362.mb@bu3sch.de> <20060410042228.GN27596@ens-lyon.fr> <200604100628.01483.mb@bu3sch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <200604100628.01483.mb@bu3sch.de>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 10, 2006 at 06:28:00AM +0200, Michael Buesch wrote:
> On Monday 10 April 2006 06:22, you wrote:
> > Either the ppc code is wrong (it doesn't enforce dma_mask) either the
> > driver still works without the check.
> > 
> > Maybe ppc should do the same thing as i386:
> > 
> > 47         if (dev == NULL || (dev->coherent_dma_mask < 0xffffffff))
> > 48                 gfp |= GFP_DMA;
> 
> No, GFP_DMA is a NOP on PPC.
> Actually the problems seems much more complex and a correct fix
> seems to be hard to do.
> I think benh is actually fixing this.
> 
> To summerize: I actually added these messages, because people were
> hitting "this does not work with >1G" issues and did not get an error message.
> So I decided to insert warnings until the issue is fixed inside the arch code.
> I will remove them once the issue is fixed.
>

Thanks for the explainations.

Benoit


-- 
powered by bash/screen/(urxvt/fvwm|linux-console)/gentoo/gnu/linux OS
