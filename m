Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261923AbVBYWNc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261923AbVBYWNc (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Feb 2005 17:13:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262582AbVBYWNc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Feb 2005 17:13:32 -0500
Received: from zcars04e.nortelnetworks.com ([47.129.242.56]:12725 "EHLO
	zcars04e.nortelnetworks.com") by vger.kernel.org with ESMTP
	id S261923AbVBYWMv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Feb 2005 17:12:51 -0500
Message-ID: <421FA1C7.2080201@nortel.com>
Date: Fri, 25 Feb 2005 16:08:07 -0600
X-Sybari-Space: 00000000 00000000 00000000 00000000
From: Chris Friesen <cfriesen@nortel.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040115
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Adrian Bunk <bunk@stusta.de>
CC: jmorris@redhat.com, davem@davemloft.net, linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] better CRYPTO_AES <-> CRYPTO_AES_586 dependencies
References: <20050225214613.GF3311@stusta.de>
In-Reply-To: <20050225214613.GF3311@stusta.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adrian Bunk wrote:

> --- linux-2.6.11-rc4-mm1-full/crypto/Kconfig.old	2005-02-25 22:26:20.000000000 +0100
> +++ linux-2.6.11-rc4-mm1-full/crypto/Kconfig	2005-02-25 22:28:44.000000000 +0100
> @@ -133,7 +133,9 @@
>  
>  config CRYPTO_AES
>  	tristate "AES cipher algorithms"
> -	depends on CRYPTO && !(X86 && !X86_64)
> +	depends on CRYPTO
> +	select CRYPTO_AES_GENERIC if !(X86 && !X86_64)
> +	select CRYPTO_AES_586 if (X86 && !X86_64)

Wouldn't the 586 one also work on x86_64?

Chris
