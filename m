Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282082AbRK1HeX>; Wed, 28 Nov 2001 02:34:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282079AbRK1HeM>; Wed, 28 Nov 2001 02:34:12 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:5391 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S282080AbRK1HeC>;
	Wed, 28 Nov 2001 02:34:02 -0500
Date: Wed, 28 Nov 2001 08:33:39 +0100
From: Jens Axboe <axboe@suse.de>
To: David Mansfield <david@cobite.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: comment typo for generic_make_request in 2.5.1-pre2?
Message-ID: <20011128083338.I23858@suse.de>
In-Reply-To: <Pine.LNX.4.33.0111271455560.4599-100000@admin>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.33.0111271455560.4599-100000@admin>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 27 2001, David Mansfield wrote:
> 
> Hi Jens et al,
> 
> Just looking at the bio changes in pre2 and I came across the comment for 
> generic_make_request that says it may change bi_dev and/or bi_rsector.  I 
> think the bi_rsector is supposed to be bi_sector (since the former no 
> longer exists).  Here's a patch if in fact this is just a typo:
> 
> --- ll_rw_blk.c.orig	Tue Nov 27 14:57:40 2001
> +++ ll_rw_blk.c	Tue Nov 27 15:02:23 2001
> @@ -1041,7 +1041,7 @@
>   *
>   * generic_make_request and the drivers it calls may use bi_next if this
>   * bio happens to be merged with someone else, and may change bi_dev and
> - * bi_rsector for remaps as it sees fit.  So the values of these fields
> + * bi_sector for remaps as it sees fit.  So the values of these fields
>   * should NOT be depended on after the call to generic_make_request.
>   *
>   * */

Thanks, applied.

> It's really no big deal, but I guess even the comments deserve to be 
> correct. Anyway, this stuff is certainly fun reading!

Good :-)

-- 
Jens Axboe

