Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261895AbVCHAST@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261895AbVCHAST (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Mar 2005 19:18:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261897AbVCGXxZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Mar 2005 18:53:25 -0500
Received: from fire.osdl.org ([65.172.181.4]:10672 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262003AbVCGXuL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Mar 2005 18:50:11 -0500
Message-ID: <422CE8C4.8010500@osdl.org>
Date: Mon, 07 Mar 2005 15:50:28 -0800
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
Subject: Re: [3/many] acrypto: acrypto.h
References: <11102278533380@2ka.mipt.ru>
In-Reply-To: <11102278533380@2ka.mipt.ru>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Evgeniy Polyakov wrote:
> --- /tmp/empty/acrypto.h	1970-01-01 03:00:00.000000000 +0300
> +++ ./acrypto/acrypto.h	2005-03-07 20:35:36.000000000 +0300
> @@ -0,0 +1,245 @@
> +/*
> + * 	acrypto.h
> + *
> + * Copyright (c) 2004 Evgeniy Polyakov <johnpol@2ka.mipt.ru>
> + * 
> + */
> +
> +#ifdef __KERNEL__
> +
> +#define SESSION_COMPLETED	(1<<15)
> +#define SESSION_FINISHED	(1<<14)
> +#define SESSION_STARTED		(1<<13)
> +#define SESSION_PROCESSED	(1<<12)
> +#define SESSION_BINDED		(1<<11)
Just a thought:  SESSION_BOUND  ??

> +#define SESSION_BROKEN		(1<<10)
> +#define SESSION_FROM_CACHE	(1<<9)
> +
> +#define DEVICE_BROKEN		(1<<0)
> +
> +#define device_broken(dev)	(dev->flags & DEVICE_BROKEN)
> +#define broke_device(dev)	do {dev->flags |= DEVICE_BROKEN;} while(0)
            break_device(dev)

> +int match_initializer(struct crypto_device *, struct crypto_session_initializer *);
> +int __match_initializer(struct crypto_capability *, struct crypto_session_initializer *);
> +
> +#endif				/* __KERNEL__ */
> +#endif				/* __ACRYPTO_H */

Several of these could use some namespace_idents on them (SESSION_xyz,
DEVICE_xyz, device_xyz, match_xyz)...

-- 
~Randy
