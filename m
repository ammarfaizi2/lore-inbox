Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261824AbVCGXn4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261824AbVCGXn4 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Mar 2005 18:43:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261873AbVCGXm1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Mar 2005 18:42:27 -0500
Received: from fire.osdl.org ([65.172.181.4]:34477 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261824AbVCGXg5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Mar 2005 18:36:57 -0500
Message-ID: <422CE5BA.9040209@osdl.org>
Date: Mon, 07 Mar 2005 15:37:30 -0800
From: "Randy.Dunlap" <rddunlap@osdl.org>
Organization: OSDL
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
CC: linux-kernel@vger.kernel.org, Fruhwirth Clemens <clemens@endorphin.org>,
       Herbert Xu <herbert@gondor.apana.org.au>, cryptoapi@lists.logix.cz,
       James Morris <jmorris@redhat.com>, David Miller <davem@davemloft.net>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [8/many] acrypto: crypto_dev.c
References: <1110227854480@2ka.mipt.ru>
In-Reply-To: <1110227854480@2ka.mipt.ru>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Evgeniy Polyakov wrote:
> --- /tmp/empty/crypto_dev.c	1970-01-01 03:00:00.000000000 +0300
> +++ ./acrypto/crypto_dev.c	2005-03-07 20:35:36.000000000 +0300
> @@ -0,0 +1,421 @@
> +/*
> + * 	crypto_dev.c
> + *
> + * Copyright (c) 2004 Evgeniy Polyakov <johnpol@2ka.mipt.ru>

> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/moduleparam.h>
> +#include <linux/types.h>
> +#include <linux/list.h>
> +#include <linux/slab.h>
> +#include <linux/interrupt.h>
> +#include <linux/spinlock.h>
> +#include <linux/device.h>

In alpha order as much as possible, please.

> +#include "acrypto.h"
> +
> +static LIST_HEAD(cdev_list);
> +static spinlock_t cdev_lock = SPIN_LOCK_UNLOCKED;

DEFINE_SPINLOCK(cdev_lock);

-- 
~Randy
