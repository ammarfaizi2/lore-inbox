Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314138AbSFEKCn>; Wed, 5 Jun 2002 06:02:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314284AbSFEKCm>; Wed, 5 Jun 2002 06:02:42 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:4292 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S314138AbSFEKCl>;
	Wed, 5 Jun 2002 06:02:41 -0400
Date: Wed, 5 Jun 2002 12:02:29 +0200
From: Jens Axboe <axboe@suse.de>
To: "Roger W. Brown" <bregor@anusf.anu.edu.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Definition conflict in 2.4.19-pre?? code
Message-ID: <20020605100229.GX1105@suse.de>
In-Reply-To: <200206051736.45920.bregor@sf.anu.edu.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 05 2002, Roger W. Brown wrote:
> 
>   Hi,
> 
>       I am not able to compile 2.4 series kernels after
>   linux-2.4.19-pre1 and I don't understand how others can !
> 
>   Consider the "struct request_queue" definition in blkdev.h
> 
>   In the 2.4.19-pre1 version, the last few lines read:
>         /*
>          * Tasks wait here for free read and write requests
>          */
>         wait_queue_head_t       wait_for_requests[2];
>   };
>   and for later versions this is changed to:
>         /*
>          * Tasks wait here for free request
>          */
>         wait_queue_head_t       wait_for_request;
>   };
> 
>   yet drivers/block/ll_rw_blk.c still makes references to
>   wait_for_requests[?]  in the void blk_init_free_list()
>   and blkdev_release_request() functions and elsewhere.

Your kernel tree must be corrupted, there's no such change in later
2.4.19-pre. pre10 still uses two request wait queues.

-- 
Jens Axboe

