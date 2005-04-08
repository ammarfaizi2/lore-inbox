Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262676AbVDHDvt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262676AbVDHDvt (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Apr 2005 23:51:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262678AbVDHDvt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Apr 2005 23:51:49 -0400
Received: from arnor.apana.org.au ([203.14.152.115]:47634 "EHLO
	arnor.apana.org.au") by vger.kernel.org with ESMTP id S262676AbVDHDvl
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Apr 2005 23:51:41 -0400
Date: Fri, 8 Apr 2005 13:50:52 +1000
To: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
Cc: akpm@osdl.org, guillaume.thouvenin@bull.net, greg@kroah.com,
       linux-kernel@vger.kernel.org, "David S. Miller" <davem@davemloft.net>
Subject: Re: [Fwd: Re: connector is missing in 2.6.12-rc2-mm1]
Message-ID: <20050408035052.GA31451@gondor.apana.org.au>
References: <E1DJjiR-000850-00@gondolin.me.apana.org.au> <1112931238.28858.180.camel@uganda> <20050408033246.GA31344@gondor.apana.org.au> <1112932354.28858.192.camel@uganda>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1112932354.28858.192.camel@uganda>
User-Agent: Mutt/1.5.6+20040907i
From: Herbert Xu <herbert@gondor.apana.org.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 08, 2005 at 07:52:34AM +0400, Evgeniy Polyakov wrote:
> On Fri, 2005-04-08 at 13:32 +1000, Herbert Xu wrote:
> > On Fri, Apr 08, 2005 at 07:33:58AM +0400, Evgeniy Polyakov wrote:
> > > On Fri, 2005-04-08 at 12:59 +1000, Herbert Xu wrote:
> > > > Evgeniy Polyakov <johnpol@2ka.mipt.ru> wrote:
> > > > >
> > > > > atomic_dec_and_test() is more expensive than 2 barriers + atomic_dec(),
> > > > > but in case of connector I think the price is not so high.
> > > > 
> > > > Can you list the platforms on which this is true?
> > > 
> > > sparc64, some mips [at least in UP].
> > 
> > Are you sure? The implementations of atomic_sub and atomic_sub_return
> > (which correspond to atomic_dec and atomic_dec_and_test) seem to be
> > comparable in cost on those two architectures.
> 
> mips has additional sync.

But atomic_dec + 2 barries is going to do the sync as well, no?

Cheers,
-- 
Visit Openswan at http://www.openswan.org/
Email: Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
