Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261436AbVAHUTx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261436AbVAHUTx (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Jan 2005 15:19:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261378AbVAHUTx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Jan 2005 15:19:53 -0500
Received: from mail.fh-wedel.de ([213.39.232.198]:1202 "EHLO
	moskovskaya.fh-wedel.de") by vger.kernel.org with ESMTP
	id S261436AbVAHUTv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Jan 2005 15:19:51 -0500
Date: Sat, 8 Jan 2005 21:18:59 +0100
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: Adrian Bunk <bunk@stusta.de>
Cc: Andrew Morton <akpm@osdl.org>, dwmw2@infradead.org,
       linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org,
       Simon Evans <spse@secret.org.uk>, joern@wh.fh-wedel.de
Subject: Re: [patch] 2.6.10-mm2: fix MTD_BLOCK2MTD dependency
Message-ID: <20050108201859.GB11728@wohnheim.fh-wedel.de>
References: <20050106002240.00ac4611.akpm@osdl.org> <20050106150346.GC3096@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20050106150346.GC3096@stusta.de>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 6 January 2005 16:03:46 +0100, Adrian Bunk wrote:
> 
> The patch below fixes an obviously wrong dependency coming from Linus' 
> tree.

Acked.

Thanks!

> Signed-off-by: Adrian Bunk <bunk@stusta.de>
> 
> --- linux-2.6.10-mm2-full/drivers/mtd/devices/Kconfig.old	2005-01-06 16:00:49.000000000 +0100
> +++ linux-2.6.10-mm2-full/drivers/mtd/devices/Kconfig	2005-01-06 16:00:59.000000000 +0100
> @@ -127,7 +127,7 @@
>  
>  config MTD_BLOCK2MTD
>  	tristate "MTD using block device (rewrite)"
> -	depends on MTD || EXPERIMENTAL
> +	depends on MTD && EXPERIMENTAL
>  	help
>  	  This driver is basically the same at MTD_BLKMTD above, but
>  	  experienced some interface changes plus serious speedups.  In

Jörn

-- 
Fancy algorithms are buggier than simple ones, and they're much harder
to implement. Use simple algorithms as well as simple data structures.
-- Rob Pike
