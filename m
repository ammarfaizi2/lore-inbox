Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266425AbUGOW1L@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266425AbUGOW1L (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Jul 2004 18:27:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266427AbUGOW1L
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Jul 2004 18:27:11 -0400
Received: from bart.webpack.hosteurope.de ([217.115.142.76]:49086 "EHLO
	bart.webpack.hosteurope.de") by vger.kernel.org with ESMTP
	id S266425AbUGOW1G (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Jul 2004 18:27:06 -0400
Date: Fri, 16 Jul 2004 00:32:44 +0200 (CEST)
From: Martin Diehl <lists@mdiehl.de>
X-X-Sender: martin@notebook.home.mdiehl.de
To: Andi Kleen <ak@muc.de>
cc: Jeff Garzik <jgarzik@pobox.com>, <netdev@oss.sgi.com>,
       <irda-users@lists.sourceforge.net>, <jt@hpl.hp.com>,
       <the_nihilant@autistici.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Drop ISA dependencies from IRDA drivers
In-Reply-To: <20040715215552.GA46635@muc.de>
Message-ID: <Pine.LNX.4.44.0407160027410.14037-100000@notebook.home.mdiehl.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-HE-MXrcvd: no
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 15 Jul 2004, Andi Kleen wrote:

> Remove wrong ISA dependencies for IRDA drivers.
> 
> 
> diff -u linux-2.6.8rc1-amd64/drivers/net/irda/Kconfig-o linux-2.6.8rc1-amd64/drivers/net/irda/Kconfig
> --- linux-2.6.8rc1-amd64/drivers/net/irda/Kconfig-o	2004-07-12 06:09:05.000000000 +0200
> +++ linux-2.6.8rc1-amd64/drivers/net/irda/Kconfig	2004-07-15 18:33:48.000000000 +0200
> @@ -310,7 +310,7 @@
>  
>  config NSC_FIR
>  	tristate "NSC PC87108/PC87338"
> -	depends on IRDA && ISA
> +	depends on IRDA


Admittedly I haven't tried either, but I'm pretty sure this patch will 
break building those drivers because they are calling irda_setup_dma - 
which is CONFIG_ISA. Maybe this can be dropped but I don't see what's 
wrong with !64BIT instead.

Martin

