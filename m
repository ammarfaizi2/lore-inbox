Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932169AbWGaK75@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932169AbWGaK75 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Jul 2006 06:59:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932068AbWGaK75
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Jul 2006 06:59:57 -0400
Received: from rhun.apana.org.au ([64.62.148.172]:20241 "EHLO
	arnor.apana.org.au") by vger.kernel.org with ESMTP id S932146AbWGaK7y
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Jul 2006 06:59:54 -0400
Date: Mon, 31 Jul 2006 20:59:43 +1000
To: David Miller <davem@davemloft.net>
Cc: johnpol@2ka.mipt.ru, drepper@redhat.com, zach.brown@oracle.com,
       linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [RFC 1/4] kevent: core files.
Message-ID: <20060731105943.GA26114@gondor.apana.org.au>
References: <20060731103322.GA1898@2ka.mipt.ru> <E1G7V7r-0006jL-00@gondolin.me.apana.org.au> <20060731105037.GA2073@2ka.mipt.ru> <20060731.035716.39159213.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060731.035716.39159213.davem@davemloft.net>
User-Agent: Mutt/1.5.9i
From: Herbert Xu <herbert@gondor.apana.org.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 31, 2006 at 03:57:16AM -0700, David Miller wrote:
> 
> So I would say for up to 4 or 5 events, system call overhead alone
> touches as many cache lines as the events themselves.

Absolutely.

The other to consider is that events don't come from the hardware.
Events are written by the kernel.  So if user-space is just reading
the events that we've written, then there are no cache misses at all.

Cheers,
-- 
Visit Openswan at http://www.openswan.org/
Email: Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
