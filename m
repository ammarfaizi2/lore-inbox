Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261610AbSJYVZw>; Fri, 25 Oct 2002 17:25:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261612AbSJYVZw>; Fri, 25 Oct 2002 17:25:52 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:41393 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S261610AbSJYVZv>;
	Fri, 25 Oct 2002 17:25:51 -0400
Date: Fri, 25 Oct 2002 23:31:45 +0200
From: Jens Axboe <axboe@suse.de>
To: "Cameron, Steve" <Steve.Cameron@hp.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.5.44-ac3, cciss, more scatter gather elements
Message-ID: <20021025213145.GH12628@suse.de>
References: <45B36A38D959B44CB032DA427A6E10640167D070@cceexc18.americas.cpqcorp.net> <20021025211107.GG1203@suse.de> <20021025212438.GH1203@suse.de> <20021025212512.GI1203@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021025212512.GI1203@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 25 2002, Jens Axboe wrote:
>  			} else {
>  new_segment:
> -				memset(&sg[nsegs],0,sizeof(struct scatterlist));
> -				sg[nsegs].page = bvec->bv_page;
> -				sg[nsegs].length = nbytes;
> -				sg[nsegs].offset = bvec->bv_offset;
> -
> +				sg.page = bvec->bv_page;
> +				sg.offset = bvec->bv_offset;
> +				sg.length = nbytes;
> +				map(q, &sg, nsegs, cookie);
				if (sgprev)
					map(q, sgprev, nsegs, cookie);

of course, and likewise for the cluster check. I'll cut a clean version
tomorrow, I'm out for today..

-- 
Jens Axboe

