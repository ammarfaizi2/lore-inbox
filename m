Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261927AbTERD3U (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 May 2003 23:29:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261928AbTERD3U
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 May 2003 23:29:20 -0400
Received: from blackbird.intercode.com.au ([203.32.101.10]:52489 "EHLO
	blackbird.intercode.com.au") by vger.kernel.org with ESMTP
	id S261927AbTERD3T (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 May 2003 23:29:19 -0400
Date: Sun, 18 May 2003 13:40:28 +1000 (EST)
From: James Morris <jmorris@intercode.com.au>
To: Herbert Xu <herbert@gondor.apana.org.au>
cc: davem@redhat.com, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Added missing dependencies on CRYPTO_HMAC
In-Reply-To: <20030518031546.GA4943@gondor.apana.org.au>
Message-ID: <Mutt.LNX.4.44.0305181334280.21675-100000@excalibur.intercode.com.au>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 18 May 2003, Herbert Xu wrote:

> On Sun, May 18, 2003 at 12:19:09PM +1000, James Morris wrote:
> > 
> > See crypto/Kconfig, CRYPTO_HMAC is being defaulted to Y if these protocols 
> > are selected.
> 
> Yes, but the user can then set them to no.  This does happen as the
> Crypto menu is listed after Networking so someone going through it
> in that order can select INET_AH and then go on to disable Crypto.

Yes, we allow users to override the defaults if they wish, at their own 
peril.

> Dependencies are there to prevent these things from happening.

Using dependencies would mean that the ipsec protocols would not appear in 
the networking menu until after selecting the correct algorthims in the 
crypto menu.

How would users know what the minimally required set of algorithms are?  
Would they then know to go _back_ to the networking menu to enable the
protocols?


- James
-- 
James Morris
<jmorris@intercode.com.au>

