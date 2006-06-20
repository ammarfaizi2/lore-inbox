Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964934AbWFTLOg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964934AbWFTLOg (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jun 2006 07:14:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932598AbWFTLOg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jun 2006 07:14:36 -0400
Received: from rhun.apana.org.au ([64.62.148.172]:37388 "EHLO
	arnor.apana.org.au") by vger.kernel.org with ESMTP id S932596AbWFTLOf
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jun 2006 07:14:35 -0400
Date: Tue, 20 Jun 2006 21:14:30 +1000
To: Joachim Fritschi <jfritschi@freenet.de>
Cc: linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org, ak@suse.de
Subject: Re: [PATCH  4/4] Twofish cipher - x86_64 assembler
Message-ID: <20060620111430.GA13878@gondor.apana.org.au>
References: <200606041516.46920.jfritschi@freenet.de> <200606191613.01212.jfritschi@freenet.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200606191613.01212.jfritschi@freenet.de>
User-Agent: Mutt/1.5.9i
From: Herbert Xu <herbert@gondor.apana.org.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 19, 2006 at 04:13:01PM +0200, Joachim Fritschi wrote:
> This patch is now based on the cryptodev tree using the new cryptoapi (crypto  tfm
>  instead of the crypto ctx as parameter).
> 
> The module passed the tcrypt tests and testscripts.
> 
> Signed-off-by: Joachim Fritschi <jfritschi@freenet.de>

Thanks Joachim.  I've applied all four patches.  I had to add wrappers
around the twofish assembly routines because asmlinkage may differ from
the normal C calling convention.  It should get optimised away to just
a jump if the conventions are identical.

BTW Andi, I think it might be better to have the x86-64 patch sit in the
cryptodev tree rather than x86-64 because it won't even compile without
the previous patches.  If you really want to, I can leave out the x86-64
one in particular for you to merge after the others go upstream.

Cheers,
-- 
Visit Openswan at http://www.openswan.org/
Email: Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
