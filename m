Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964772AbVJSJhN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964772AbVJSJhN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Oct 2005 05:37:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964771AbVJSJhM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Oct 2005 05:37:12 -0400
Received: from vulpecula.futurs.inria.fr ([195.83.212.5]:48281 "EHLO
	vulpecula.futurs.inria.fr") by vger.kernel.org with ESMTP
	id S964772AbVJSJhL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Oct 2005 05:37:11 -0400
Message-ID: <435613B3.5060509@tremplin-utc.net>
Date: Wed, 19 Oct 2005 11:36:51 +0200
From: Eric Piel <Eric.Piel@tremplin-utc.net>
User-Agent: Mozilla Thunderbird 1.0.7-3mdk (X11/20051015)
X-Accept-Language: fr, en
MIME-Version: 1.0
To: dsaxena@plexity.net
Cc: linux-kernel@vger.kernel.org, jgarzik@pobox.net, akpm@osdl.org,
       tony@atomide.com
Subject: Re: [patch 5/5] TI OMAP driver
References: <20051019081906.615365000@omelas> <20051019091717.773678000@omelas>
In-Reply-To: <20051019091717.773678000@omelas>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

10/19/2005 10:19 AM, dsaxena@plexity.net wrote/a écrit:
> This patch implements the OMAP RNG driver. 
> 
> Signed-off-by: Deepak Saxena <dsaxena@plexity.net>
> 
> ---
> 
> Builts but untested as I do not hardware. 
> 
> Index: linux-omap-2.6/drivers/char/rng/omap-rng.c
> ===================================================================
> --- /dev/null
> +++ linux-omap-2.6/drivers/char/rng/omap-rng.c

> +#ifdef CONFIG_PM
> +
> +static int omap_rng_suspend(struct device *dev, pm_message_t message, u32 level)
> +{
> +	omap_rng_write_reg(RNG_MASK_REG, 0x0);
> +
> +	return 0;
> +}
> +
> +static int omap_rng_suspend(struct device *dev, pm_message_t message, u32 level)
> +{
> +	omap_rng_write_reg(RNG_MASK_REG, 0x1);
> +
> +	return 1;
> +}
Probably one of them should be called omap_rng_resume() ?

Eric
