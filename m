Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261388AbVCOQ3L@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261388AbVCOQ3L (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Mar 2005 11:29:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261413AbVCOQ05
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Mar 2005 11:26:57 -0500
Received: from fire.osdl.org ([65.172.181.4]:10633 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261388AbVCOQ0J (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Mar 2005 11:26:09 -0500
Message-ID: <42370C51.4060607@osdl.org>
Date: Tue, 15 Mar 2005 08:24:49 -0800
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
Subject: Re: [11/many] acrypto: crypto_main.c
References: <11102278541439@2ka.mipt.ru>
In-Reply-To: <11102278541439@2ka.mipt.ru>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Evgeniy Polyakov wrote:
> --- /tmp/empty/crypto_main.c	1970-01-01 03:00:00.000000000 +0300
> +++ ./acrypto/crypto_main.c	2005-03-07 20:35:36.000000000 +0300
> @@ -0,0 +1,374 @@
> +/*
> + * 	crypto_main.c
> + *
> + * Copyright (c) 2004 Evgeniy Polyakov <johnpol@2ka.mipt.ru>
> + * 
> + */

> +struct crypto_session *crypto_session_alloc(struct crypto_session_initializer *ci, struct crypto_data *d)
> +{
> +	struct crypto_session *s;
> +
> +	s = crypto_session_create(ci, d);
> +	if (!s)
> +		return NULL;
> +
> +	crypto_session_add(s);
> +
> +	return s;
> +}
> +
> +

> +EXPORT_SYMBOL(crypto_session_alloc);
Why is this one not _GPL ??  It calls _create() and _add().

> +EXPORT_SYMBOL_GPL(crypto_session_create);
> +EXPORT_SYMBOL_GPL(crypto_session_add);
> +EXPORT_SYMBOL_GPL(crypto_session_dequeue_route);


-- 
~Randy
