Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262030AbTERMdO (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 May 2003 08:33:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262031AbTERMdO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 May 2003 08:33:14 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:41928 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S262030AbTERMdN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 May 2003 08:33:13 -0400
Date: Sun, 18 May 2003 14:46:03 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: James Morris <jmorris@intercode.com.au>
Cc: Herbert Xu <herbert@gondor.apana.org.au>, davem@redhat.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Added missing dependencies on CRYPTO_HMAC
Message-ID: <20030518124603.GA12766@fs.tum.de>
References: <20030518031546.GA4943@gondor.apana.org.au> <Mutt.LNX.4.44.0305181334280.21675-100000@excalibur.intercode.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Mutt.LNX.4.44.0305181334280.21675-100000@excalibur.intercode.com.au>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 18, 2003 at 01:40:28PM +1000, James Morris wrote:
> On Sun, 18 May 2003, Herbert Xu wrote:
> 
> > On Sun, May 18, 2003 at 12:19:09PM +1000, James Morris wrote:
> > > 
> > > See crypto/Kconfig, CRYPTO_HMAC is being defaulted to Y if these protocols 
> > > are selected.
> > 
> > Yes, but the user can then set them to no.  This does happen as the
> > Crypto menu is listed after Networking so someone going through it
> > in that order can select INET_AH and then go on to disable Crypto.
> 
> Yes, we allow users to override the defaults if they wish, at their own 
> peril.
> 
> > Dependencies are there to prevent these things from happening.
> 
> Using dependencies would mean that the ipsec protocols would not appear in 
> the networking menu until after selecting the correct algorthims in the 
> crypto menu.
> 
> How would users know what the minimally required set of algorithms are?  
> Would they then know to go _back_ to the networking menu to enable the
> protocols?

It seems the cryptographic options don't depend on anything else. What 
about Herbert's patch plus moving the crypto menu above network support?

> - James

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

