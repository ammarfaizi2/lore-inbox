Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261425AbVCYGfU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261425AbVCYGfU (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Mar 2005 01:35:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261439AbVCYGfU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Mar 2005 01:35:20 -0500
Received: from arnor.apana.org.au ([203.14.152.115]:12814 "EHLO
	arnor.apana.org.au") by vger.kernel.org with ESMTP id S261425AbVCYGfM
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Mar 2005 01:35:12 -0500
Date: Fri, 25 Mar 2005 17:33:33 +1100
To: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
Cc: Jeff Garzik <jgarzik@pobox.com>, David McCullough <davidm@snapgear.com>,
       cryptoapi@lists.logix.cz, linux-kernel@vger.kernel.org,
       linux-crypto@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       James Morris <jmorris@redhat.com>
Subject: Re: [PATCH] API for true Random Number Generators to add entropy (2.6.11)
Message-ID: <20050325063333.GA27939@gondor.apana.org.au>
References: <20050324132342.GD7115@beast> <1111671993.23532.115.camel@uganda> <42432972.5020906@pobox.com> <1111725282.23532.130.camel@uganda> <42439839.7060702@pobox.com> <1111728804.23532.137.camel@uganda> <4243A86D.6000408@pobox.com> <1111731361.20797.5.camel@uganda> <20050325061311.GA22959@gondor.apana.org.au> <1111732459.20797.16.camel@uganda>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1111732459.20797.16.camel@uganda>
User-Agent: Mutt/1.5.6+20040907i
From: Herbert Xu <herbert@gondor.apana.org.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 25, 2005 at 09:34:19AM +0300, Evgeniy Polyakov wrote:
>
> Such hardware is used mostly in embedded world where SW crypto
> processing
> is too expensive, so users of such HW likely want to trust to 
> theirs hardware and likely will turn in on.

That's fine.  All you need for these embedded users is a user-space
daemon that feeds data from the hardware directly into /dev/random.
No matter how small your system is, I'm sure you can spare a few
hundred bytes for such a thing.

In fact most of these systems will have some sort of a general-purpose
daemon that sits around which can perform such a task.

System calls on Linux are fast enough that there is really no
advantage in doing this in the kernel.

But if you're really desparate, write a kernel module that does this
in a kernel thread.
-- 
Visit Openswan at http://www.openswan.org/
Email: Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
