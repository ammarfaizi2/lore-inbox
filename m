Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932550AbWFHHUK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932550AbWFHHUK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jun 2006 03:20:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932525AbWFHHUK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jun 2006 03:20:10 -0400
Received: from mout2.freenet.de ([194.97.50.155]:10883 "EHLO mout2.freenet.de")
	by vger.kernel.org with ESMTP id S932505AbWFHHUJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Jun 2006 03:20:09 -0400
From: Joachim Fritschi <jfritschi@freenet.de>
To: Herbert Xu <herbert@gondor.apana.org.au>
Subject: Re: [PATCH  1/4] Twofish cipher - split out common c code
Date: Thu, 8 Jun 2006 09:20:04 +0200
User-Agent: KMail/1.9.1
Cc: linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org, ak@suse.de
References: <200606041516.21967.jfritschi@freenet.de> <200606072137.24176.jfritschi@freenet.de> <20060608015728.GA8314@gondor.apana.org.au>
In-Reply-To: <20060608015728.GA8314@gondor.apana.org.au>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200606080920.04480.jfritschi@freenet.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 08 June 2006 03:57, Herbert Xu wrote:
> On Wed, Jun 07, 2006 at 09:37:23PM +0200, Joachim Fritschi wrote:
> > 
> > diff -uprN linux-2.6.17-rc5/crypto/Makefile linux-2.6.17-rc5.twofish/crypto/Makefile
> > --- linux-2.6.17-rc5/crypto/Makefile	2006-06-07 18:43:24.000000000 +0200
> > +++ linux-2.6.17-rc5.twofish/crypto/Makefile	2006-06-04 13:59:27.949797218 +0200
> > @@ -32,3 +32,5 @@ obj-$(CONFIG_CRYPTO_MICHAEL_MIC) += mich
> >  obj-$(CONFIG_CRYPTO_CRC32C) += crc32c.o
> >  
> >  obj-$(CONFIG_CRYPTO_TEST) += tcrypt.o
> > +
> > +twofish-objs := twofish_c.o twofish_common.o
> 
> What do we gain by renaming twofish.c to twofish_c.c?

Solve the naming conflict when compiling. Seemed to me like it is impossible to create a
twofish.o out of twofish.o and twofish_common.o . And since having the original module name
seemed more important to me i changed the name. I didn't find any other way in documentation
of the kernel makefiles. I hope this isn't another newbie mistake. =)

-Joachim
