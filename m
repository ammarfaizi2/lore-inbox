Return-Path: <linux-kernel-owner+w=401wt.eu-S933336AbWLIGdI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933336AbWLIGdI (ORCPT <rfc822;w@1wt.eu>);
	Sat, 9 Dec 2006 01:33:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759246AbWLIGdI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Dec 2006 01:33:08 -0500
Received: from nf-out-0910.google.com ([64.233.182.187]:21517 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759233AbWLIGdF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Dec 2006 01:33:05 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=NmLTIz9kxIttGl9MpxFS7/dRQtfa3RSyfVoXp6XaA9IB8dKPr5di2KXwA+9ux/OXYV9Fk4jT2434zBAjaeBqXaK0FHmgcyzAjGx2H+/RC2moUYgPvB8CkWo6hr52TOw5f2nF5ujEaUvBa0aODnf7xZVZYY0h5rfiIwanS7a+nyM=
Message-ID: <457A5862.1020006@gmail.com>
Date: Sat, 09 Dec 2006 07:32:02 +0100
From: Rene Herman <rene.herman@gmail.com>
User-Agent: Thunderbird 1.5.0.8 (X11/20061025)
MIME-Version: 1.0
To: Chris Wright <chrisw@sous-sol.org>
CC: linux-kernel@vger.kernel.org, stable@kernel.org,
       Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       Chris Wedgwood <reviews@ml.cw.f00f.org>,
       Michael Krufky <mkrufky@linuxtv.org>, torvalds@osdl.org, akpm@osdl.org,
       alan@lxorguk.ukuu.org.uk, Herbert Xu <herbert@gondor.apana.org.au>
Subject: Re: [patch 08/32] cryptoloop: Select CRYPTO_CBC
References: <20061208235751.890503000@sous-sol.org> <20061208235942.464993000@sous-sol.org>
In-Reply-To: <20061208235942.464993000@sous-sol.org>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chris Wright wrote:

> -stable review patch.  If anyone has any objections, please let us know.
> ------------------
> 
> From: Herbert Xu <herbert@gondor.apana.org.au>
> 
> As CBC is the default chaining method for cryptoloop, we should select
> it from cryptoloop to ease the transition.
> 
> Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
> Signed-off-by: Chris Wright <chrisw@sous-sol.org>
> ---
>  drivers/block/Kconfig |    1 +
>  1 file changed, 1 insertion(+)
> 
> --- linux-2.6.19.orig/drivers/block/Kconfig
> +++ linux-2.6.19/drivers/block/Kconfig
> @@ -305,6 +305,7 @@ config BLK_DEV_LOOP
>  config BLK_DEV_CRYPTOLOOP
>  	tristate "Cryptoloop Support"
>  	select CRYPTO
> +	select CRYPTO_CBC
>  	depends on BLK_DEV_LOOP
>  	---help---
>  	  Say Y here if you want to be able to use the ciphers that are 
> 

dm-crypt needs CBC in the same manner -- normal (via howto) use of 
cryptsetup doesn't work otherwise, same as with cryptoloop.

Rene.

