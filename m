Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261471AbVCYG6l@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261471AbVCYG6l (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Mar 2005 01:58:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261461AbVCYG6k
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Mar 2005 01:58:40 -0500
Received: from arnor.apana.org.au ([203.14.152.115]:43790 "EHLO
	arnor.apana.org.au") by vger.kernel.org with ESMTP id S261448AbVCYG6h
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Mar 2005 01:58:37 -0500
Date: Fri, 25 Mar 2005 17:56:22 +1100
To: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
Cc: Jeff Garzik <jgarzik@pobox.com>, David McCullough <davidm@snapgear.com>,
       cryptoapi@lists.logix.cz, linux-kernel@vger.kernel.org,
       linux-crypto@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       James Morris <jmorris@redhat.com>
Subject: Re: [PATCH] API for true Random Number Generators to add entropy (2.6.11)
Message-ID: <20050325065622.GA31127@gondor.apana.org.au>
References: <42432972.5020906@pobox.com> <1111725282.23532.130.camel@uganda> <42439839.7060702@pobox.com> <1111728804.23532.137.camel@uganda> <4243A86D.6000408@pobox.com> <1111731361.20797.5.camel@uganda> <20050325061311.GA22959@gondor.apana.org.au> <1111732459.20797.16.camel@uganda> <20050325063333.GA27939@gondor.apana.org.au> <1111733958.20797.30.camel@uganda>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1111733958.20797.30.camel@uganda>
User-Agent: Mutt/1.5.6+20040907i
From: Herbert Xu <herbert@gondor.apana.org.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 25, 2005 at 09:59:18AM +0300, Evgeniy Polyakov wrote:
> 
> It is not only about userspace/kernelspace system calls and data
> copying,
> but about whole revalidation process, which can and is quite expensive,
> due to system calls, copying and validating itself,

What I meant is if you don't need the revalidation then don't do it.
That's the advantage of having it in user-space, *you* get to decide,
not us.

> And what about initial bootup? When system needs to create randoom
> IP/dhcp/any ids? What about small router?

Let's not reinvent the wheel, this is exactly what initramfs is for.
-- 
Visit Openswan at http://www.openswan.org/
Email: Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
