Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261929AbULGTsZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261929AbULGTsZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Dec 2004 14:48:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261910AbULGTot
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Dec 2004 14:44:49 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:57561 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S261919AbULGTme (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Dec 2004 14:42:34 -0500
Date: Tue, 7 Dec 2004 20:38:18 +0100
From: Jens Axboe <axboe@suse.de>
To: Adrian Bunk <bunk@stusta.de>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] bio.c: make bio_destructor static (fwd)
Message-ID: <20041207193817.GG20010@suse.de>
References: <20041207193522.GC7250@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041207193522.GC7250@stusta.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 07 2004, Adrian Bunk wrote:
> The patch forwarded below still applies and compiles against 
> 2.6.10-rc2-mm4.

Patch is correct, thanks.

> ----- Forwarded message from Adrian Bunk <bunk@stusta.de> -----
> 
> Date:	Sat, 30 Oct 2004 18:44:50 +0200
> From: Adrian Bunk <bunk@stusta.de>
> To: Jens Axboe <axboe@suse.de>
> Cc: linux-kernel@vger.kernel.org
> Subject: [2.6 patch] bio.c: make bio_destructor static
> 
> 
> bio_destructor in fs/bio.c isn't used outside of this file, and after 
> quickly thinking about it I didn't find a reason why it should.
> 
> The patch below makes it static.
> 
> 
> Signed-off-by: Adrian Bunk <bunk@stusta.de>
> Acked-by: Jens Axboe <axboe@suse.de>
> 
> --- linux-2.6.10-rc1-mm2-full/fs/bio.c.old	2004-10-30 13:53:41.000000000 +0200
> +++ linux-2.6.10-rc1-mm2-full/fs/bio.c	2004-10-30 13:56:16.000000000 +0200
> @@ -91,7 +91,7 @@
>  /*
>   * default destructor for a bio allocated with bio_alloc()
>   */
> -void bio_destructor(struct bio *bio)
> +static void bio_destructor(struct bio *bio)
>  {
>  	const int pool_idx = BIO_POOL_IDX(bio);
>  	struct biovec_pool *bp = bvec_array + pool_idx;
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 
> ----- End forwarded message -----
> 
> 

-- 
Jens Axboe

