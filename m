Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261925AbTERDEh (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 May 2003 23:04:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261927AbTERDEh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 May 2003 23:04:37 -0400
Received: from arnor.apana.org.au ([203.14.152.115]:20755 "EHLO
	arnor.me.apana.org.au") by vger.kernel.org with ESMTP
	id S261925AbTERDEg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 May 2003 23:04:36 -0400
Date: Sun, 18 May 2003 13:15:46 +1000
To: James Morris <jmorris@intercode.com.au>
Cc: davem@redhat.com, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Added missing dependencies on CRYPTO_HMAC
Message-ID: <20030518031546.GA4943@gondor.apana.org.au>
References: <20030518021034.GA4667@gondor.apana.org.au> <Mutt.LNX.4.44.0305181218300.21143-100000@excalibur.intercode.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Mutt.LNX.4.44.0305181218300.21143-100000@excalibur.intercode.com.au>
User-Agent: Mutt/1.5.4i
From: Herbert Xu <herbert@gondor.apana.org.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 18, 2003 at 12:19:09PM +1000, James Morris wrote:
> 
> See crypto/Kconfig, CRYPTO_HMAC is being defaulted to Y if these protocols 
> are selected.

Yes, but the user can then set them to no.  This does happen as the
Crypto menu is listed after Networking so someone going through it
in that order can select INET_AH and then go on to disable Crypto.

Dependencies are there to prevent these things from happening.
-- 
Debian GNU/Linux 3.0 is out! ( http://www.debian.org/ )
Email:  Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
