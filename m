Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265880AbUKASJu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265880AbUKASJu (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Nov 2004 13:09:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S274195AbUKASJs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Nov 2004 13:09:48 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:46508 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S284637AbUKASH2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Nov 2004 13:07:28 -0500
Date: Mon, 1 Nov 2004 19:03:48 +0100
From: Jens Axboe <axboe@suse.de>
To: Adrian Bunk <bunk@stusta.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] bio.c: make bio_destructor static
Message-ID: <20041101180348.GB5299@suse.de>
References: <20041030164450.GN4374@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041030164450.GN4374@stusta.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 30 2004, Adrian Bunk wrote:
> 
> bio_destructor in fs/bio.c isn't used outside of this file, and after 
> quickly thinking about it I didn't find a reason why it should.
> 
> The patch below makes it static.
> 
> 
> Signed-off-by: Adrian Bunk <bunk@stusta.de>

Acked-by: Jens Axboe <axboe@suse.de>

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
> 

-- 
Jens Axboe

