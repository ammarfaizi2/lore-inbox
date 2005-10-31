Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932309AbVJaMCi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932309AbVJaMCi (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Oct 2005 07:02:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932320AbVJaMCh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Oct 2005 07:02:37 -0500
Received: from 22.107.233.220.exetel.com.au ([220.233.107.22]:54026 "EHLO
	arnor.apana.org.au") by vger.kernel.org with ESMTP id S932309AbVJaMCh
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Oct 2005 07:02:37 -0500
Date: Mon, 31 Oct 2005 22:58:37 +1100
To: Adrian Bunk <bunk@stusta.de>
Cc: James Morris <jmorris@redhat.com>, Kausty <kkumbhalkar@gmail.com>,
       linux-kernel@vger.kernel.org, davem@davemloft.net,
       linux-crypto@vger.kernel.org
Subject: Re: [2.6 patch] crypto/api.c: remove the second argument of crypto_alg_available()
Message-ID: <20051031115837.GA352@gondor.apana.org.au>
References: <41ae44840501200448197d18c0@mail.gmail.com> <Xine.LNX.4.44.0501200952440.952-100000@thoron.boston.redhat.com> <20051031054642.GD8009@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051031054642.GD8009@stusta.de>
User-Agent: Mutt/1.5.9i
From: Herbert Xu <herbert@gondor.apana.org.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 31, 2005 at 06:46:42AM +0100, Adrian Bunk wrote:
>
> > IIRC, this was to allow future code to specify preferences for the type of
> > algorithm driver (e.g. hardware), but has not been used.  This is an
> > example of why it's a bad idea to add infrastructure which isn't being
> > used at the time.
> 
> Since it's still unused, a patch to remove this second argument is 
> below.

I'll be using this field very soon to indicate that the caller intends
to find synchronous algorithms only as opposed to either synchronous or
asynchronous.  So I'd like to keep it for now.

Thanks,
-- 
Visit Openswan at http://www.openswan.org/
Email: Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
