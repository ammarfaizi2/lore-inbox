Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261365AbTFTE4K (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Jun 2003 00:56:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261414AbTFTEzx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Jun 2003 00:55:53 -0400
Received: from dp.samba.org ([66.70.73.150]:3558 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S261168AbTFTEzt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Jun 2003 00:55:49 -0400
From: Rusty Russell <rusty@rustcorp.com.au>
To: Adrian Bunk <bunk@fs.tum.de>
Cc: frible@teaser.fr, linux-kernel@vger.kernel.org, linux-net@vger.kernel.org,
       alan@lxorguk.ukuu.org.uk, jgarzik@pobox.com
Subject: Re: [2.5 patch] yam.c: return IRQ_NONE in error case 
In-reply-to: Your message of "Fri, 20 Jun 2003 02:01:38 +0200."
             <20030620000137.GG29247@fs.tum.de> 
Date: Fri, 20 Jun 2003 14:34:42 +1000
Message-Id: <20030620050950.1A9A82C09A@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <20030620000137.GG29247@fs.tum.de> you write:
> Please check whether the following patch to return IRQ_NONE in case of
> errors is correct:
> 
> --- linux-2.5.72-mm2/drivers/net/hamradio/yam.c.old	2003-06-20 01:57:02.000000000 +0200
> +++ linux-2.5.72-mm2/drivers/net/hamradio/yam.c	2003-06-20 01:57:41.000000000 +0200
> @@ -742,7 +742,7 @@
>  
>  			if (--counter <= 0) {
>  				printk(KERN_ERR "%s: too many irq iir=%d\n", dev->name, iir);
> -				return;
> +				return IRQ_NONE;
>  			}

IRQ_HANDLED, I think: it did handle them, but decided it was
livelocked and exited.

Cheers,
Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
