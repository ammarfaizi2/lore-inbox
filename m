Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932360AbWHZAAl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932360AbWHZAAl (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Aug 2006 20:00:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932336AbWHZAAk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Aug 2006 20:00:40 -0400
Received: from rhun.apana.org.au ([64.62.148.172]:12558 "EHLO
	arnor.apana.org.au") by vger.kernel.org with ESMTP id S932293AbWHZAAj
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Aug 2006 20:00:39 -0400
Date: Sat, 26 Aug 2006 09:59:41 +1000
To: Stephen Hemminger <shemminger@osdl.org>
Cc: Thomas Glanzmann <sithglan@stud.uni-erlangen.de>,
       "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] IPV6 : segmentation offload not set correctly on TCP children
Message-ID: <20060825235940.GA13086@gondor.apana.org.au>
References: <20060821212243.GA1558@cip.informatik.uni-erlangen.de> <20060821150231.31a947d4@localhost.localdomain> <20060821222634.GC21790@cip.informatik.uni-erlangen.de> <20060825154353.3ecaf508@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060825154353.3ecaf508@localhost.localdomain>
User-Agent: Mutt/1.5.9i
From: Herbert Xu <herbert@gondor.apana.org.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 25, 2006 at 03:43:53PM -0700, Stephen Hemminger wrote:
> TCP over IPV6 would incorrectly inherit the GSO settings.
> This would cause kernel to send Tcp Segmentation Offload packets for
> IPV6 data to devices that can't handle it. It caused the sky2 driver
> to lock http://bugzilla.kernel.org/show_bug.cgi?id=7050
> and the e1000 would generate bogus packets. I can't blame the
> hardware for gagging if the upper layers feed it garbage.
> 
> This was a new bug in 2.6.18 introduced with GSO support.
> 
> Signed-off-by: Stephen Hemminger <shemminger@osdl.org>

Thanks for catching this Stephen!

Cheers,
-- 
Visit Openswan at http://www.openswan.org/
Email: Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
