Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261563AbVCORbB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261563AbVCORbB (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Mar 2005 12:31:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261543AbVCOR3L
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Mar 2005 12:29:11 -0500
Received: from fire.osdl.org ([65.172.181.4]:26522 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261563AbVCOR2Y (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Mar 2005 12:28:24 -0500
Message-ID: <42371B00.7040204@osdl.org>
Date: Tue, 15 Mar 2005 09:27:28 -0800
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
Subject: Re: [16/many] acrypto: crypto_user.h
References: <11102278551459@2ka.mipt.ru>
In-Reply-To: <11102278551459@2ka.mipt.ru>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Evgeniy Polyakov wrote:
> --- /tmp/empty/crypto_user.h	1970-01-01 03:00:00.000000000 +0300
> +++ ./acrypto/crypto_user.h	2005-03-07 20:35:36.000000000 +0300
> @@ -0,0 +1,52 @@
> +/*
> + * 	crypto_user.h
> + *
> + * Copyright (c) 2004 Evgeniy Polyakov <johnpol@2ka.mipt.ru>
> + * 
> + */
> +
> +#ifndef __CRYPTO_USER_H
> +#define __CRYPTO_USER_H
> +
> +#define MAX_DATA_SIZE	3
> +#define ALIGN_DATA_SIZE(size)	((size + PAGE_SIZE - 1) & ~(PAGE_SIZE - 1))

ISTM that we need a generic round_up() function or macro in kernel.h.

a.out.h, reiserfs_fs.h, and ufs_fs.h all have their own round-up
macros.

-- 
~Randy
