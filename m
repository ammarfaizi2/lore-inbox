Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261770AbUK2ToZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261770AbUK2ToZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Nov 2004 14:44:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261766AbUK2Tno
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Nov 2004 14:43:44 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:27529 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S261770AbUK2TjV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Nov 2004 14:39:21 -0500
Date: Mon, 29 Nov 2004 20:36:06 +0100
From: Jens Axboe <axboe@suse.de>
To: Adrian Bunk <bunk@stusta.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] drivers/block/elevator.c: make two functions static
Message-ID: <20041129193606.GD11102@suse.de>
References: <20041124231055.GN19873@stusta.de> <20041125101220.GC29539@infradead.org> <20041129122632.GI9722@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041129122632.GI9722@stusta.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 29 2004, Adrian Bunk wrote:
> The patch below makes two needlessly global functions static.
> 
> 
> diffstat output:
>  drivers/block/elevator.c |    4 ++--
>  1 files changed, 2 insertions(+), 2 deletions(-)
> 
> 
> Signed-off-by: Adrian Bunk <bunk@stusta.de>

Acked-by: Jens Axboe <axboe@suse.de>

> --- linux-2.6.10-rc1-mm3-full/drivers/block/elevator.c.old	2004-11-06 19:55:01.000000000 +0100
> +++ linux-2.6.10-rc1-mm3-full/drivers/block/elevator.c	2004-11-06 19:55:34.000000000 +0100
> @@ -92,7 +92,7 @@
>  }
>  EXPORT_SYMBOL(elv_try_last_merge);
>  
> -struct elevator_type *elevator_find(const char *name)
> +static struct elevator_type *elevator_find(const char *name)
>  {
>  	struct elevator_type *e = NULL;
>  	struct list_head *entry;
> @@ -222,7 +222,7 @@
>  	kfree(e);
>  }
>  
> -int elevator_global_init(void)
> +static int elevator_global_init(void)
>  {
>  	return 0;
>  }
> 
> 

-- 
Jens Axboe

