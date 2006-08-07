Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751140AbWHGXHn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751140AbWHGXHn (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Aug 2006 19:07:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751155AbWHGXHn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Aug 2006 19:07:43 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:65185 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1751140AbWHGXHm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Aug 2006 19:07:42 -0400
Date: Tue, 8 Aug 2006 01:07:26 +0200
From: Pavel Machek <pavel@ucw.cz>
To: "Randy.Dunlap" <rdunlap@xenotime.net>
Cc: lkml <linux-kernel@vger.kernel.org>, akpm <akpm@osdl.org>,
       Paul.Clements@steeleye.com
Subject: Re: [PATCH -mm 1/5] nbd: printk format warning
Message-ID: <20060807230726.GA2724@elf.ucw.cz>
References: <20060807154750.5a268055.rdunlap@xenotime.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060807154750.5a268055.rdunlap@xenotime.net>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> Fix printk format warning(s):
> drivers/block/nbd.c:410: warning: long unsigned int format, different type arg (arg 4)
> 

ACK, but notice that we have new nbd maintainer... for a few years
now.

							Pavel

> Signed-off-by: Randy Dunlap <rdunlap@xenotime.net>
> ---
>  drivers/block/nbd.c |    2 +-
>  1 files changed, 1 insertion(+), 1 deletion(-)
> 
> --- linux-2618-rc3mm2.orig/drivers/block/nbd.c
> +++ linux-2618-rc3mm2/drivers/block/nbd.c
> @@ -407,7 +407,7 @@ static void do_nbd_request(request_queue
>  		struct nbd_device *lo;
>  
>  		blkdev_dequeue_request(req);
> -		dprintk(DBG_BLKDEV, "%s: request %p: dequeued (flags=%lx)\n",
> +		dprintk(DBG_BLKDEV, "%s: request %p: dequeued (flags=%x)\n",
>  				req->rq_disk->disk_name, req, req->cmd_type);
>  
>  		if (!blk_fs_request(req))
> 
> 
> ---

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
