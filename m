Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278902AbRJ2AEh>; Sun, 28 Oct 2001 19:04:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278904AbRJ2AE1>; Sun, 28 Oct 2001 19:04:27 -0500
Received: from chac.inf.utfsm.cl ([200.1.19.54]:63494 "EHLO chac.inf.utfsm.cl")
	by vger.kernel.org with ESMTP id <S278902AbRJ2AEM>;
	Sun, 28 Oct 2001 19:04:12 -0500
Message-Id: <200110282357.f9SNv2kD011923@sleipnir.valparaiso.cl>
To: Andreas Dilger <adilger@turbolabs.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] random.c bugfix 
In-Reply-To: Message from Andreas Dilger <adilger@turbolabs.com> 
   of "Sat, 27 Oct 2001 00:21:42 MDT." <20011027002142.D23590@turbolinux.com> 
Date: Sun, 28 Oct 2001 20:57:02 -0300
From: Horst von Brand <vonbrand@sleipnir.valparaiso.cl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andreas Dilger <adilger@turbolabs.com> said:

[...]

> OK, my bad.  At least the random variable-name cleanups let you SEE where
> we are supposed to be using word sizes and byte sizes.  Even you were
> confused about it ;-)

I have now seen various bits and pieces about this flying around. To get it
right will be hard, as over/under estimates will show up only under unusual
circumstances; and as you _can't_ really know how much "entropy" there
should be, testing this is very hard.  So the only way to get it right is
make it "obviously" right.

How hard would it be to change the API to talk _all_ in the same units, be
it bits, bytes, words, or whatever? I believe bits or bytes would be best,
as word sizes differ. Bytes have the advantage that a simple sizeof() will
give size in bytes for any random variable.
-- 
Horst von Brand                             vonbrand@sleipnir.valparaiso.cl
Casilla 9G, Vin~a del Mar, Chile                               +56 32 672616

