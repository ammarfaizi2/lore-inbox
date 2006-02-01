Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161112AbWBAU0Y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161112AbWBAU0Y (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Feb 2006 15:26:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161113AbWBAU0X
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Feb 2006 15:26:23 -0500
Received: from 22.107.233.220.exetel.com.au ([220.233.107.22]:11027 "EHLO
	arnor.apana.org.au") by vger.kernel.org with ESMTP id S1161112AbWBAU0X
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Feb 2006 15:26:23 -0500
Date: Thu, 2 Feb 2006 07:26:10 +1100
To: Ingo Molnar <mingo@elte.hu>
Cc: "David S. Miller" <davem@davemloft.net>, linux-kernel@vger.kernel.org
Subject: Re: [lock validator] inet6_destroy_sock(): soft-safe -> soft-unsafe lock dependency
Message-ID: <20060201202610.GA13107@gondor.apana.org.au>
References: <E1F2IcV-0007Iq-00@gondolin.me.apana.org.au> <20060128152204.GA13940@elte.hu> <20060131102758.GA31460@gondor.apana.org.au> <20060131.024323.83813817.davem@davemloft.net> <20060201133219.GA1435@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060201133219.GA1435@elte.hu>
User-Agent: Mutt/1.5.9i
From: Herbert Xu <herbert@gondor.apana.org.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 01, 2006 at 02:32:19PM +0100, Ingo Molnar wrote:
> 
> update: with all of Herbert's fixes i havent gotten these yet - so maybe 
> the validator was not producing a false positive, but perhaps the 
> inet6_destroy_sock()->sk_dst_reset() thing was causing the messages?

Maybe.  But in that case shouldn't the validator show that code-path?

Cheers,
-- 
Visit Openswan at http://www.openswan.org/
Email: Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
