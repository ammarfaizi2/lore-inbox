Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261686AbVBSIvj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261686AbVBSIvj (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Feb 2005 03:51:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261669AbVBSItn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Feb 2005 03:49:43 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:64712 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S261670AbVBSIrk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Feb 2005 03:47:40 -0500
Message-ID: <4216FD14.5070506@pobox.com>
Date: Sat, 19 Feb 2005 03:47:16 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040922
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Adrian Bunk <bunk@stusta.de>
CC: rl@hellgate.ch, linux-net@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] drivers/net/via-rhine.c: make a variable static
References: <20050219084433.GU4337@stusta.de>
In-Reply-To: <20050219084433.GU4337@stusta.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adrian Bunk wrote:
> This patch makes a needlessly global variable static.
> 
> Signed-off-by: Adrian Bunk <bunk@stusta.de>
> 
> --- linux-2.6.11-rc3-mm2-full/drivers/net/via-rhine.c.old	2005-02-16 18:56:59.000000000 +0100
> +++ linux-2.6.11-rc3-mm2-full/drivers/net/via-rhine.c	2005-02-16 18:57:05.000000000 +0100
> @@ -390,7 +390,7 @@
>  
>  #ifdef USE_MMIO
>  /* Registers we check that mmio and reg are the same. */
> -int mmio_verify_registers[] = {
> +static int mmio_verify_registers[] = {
>  	RxConfig, TxConfig, IntrEnable, ConfigA, ConfigB, ConfigC, ConfigD,
>  	0

static const

	Jeff



