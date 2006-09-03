Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750994AbWICMnZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750994AbWICMnZ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Sep 2006 08:43:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750992AbWICMnZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Sep 2006 08:43:25 -0400
Received: from khc.piap.pl ([195.187.100.11]:35744 "EHLO khc.piap.pl")
	by vger.kernel.org with ESMTP id S1750980AbWICMnY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Sep 2006 08:43:24 -0400
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
       "David S. Miller" <davem@davemloft.net>, linux-kernel@vger.kernel.org,
       netdev@vger.kernel.org
Subject: Re: 2.6.18-rc5 with GRE, iptables and Speedtouch ADSL, PPP over ATM
References: <m3odty57gf.fsf@defiant.localdomain>
	<20060903111507.GA12580@gondor.apana.org.au>
From: Krzysztof Halasa <khc@pm.waw.pl>
Date: Sun, 03 Sep 2006 14:43:20 +0200
In-Reply-To: <20060903111507.GA12580@gondor.apana.org.au> (Herbert Xu's message of "Sun, 3 Sep 2006 21:15:07 +1000")
Message-ID: <m3k64lm87r.fsf@defiant.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Herbert Xu <herbert@gondor.apana.org.au> writes:

> [NET]: Drop tx lock in dev_watchdog_up
> --- a/net/sched/sch_generic.c
> +++ b/net/sched/sch_generic.c
> @@ -238,9 +238,7 @@ void __netdev_watchdog_up(struct net_dev
>  
>  static void dev_watchdog_up(struct net_device *dev)
>  {
> -	netif_tx_lock_bh(dev);
>  	__netdev_watchdog_up(dev);
> -	netif_tx_unlock_bh(dev);
>  }
>  
>  static void dev_watchdog_down(struct net_device *dev)

Many thanks for looking into this. The lockdep warning is gone now.
-- 
Krzysztof Halasa

-- 
VGER BF report: H 3.43998e-11
