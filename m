Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261977AbVCGXnx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261977AbVCGXnx (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Mar 2005 18:43:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261905AbVCGXnm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Mar 2005 18:43:42 -0500
Received: from fire.osdl.org ([65.172.181.4]:44204 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261908AbVCGXdg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Mar 2005 18:33:36 -0500
Message-ID: <422CE4B2.2020403@osdl.org>
Date: Mon, 07 Mar 2005 15:33:06 -0800
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
Subject: Re: [1/many] acrypto: Kconfig
References: <11102278531852@2ka.mipt.ru>
In-Reply-To: <11102278531852@2ka.mipt.ru>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Evgeniy Polyakov wrote:
> diff -Nru /tmp/empty/Kconfig ./acrypto/Kconfig
> --- /tmp/empty/Kconfig	1970-01-01 03:00:00.000000000 +0300
> +++ ./acrypto/Kconfig	2005-03-07 21:21:33.000000000 +0300
> @@ -0,0 +1,30 @@
> +menu "Asynchronous crypto layer"
> +
> +config ACRYPTO
> +	tristate "Asynchronous crypto layer"
> +	select CONNECTOR
> +	--- help ---
> +	It supports:
> +	 - multiple asynchronous crypto device queues
> +	 - crypto session routing
> +	 - crypto session binding
> +	 - modular load balancing
> +	 - crypto session batching genetically implemented by design
Just curious, what genetics?

> +	 - crypto session priority
> +	 - different kinds of crypto operation(RNG, asymmetrical crypto, HMAC and any other
                                      operation (RNG, ... )
> +
> +config SIMPLE_LB
> +	tristate "Simple load balancer"
> +	depends on ACRYPTO
> +	--- help ---
> +	Simple load balancer returns device with the lowest load
> +	(device has the least number of session in it's queue) if it exists.
                                         sessions in its
> +
> +config ASYNC_PROVIDER
> +	tristate "Asynchronous crypto provider (AES CBC)"
> +	depends on ACRYPTO && (CRYPTO_AES || CRYPTO_AES_586)
> +	--- help ---
> +	Asynchronous crypto provider based on synchronous crypto layer.
> +	It supports AES CBC crypto mode (may be changed by source edition).
> +
> +endmenu

-- 
~Randy
