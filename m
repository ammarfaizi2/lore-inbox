Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750769AbVKJKmO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750769AbVKJKmO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Nov 2005 05:42:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750768AbVKJKmO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Nov 2005 05:42:14 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:25356 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1750769AbVKJKmN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Nov 2005 05:42:13 -0500
Date: Thu, 10 Nov 2005 11:42:11 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Matthew Dobson <colpatch@us.ibm.com>
Cc: Pekka J Enberg <penberg@cs.Helsinki.FI>, kernel-janitors@lists.osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 8/8] Inline 3 functions
Message-ID: <20051110104211.GB5376@stusta.de>
References: <436FF51D.8080509@us.ibm.com> <436FF894.8090204@us.ibm.com> <Pine.LNX.4.58.0511080937060.9530@sbz-30.cs.Helsinki.FI> <4370F7AE.5090505@us.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4370F7AE.5090505@us.ibm.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 08, 2005 at 11:08:30AM -0800, Matthew Dobson wrote:
> Pekka J Enberg wrote:
> > On Mon, 7 Nov 2005, Matthew Dobson wrote:
> > 
> >>I found three functions in slab.c that have only 1 caller (kmem_getpages,
> >>alloc_slabmgmt, and set_slab_attr), so let's inline them.
> > 
> > 
> > Why? They aren't on the hot path and I don't see how this is an 
> > improvement...
> > 
> > 			Pekka
> 
> Well, no, they aren't on the hot path.  I just figured since they are only
> ever called from one other function, why not inline them?  If the sentiment
> is that it's a BAD idea, I'll drop it.

And if there will one day be a second caller, noone will remember to 
remove the inline...

At least with unit-at-a-time [1], gcc should be smart enough to inline 
all static functions when it does make sense.

> -Matt

cu
Adrian

[1] currently disabled in the kernel on i386, but this will change at 
    least for the latest gcc in the mid-term future

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

