Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263802AbVBCUdk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263802AbVBCUdk (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Feb 2005 15:33:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263783AbVBCUck
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Feb 2005 15:32:40 -0500
Received: from arnor.apana.org.au ([203.14.152.115]:23569 "EHLO
	arnor.apana.org.au") by vger.kernel.org with ESMTP id S262757AbVBCUba
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Feb 2005 15:31:30 -0500
Date: Fri, 4 Feb 2005 07:30:10 +1100
To: Anton Blanchard <anton@samba.org>
Cc: Olaf Kirch <okir@suse.de>, netdev@oss.sgi.com,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arp_queue: serializing unlink + kfree_skb
Message-ID: <20050203203010.GA7081@gondor.apana.org.au>
References: <20050131102920.GC4170@suse.de> <E1CvZo6-0001Bz-00@gondolin.me.apana.org.au> <20050203142705.GA11318@krispykreme.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050203142705.GA11318@krispykreme.ozlabs.ibm.com>
User-Agent: Mutt/1.5.6+20040722i
From: Herbert Xu <herbert@gondor.apana.org.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 04, 2005 at 01:27:05AM +1100, Anton Blanchard wrote:
> 
> Architectures should guarantee that any of the atomics and bitops that
> return values order in both directions. So you dont need the
> smp_mb__before_atomic_dec here.

I wasn't aware of this requirement before.  However, if this is so,
why don't we get rid of the smp_mb__* macros?

Cheers,
-- 
Visit Openswan at http://www.openswan.org/
Email: Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
