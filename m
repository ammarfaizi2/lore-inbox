Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263349AbTFJPsm (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jun 2003 11:48:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263338AbTFJPsm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jun 2003 11:48:42 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:55776 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S263295AbTFJPre (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jun 2003 11:47:34 -0400
Date: Tue, 10 Jun 2003 18:01:14 +0200
From: Jens Axboe <axboe@suse.de>
To: Hugh Dickins <hugh@veritas.com>
Cc: Andrew Morton <akpm@digeo.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] loop 2/9 absorb bio_copy
Message-ID: <20030610160114.GG17164@suse.de>
References: <20030610153730.GC17164@suse.de> <Pine.LNX.4.44.0306101657140.2334-100000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0306101657140.2334-100000@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 10 2003, Hugh Dickins wrote:
> On Tue, 10 Jun 2003, Jens Axboe wrote:
> > On Tue, Jun 10 2003, Hugh Dickins wrote:
> > > bio_copy is used only by the loop driver, which already has to walk the
> > > bio segments itself: so it makes sense to change it from bio.c export
> > > to loop.c static, as prelude to working upon it there.
> > 
> > I don't think this is is a particularly good idea, it's pretty core bio
> > functionality that should be left alone in bio.c imho.
> > 
> > Is there a real reason you want to do this apart from 'loop is the only
> > (current) user'?
> 
> As I said, loop already has to walk the bio segments itself elsewhere,
> and a lot of what bio_copy does (e.g. copying data) it doesn't need done,
> and other things it does (same gfp_mask for two very different allocations)
> don't suit loop very well.  By all means add bio_copy back into fs/bio.c
> when something else needs that functionality?

Alright, I guess I can live with that as there's no direct need for it
elsewhere right now. Just doesn't feel right.

-- 
Jens Axboe

