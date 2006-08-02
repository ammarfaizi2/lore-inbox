Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751212AbWHBFSR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751212AbWHBFSR (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Aug 2006 01:18:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751229AbWHBFSR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Aug 2006 01:18:17 -0400
Received: from pasmtpa.tele.dk ([80.160.77.114]:35488 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S1751212AbWHBFSQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Aug 2006 01:18:16 -0400
Date: Wed, 2 Aug 2006 07:18:45 +0200
From: Jens Axboe <axboe@suse.de>
To: Alexey Dobriyan <adobriyan@gmail.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] ifdef blktrace debugging fields
Message-ID: <20060802051844.GF20108@suse.de>
References: <200608010657.k716vBWF004420@shell0.pdx.osdl.net> <20060801071658.GG31908@suse.de> <20060801002904.53407219.akpm@osdl.org> <20060801074436.GJ31908@suse.de> <20060801134703.GG7006@martell.zuzino.mipt.ru> <20060801201256.GE20108@suse.de> <20060801224938.GA14863@martell.zuzino.mipt.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060801224938.GA14863@martell.zuzino.mipt.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 02 2006, Alexey Dobriyan wrote:
> On Tue, Aug 01, 2006 at 10:12:57PM +0200, Jens Axboe wrote:
> > > +#ifdef CONFIG_BLK_DEV_IO_TRACE
> > >  	if (q->blk_trace)
> > >  		blk_trace_shutdown(q);
> > > -
> > > +#endif
> > >  	kmem_cache_free(requestq_cachep, q);
> > >  }
> >
> > That can be made ifdef less, if you unconditionally call
> > blk_trace_shutdown() and just make that one do:
> >
> >         if (q->blk_trace) {
> >                 ...
> >         }
> >
> > since that'll then do the right always. Please make that change, then
> > I'm fine with the patch.
> 
> OK here goes version 3.
> 
> [PATCH] ifdef blktrace debugging fields

Looks good!

Acked-by: Jens Axboe <axboe@suse.de>

-- 
Jens Axboe

