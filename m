Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262382AbTCMOyx>; Thu, 13 Mar 2003 09:54:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262383AbTCMOyx>; Thu, 13 Mar 2003 09:54:53 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:18897 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S262382AbTCMOyw>;
	Thu, 13 Mar 2003 09:54:52 -0500
Date: Thu, 13 Mar 2003 16:05:25 +0100
From: Jens Axboe <axboe@suse.de>
To: Joe Korty <joe.korty@ccur.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] bug in 2.4 bh_kmap_irq() breaks IDE under preempt patch
Message-ID: <20030313150525.GD836@suse.de>
References: <20030313092601.GB827@suse.de> <200303131459.OAA18664@rudolph.ccur.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200303131459.OAA18664@rudolph.ccur.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 13 2003, Joe Korty wrote:
> > I fixed this in 2.5 ages ago, just didn't get it in 2.4 block-highmem...
> > There's a tiny bit missing from your patch:
> > 
> > > +	local_irq_save(*flags);
> > 	local_irq_disable();
> > 
> > other than that it's fine. See 2.5 for reference.
> 
> local_irq_save() does a local_irq_disable() as part of its function.

indeed, you are right.

-- 
Jens Axboe

