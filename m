Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262076AbTJFNmm (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Oct 2003 09:42:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262081AbTJFNmm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Oct 2003 09:42:42 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:14230 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S262076AbTJFNmh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Oct 2003 09:42:37 -0400
Date: Mon, 6 Oct 2003 15:42:25 +0200
From: Jens Axboe <axboe@suse.de>
To: Felipe W Damasio <felipewd@terra.com.br>
Cc: Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Cciss-discuss@lists.sourceforge.net
Subject: Re: [PATCH] release_region in cciss block driver
Message-ID: <20031006134225.GA972@suse.de>
References: <3F816DE5.8060009@terra.com.br>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3F816DE5.8060009@terra.com.br>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 06 2003, Felipe W Damasio wrote:
> 	Hi Andrew,
> 
> 	Patch against 2.6.0-test6.
> 
> 	Release a previous requested region if we're about the fail the 
> 	board initialization. Found by smatch.
> 
> 	Please review and consider applying,
> 
> 	Thanks.
> 
> Felipe

> --- linux-2.6.0-test6/drivers/block/cciss.c.orig	2003-10-06 10:18:01.000000000 -0300
> +++ linux-2.6.0-test6/drivers/block/cciss.c	2003-10-06 10:25:04.000000000 -0300
> @@ -2185,6 +2185,7 @@
>  		schedule_timeout(HZ / 10); /* wait 100ms */
>  	}
>  	if (scratchpad != CCISS_FIRMWARE_READY) {
> +		release_io_mem (c);
>  		printk(KERN_WARNING "cciss: Board not ready.  Timed out.\n");
>  		return -1;
>  	}

Please at least try and follow the local style when you make changes.

-- 
Jens Axboe

