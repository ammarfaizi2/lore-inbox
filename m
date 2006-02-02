Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750951AbWBBMTg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750951AbWBBMTg (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Feb 2006 07:19:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750950AbWBBMTg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Feb 2006 07:19:36 -0500
Received: from 22.107.233.220.exetel.com.au ([220.233.107.22]:18190 "EHLO
	arnor.apana.org.au") by vger.kernel.org with ESMTP id S1750949AbWBBMTf
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Feb 2006 07:19:35 -0500
Date: Thu, 2 Feb 2006 23:19:29 +1100
To: Ingo Molnar <mingo@elte.hu>
Cc: "David S. Miller" <davem@davemloft.net>, linux-kernel@vger.kernel.org
Subject: Re: [lock validator] inet6_destroy_sock(): soft-safe -> soft-unsafe lock dependency
Message-ID: <20060202121929.GB18620@gondor.apana.org.au>
References: <E1F2IcV-0007Iq-00@gondolin.me.apana.org.au> <20060128152204.GA13940@elte.hu> <20060131102758.GA31460@gondor.apana.org.au> <20060131.024323.83813817.davem@davemloft.net> <20060201133219.GA1435@elte.hu> <20060201202610.GA13107@gondor.apana.org.au> <20060202074627.GA6805@elte.hu> <20060202084824.GA17299@gondor.apana.org.au> <20060202105429.GA4895@elte.hu> <20060202112731.GA11603@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060202112731.GA11603@elte.hu>
User-Agent: Mutt/1.5.9i
From: Herbert Xu <herbert@gondor.apana.org.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 02, 2006 at 12:27:31PM +0100, Ingo Molnar wrote:
> 
> i think this might be a false positive, caused by my (ill-advised) 
> change below? [i did the change to clean up an unlock ordering 
> assymetry, but apparently i thus also introduced the xmit_lock -> 
> queue_lock dependency.]

As far as I can see your change can't cause the previous report,
unless the validator is treating the trylock in the same way as
a normal lock operation.

Cheers,
-- 
Visit Openswan at http://www.openswan.org/
Email: Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
