Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261340AbUD3VVt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261340AbUD3VVt (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Apr 2004 17:21:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261179AbUD3VVs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Apr 2004 17:21:48 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:48827 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S261340AbUD3VRy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Apr 2004 17:17:54 -0400
Date: Fri, 30 Apr 2004 23:13:43 +0200
From: Jens Axboe <axboe@suse.de>
To: Matt Domsch <Matt_Domsch@dell.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: reduce blk queue and I/O capability printk to KERN_DEBUG?
Message-ID: <20040430211342.GA31842@suse.de>
References: <20040430195055.GA7235@lists.us.dell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040430195055.GA7235@lists.us.dell.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 30 2004, Matt Domsch wrote:
> Jens,
> 
> Any reason why this message isn't being printed at KERN_DEBUG or
> thereabouts, as the comment immediately before it notes it's for
> debugging purposes, and it's only interesting to kernel developers not
> end users?
> 
> Thanks,
> Matt
> 
> -- 
> Matt Domsch
> Sr. Software Engineer, Lead Engineer
> Dell Linux Solutions linux.dell.com & www.dell.com/linux
> Linux on Dell mailing lists @ http://lists.us.dell.com
> 
> ===== drivers/block/ll_rw_blk.c 1.244 vs edited =====
> --- 1.244/drivers/block/ll_rw_blk.c	Tue Apr 27 08:11:32 2004
> +++ edited/drivers/block/ll_rw_blk.c	Fri Apr 30 14:46:57 2004
> @@ -284,7 +284,7 @@
>  	 * keep this for debugging for now...
>  	 */
>  	if (dma_addr != BLK_BOUNCE_HIGH && q != last_q) {
> -		printk("blk: queue %p, ", q);
> +		printk(KERN_DEBUG "blk: queue %p, ", q);
>  		if (dma_addr == BLK_BOUNCE_ANY)
>  			printk("no I/O memory limit\n");
>  		else

It should just be deleted. As you note, it is a debug message. I
originally added it so we would have some clues as to dma capability for
bug reports. There never was any, the check can go :)

-- 
Jens Axboe

