Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317398AbSIJRPU>; Tue, 10 Sep 2002 13:15:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317434AbSIJRPU>; Tue, 10 Sep 2002 13:15:20 -0400
Received: from swazi.realnet.co.sz ([196.28.7.2]:60311 "HELO
	netfinity.realnet.co.sz") by vger.kernel.org with SMTP
	id <S317398AbSIJRPS>; Tue, 10 Sep 2002 13:15:18 -0400
Date: Tue, 10 Sep 2002 19:43:20 +0200 (SAST)
From: Zwane Mwaikambo <zwane@mwaikambo.name>
X-X-Sender: zwane@linux-box.realnet.co.sz
To: Skip Ford <skip.ford@verizon.net>
Cc: linux-kernel@vger.kernel.org, <torvalds@transmeta.com>
Subject: Re: [PATCH] 2.5.34 ufs/super.c
In-Reply-To: <200209092047.g89KldtA000217@pool-141-150-242-242.delv.east.verizon.net>
Message-ID: <Pine.LNX.4.44.0209101941370.1100-100000@linux-box.realnet.co.sz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 9 Sep 2002, Skip Ford wrote:

> I've needed this patch since 2.5.32 to successfully mount a UFS
> partition.
> 
> --- linux/fs/ufs/super.c~	Mon Sep  9 16:39:52 2002
> +++ linux/fs/ufs/super.c	Mon Sep  9 16:39:57 2002
> @@ -605,7 +605,7 @@
>  	}
>  	
>  again:	
> -	if (sb_set_blocksize(sb, block_size)) {
> +	if (!sb_set_blocksize(sb, block_size)) {
>  		printk(KERN_ERR "UFS: failed to set blocksize\n");
>  		goto failed;
>  	}

Good heavens! I introduced that bug when fixing another bug a while ago, i 
was pretty certain it got fixed (it got fixed in 2.4 and -dj(?))

	Zwane
-- 
function.linuxpower.ca

