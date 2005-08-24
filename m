Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750770AbVHXHIc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750770AbVHXHIc (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Aug 2005 03:08:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750784AbVHXHIc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Aug 2005 03:08:32 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:33204 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S1750770AbVHXHIb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Aug 2005 03:08:31 -0400
Date: Wed, 24 Aug 2005 09:08:31 +0200
From: Jens Axboe <axboe@suse.de>
To: Nathan Scott <nathans@sgi.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] blk queue io tracing support
Message-ID: <20050824070830.GB27956@suse.de>
References: <20050823123235.GG16461@suse.de> <20050824062459.GD1553@frodo>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050824062459.GD1553@frodo>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 24 2005, Nathan Scott wrote:
> Hi Jens,
> 
> On Tue, Aug 23, 2005 at 02:32:36PM +0200, Jens Axboe wrote:
> > ...
> > +	t.pid		= current->pid;
> > ...
> > +/*
> > + * The trace itself
> > + */
> > +struct blk_io_trace {
> > +	u32 magic;		/* MAGIC << 8 | version */
> > +	u32 sequence;		/* event number */
> > +	u64 time;		/* in microseconds */
> > +	u64 sector;		/* disk offset */
> > +	u32 bytes;		/* transfer length */
> > +	u32 action;		/* what happened */
> > +	u16 pid;		/* who did it */
> 
> Also, this field (pid) should probably be a u32.

Ah yes, thanks!

-- 
Jens Axboe

