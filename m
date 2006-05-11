Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965202AbWEKIFD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965202AbWEKIFD (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 May 2006 04:05:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965204AbWEKIFD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 May 2006 04:05:03 -0400
Received: from rhun.apana.org.au ([64.62.148.172]:23047 "EHLO
	arnor.apana.org.au") by vger.kernel.org with ESMTP id S965202AbWEKIFB
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 May 2006 04:05:01 -0400
Date: Thu, 11 May 2006 18:04:43 +1000
To: Keir Fraser <Keir.Fraser@cl.cam.ac.uk>
Cc: xen-devel@lists.xensource.com, ian.pratt@xensource.com, rdreier@cisco.com,
       linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
       Andi Kleen <ak@suse.de>, virtualization@lists.osdl.org,
       chrisw@sous-sol.org, shemminger@osdl.org
Subject: Re: [RFC PATCH 34/35] Add the Xen virtual network device driver.
Message-ID: <20060511080443.GB29704@gondor.apana.org.au>
References: <E1Fdz7v-0007zc-00@gondolin.me.apana.org.au> <fb99d7085b85310ef7d423a8f135db32@cl.cam.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fb99d7085b85310ef7d423a8f135db32@cl.cam.ac.uk>
User-Agent: Mutt/1.5.9i
From: Herbert Xu <herbert@gondor.apana.org.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 11, 2006 at 08:49:04AM +0100, Keir Fraser wrote:
> 
> The alternatives are unattractive:
>  1. We have no good way to distinguish interrupts caused by packets 
> from local VMs versus packets from remote hosts. Both get muxed on the 
> same virtual interface.
>  2. An entropy front/back is tricky -- how do we decide how much 
> entropy to pull from domain0? How much should domain0 be prepared to 
> give other domains? How easy is it to DoS domain0 by draining its 
> entropy pool? Yuk.

IMHO there just isn't enough real entropy to go around in one physical
machine without a proper HRNG.  So either use urandom in all the guests
or for those that really have to use /dev/random, install a hardware
RNG (or wait for it :).

Cheers,
-- 
Visit Openswan at http://www.openswan.org/
Email: Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
