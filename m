Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262453AbVBEBKR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262453AbVBEBKR (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Feb 2005 20:10:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264236AbVBEBEk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Feb 2005 20:04:40 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:27787 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S265862AbVBEBBj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Feb 2005 20:01:39 -0500
Message-ID: <42041ADD.8050606@pobox.com>
Date: Fri, 04 Feb 2005 20:01:17 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040922
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Daniel Drake <dsd@gentoo.org>
CC: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       linux-pm@osdl.org
Subject: Re: [-mm PATCH] driver model: PM type conversions in drivers/net
References: <4203F3D5.9060605@gentoo.org>
In-Reply-To: <4203F3D5.9060605@gentoo.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Daniel Drake wrote:
> diff -urNpX dontdiff linux-2.6.11-rc2-mm2/drivers/net/bmac.c linux-dsd/drivers/net/bmac.c
> --- linux-2.6.11-rc2-mm2/drivers/net/bmac.c	2005-02-02 21:54:17.353663112 +0000
> +++ linux-dsd/drivers/net/bmac.c	2005-02-02 20:52:48.000000000 +0000
> @@ -455,7 +455,7 @@ static void bmac_init_chip(struct net_de
>  }
>  
>  #ifdef CONFIG_PM
> -static int bmac_suspend(struct macio_dev *mdev, u32 state)
> +static int bmac_suspend(struct macio_dev *mdev, pm_message_t state)
>  {
>  	struct net_device* dev = macio_get_drvdata(mdev);	
>  	struct bmac_data *bp = netdev_priv(dev);
> diff -urNpX dontdiff linux-2.6.11-rc2-mm2/drivers/net/irda/sa1100_ir.c linux-dsd/drivers/net/irda/sa1100_ir.c
> --- linux-2.6.11-rc2-mm2/drivers/net/irda/sa1100_ir.c	2004-12-24 21:35:50.000000000 +0000
> +++ linux-dsd/drivers/net/irda/sa1100_ir.c	2005-02-02 20:59:28.000000000 +0000
> @@ -291,7 +291,7 @@ static void sa1100_irda_shutdown(struct 
>  /*
>   * Suspend the IrDA interface.
>   */
> -static int sa1100_irda_suspend(struct device *_dev, u32 state, u32 level)
> +static int sa1100_irda_suspend(struct device *_dev, pm_message_t state, u32 level)

Why does this one have three arguments?

	Jeff


