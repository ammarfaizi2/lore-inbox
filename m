Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751786AbWHTW6s@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751786AbWHTW6s (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Aug 2006 18:58:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751787AbWHTW6r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Aug 2006 18:58:47 -0400
Received: from rhun.apana.org.au ([64.62.148.172]:8708 "EHLO
	arnor.apana.org.au") by vger.kernel.org with ESMTP id S1751784AbWHTW6q
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Aug 2006 18:58:46 -0400
Date: Mon, 21 Aug 2006 08:58:30 +1000
To: Solar Designer <solar@openwall.com>
Cc: Willy Tarreau <w@1wt.eu>, linux-kernel@vger.kernel.org,
       linux-crypto@vger.kernel.org
Subject: Re: [PATCH] cit_encrypt_iv/cit_decrypt_iv for ECB mode
Message-ID: <20060820225830.GA31693@gondor.apana.org.au>
References: <20060820002346.GA16995@openwall.com> <20060820080403.GA602@1wt.eu> <20060820144908.GA19602@openwall.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060820144908.GA19602@openwall.com>
User-Agent: Mutt/1.5.9i
From: Herbert Xu <herbert@gondor.apana.org.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 20, 2006 at 06:49:08PM +0400, Solar Designer wrote:
> 
> Can we maybe define working but IV-ignoring functions for ECB (like I
> did), but use memory-clearing nocrypt*() for CFB and CTR (as long as
> these are not supported)?  Of course, all of these will return -ENOSYS.

In cryptodev-2.6, with block ciphers you can no longer select CFB/CTR
until someone writes support for them so this is no longer an issue.

For 2.4, I don't really mind either way what nocrypt does.

Cheers,
-- 
Visit Openswan at http://www.openswan.org/
Email: Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
