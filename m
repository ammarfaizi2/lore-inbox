Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932109AbWHTXzP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932109AbWHTXzP (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Aug 2006 19:55:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932113AbWHTXzO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Aug 2006 19:55:14 -0400
Received: from smtp.osdl.org ([65.172.181.4]:18129 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932109AbWHTXzM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Aug 2006 19:55:12 -0400
Date: Sun, 20 Aug 2006 16:51:50 -0700
From: Andrew Morton <akpm@osdl.org>
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: Adrian Bunk <bunk@stusta.de>, linux-kernel@vger.kernel.org,
       linux-crypto@vger.kernel.org, Michal Ludvig <michal@logix.cz>
Subject: Re: [-mm patch] CRYPTO_DEV_PADLOCK_AES must select CRYPTO_BLKCIPHER
Message-Id: <20060820165150.bdb9e4cc.akpm@osdl.org>
In-Reply-To: <20060820230415.GB31693@gondor.apana.org.au>
References: <20060819220008.843d2f64.akpm@osdl.org>
	<20060820160928.GN7813@stusta.de>
	<20060820230415.GB31693@gondor.apana.org.au>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 21 Aug 2006 09:04:15 +1000
Herbert Xu <herbert@gondor.apana.org.au> wrote:

> > --- linux-2.6.18-rc4-mm2/drivers/crypto/Kconfig.old	2006-08-20 17:28:46.000000000 +0200
> > +++ linux-2.6.18-rc4-mm2/drivers/crypto/Kconfig	2006-08-20 17:44:56.000000000 +0200
> > @@ -16,6 +16,7 @@
> >  config CRYPTO_DEV_PADLOCK_AES
> >  	bool "Support for AES in VIA PadLock"
> >  	depends on CRYPTO_DEV_PADLOCK
> > +	select CRYPTO_BLKCIPHER
> >  	default y
> >  	help
> >  	  Use VIA PadLock for AES algorithm.
> 
> Andrew, there is definitely something screwed up.

Things are a bit messy at present - some git trees are based off Greg's
tree and some are based off Linus's and git is pretty hopeless at pulling
usable diffs in these complex situations.

So yes, it's quite possible that the above is a merging problem.
