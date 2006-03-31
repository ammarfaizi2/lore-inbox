Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751238AbWCaHRv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751238AbWCaHRv (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 31 Mar 2006 02:17:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751242AbWCaHRv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 31 Mar 2006 02:17:51 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:20281 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S1751238AbWCaHRv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 31 Mar 2006 02:17:51 -0500
Date: Fri, 31 Mar 2006 09:17:57 +0200
From: Jens Axboe <axboe@suse.de>
To: Jeff Garzik <jeff@garzik.org>
Cc: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] splice exports
Message-ID: <20060331071757.GC14022@suse.de>
References: <20060331040613.GA23511@havoc.gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060331040613.GA23511@havoc.gtf.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 30 2006, Jeff Garzik wrote:
> 
> Woe be unto he who builds their filesystems as modules.
> 
> Signed-off-by: Jeff Garzik <jeff@garzik.org>
> 
> diff --git a/fs/splice.c b/fs/splice.c
> index 4a026f9..7c2bbf1 100644
> --- a/fs/splice.c
> +++ b/fs/splice.c
> @@ -22,6 +22,7 @@
>  #include <linux/pipe_fs_i.h>
>  #include <linux/mm_inline.h>
>  #include <linux/swap.h>
> +#include <linux/module.h>
>  
>  /*
>   * Passed to the actors
> @@ -567,6 +568,9 @@ ssize_t generic_splice_sendpage(struct i
>  	return move_from_pipe(inode, out, len, flags, pipe_to_sendpage);
>  }
>  
> +EXPORT_SYMBOL(generic_file_splice_write);
> +EXPORT_SYMBOL(generic_file_splice_read);
> +
>  static long do_splice_from(struct inode *pipe, struct file *out, size_t len,
>  			   unsigned int flags)
>  {

Thanks Jeff!

-- 
Jens Axboe

