Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261711AbUFBQJ2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261711AbUFBQJ2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Jun 2004 12:09:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263271AbUFBQJ2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Jun 2004 12:09:28 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:45968 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S261711AbUFBQJV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Jun 2004 12:09:21 -0400
Date: Wed, 2 Jun 2004 18:09:05 +0200
From: Jens Axboe <axboe@suse.de>
To: Christophe Saout <christophe@saout.de>
Cc: Alasdair G Kergon <agk@redhat.com>, Andrew Morton <akpm@osdl.org>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 5/5: Device-mapper: dm-zero
Message-ID: <20040602160905.GX28915@suse.de>
References: <20040602154605.GR6302@agk.surrey.redhat.com> <1086192141.4659.1.camel@leto.cs.pocnet.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1086192141.4659.1.camel@leto.cs.pocnet.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 02 2004, Christophe Saout wrote:
> Am Mi, den 02.06.2004 um 16:46 Uhr +0100 schrieb Alasdair G Kergon:
> 
> > +	bio_for_each_segment(bv, bio, i) {
> > +		char *data = bvec_kmap_irq(bv, &flags);
> > +		memset(data, 0, bv->bv_len);
> 
> I just noticed, there's a
> 
> 		flush_dcache_page(bv->bv_page);
> 
> missing here.
> 
> > +		bvec_kunmap_irq(bv, &flags);

and even worse, passing bad argument to bvec_kunmap_irq().

-- 
Jens Axboe

