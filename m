Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261405AbUE3Ohk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261405AbUE3Ohk (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 May 2004 10:37:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261943AbUE3Ohk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 May 2004 10:37:40 -0400
Received: from zaphod.lin-gen.com ([195.64.80.164]:4002 "EHLO zaphod.dth.net")
	by vger.kernel.org with ESMTP id S261405AbUE3Ohh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 May 2004 10:37:37 -0400
Date: Sun, 30 May 2004 16:37:34 +0200
From: Danny ter Haar <dth@dth.net>
To: Adrian Bunk <bunk@fs.tum.de>
Cc: walt <wa1ter@myrealbox.com>, jgarzik@pobox.com,
       Linux Kernel <linux-kernel@vger.kernel.org>, dth@ncc1701.cistron.net,
       linux-net@vger.kernel.org
Subject: Re: [patch] Re: Gigabit Kconfig problems with yesterday's update
Message-ID: <20040530143734.GA24627@dth.net>
References: <40B8A37D.1090802@myrealbox.com> <20040530134544.GE13111@fs.tum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040530134544.GE13111@fs.tum.de>
X-Message-Flag: WARNING!! You are using MS (f)outlook: Please consider upgrading to software with less bugs.
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Adrian Bunk (bunk@fs.tum.de):
> @Jeff:
> At a first glance, it seems the patch below that simply removes the 
> dependency of NET_GIGE on NET_ETHERNET would suffice.
> 
> Is this correct or did I miss something?
> 
> cu
> Adrian
> 
> --- linux-2.6.7-rc2-full/drivers/net/Kconfig.old	2004-05-30 15:33:24.000000000 +0200
> +++ linux-2.6.7-rc2-full/drivers/net/Kconfig	2004-05-30 15:38:41.000000000 +0200
> @@ -1879,7 +1879,7 @@
>  
>  config NET_GIGE
>  	bool "Gigabit Ethernet (1000/10000 Mbit) controller support"
> -	depends on NETDEVICES && NET_ETHERNET && (PCI || SBUS)
> +	depends on NETDEVICES && (PCI || SBUS)
>  	help
>  	  Gigabit ethernet.  It's yummy and fast, fast, fast.

Fresh source, this patch, old config from 2.6.7-rc1-bk2 and make
oldconfig now works ;)

Zanks

Danny
-- 
"If Microsoft had been the innovative company that it calls itself, it 
would have taken the opportunity to take a radical leap beyond the Mac, 
instead of producing a feeble, me-too implementation." - Douglas Adams -
