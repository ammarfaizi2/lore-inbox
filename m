Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261575AbUK2To0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261575AbUK2To0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Nov 2004 14:44:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261578AbUK2TnN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Nov 2004 14:43:13 -0500
Received: from av1-2-sn3.vrr.skanova.net ([81.228.9.106]:62632 "EHLO
	av1-2-sn3.vrr.skanova.net") by vger.kernel.org with ESMTP
	id S261575AbUK2Tdm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Nov 2004 14:33:42 -0500
To: Adrian Bunk <bunk@stusta.de>, Andrew Morton <akpm@osdl.org>
Cc: axboe@suse.de, linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] drivers/block/pktcdvd.c: make two functions static
References: <20041124231055.GN19873@stusta.de>
	<20041125101220.GC29539@infradead.org>
	<20041129123307.GN9722@stusta.de>
From: Peter Osterlund <petero2@telia.com>
Date: 29 Nov 2004 20:33:39 +0100
In-Reply-To: <20041129123307.GN9722@stusta.de>
Message-ID: <m3d5xw30x8.fsf@telia.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adrian Bunk <bunk@stusta.de> writes:

> The patch below makes two needlessly global functions static.

Looks good to me.

> diffstat output:
>  drivers/block/pktcdvd.c |    4 ++--
>  1 files changed, 2 insertions(+), 2 deletions(-)
> 
> 
> Signed-off-by: Adrian Bunk <bunk@stusta.de>
> 
> --- linux-2.6.10-rc1-mm3-full/drivers/block/pktcdvd.c.old	2004-11-06 20:16:55.000000000 +0100
> +++ linux-2.6.10-rc1-mm3-full/drivers/block/pktcdvd.c	2004-11-06 20:17:22.000000000 +0100
> @@ -2627,7 +2627,7 @@
>  	.fops  		= &pkt_ctl_fops
>  };
>  
> -int pkt_init(void)
> +static int pkt_init(void)
>  {
>  	int ret;
>  
> @@ -2663,7 +2663,7 @@
>  	return ret;
>  }
>  
> -void pkt_exit(void)
> +static void pkt_exit(void)
>  {
>  	remove_proc_entry("pktcdvd", proc_root_driver);
>  	misc_deregister(&pkt_misc);

-- 
Peter Osterlund - petero2@telia.com
http://web.telia.com/~u89404340
