Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261529AbTHYIOz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Aug 2003 04:14:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261539AbTHYIOz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Aug 2003 04:14:55 -0400
Received: from arnor.apana.org.au ([203.14.152.115]:19214 "EHLO
	arnor.me.apana.org.au") by vger.kernel.org with ESMTP
	id S261529AbTHYIOy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Aug 2003 04:14:54 -0400
Date: Mon, 25 Aug 2003 18:12:41 +1000
To: Willy Tarreau <willy@w.ods.org>
Cc: Marcelo Tosatti <marcelo@conectiva.com.br>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [AMD76X]
Message-ID: <20030825081241.GA6538@gondor.apana.org.au>
References: <20030823233323.GA7989@gondor.apana.org.au> <20030824175321.GF734@alpha.home.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030824175321.GF734@alpha.home.local>
User-Agent: Mutt/1.5.4i
From: Herbert Xu <herbert@gondor.apana.org.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 24, 2003 at 07:53:21PM +0200, Willy Tarreau wrote:
> 
> I'm wondering whether this patch should be needed too.
> 
> --- linux-2.4.22-rc3/drivers/char/amd76x_pm.c.orig	Sun Aug 24 19:52:42 2003
> +++ linux-2.4.22-rc3/drivers/char/amd76x_pm.c	Sun Aug 24 19:53:49 2003
> @@ -620,6 +620,8 @@
>  #ifndef AMD76X_NTH
>  	if (!amd76x_pm_cfg.curr_idle) {
>  		printk(KERN_ERR "amd76x_pm: Idle function not changed\n");
> +		pci_unregister_driver(&amd_nb_driver);
> +		pci_unregister_driver(&amd_sb_driver);
>  		return 1;
>  	}

Although this error is currently not possible, we should include
your fixup anyway.

Thanks,
-- 
Debian GNU/Linux 3.0 is out! ( http://www.debian.org/ )
Email:  Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
