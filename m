Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262286AbVC2KZE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262286AbVC2KZE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Mar 2005 05:25:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262274AbVC2KYg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Mar 2005 05:24:36 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:57505 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S262286AbVC2KXc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Mar 2005 05:23:32 -0500
Date: Tue, 29 Mar 2005 12:23:14 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: Evgeniy Polyakov <johnpol@2ka.mipt.ru>, Jeff Garzik <jgarzik@pobox.com>,
       David McCullough <davidm@snapgear.com>, cryptoapi@lists.logix.cz,
       linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>, James Morris <jmorris@redhat.com>
Subject: Re: [PATCH] API for true Random Number Generators to add entropy (2.6.11)
Message-ID: <20050329102314.GC6496@elf.ucw.cz>
References: <1111728804.23532.137.camel@uganda> <4243A86D.6000408@pobox.com> <1111731361.20797.5.camel@uganda> <20050325061311.GA22959@gondor.apana.org.au> <1111732459.20797.16.camel@uganda> <20050325063333.GA27939@gondor.apana.org.au> <1111733958.20797.30.camel@uganda> <20050325065622.GA31127@gondor.apana.org.au> <1111735195.20797.42.camel@uganda> <20050325072531.GA416@gondor.apana.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20050325072531.GA416@gondor.apana.org.au>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

On Pá 25-03-05 18:25:31, Herbert Xu wrote:
> On Fri, Mar 25, 2005 at 10:19:55AM +0300, Evgeniy Polyakov wrote:
> > 
> > Noone will complain on Linux if NIC is broken and produces wrong
> > checksum
> > and HW checksum offloading is enabled using ethtools.
> 
> This is completely different.  The worst that can happen with checksum
> offloading is that the packet is dropped.  That's something people deal
> with on a daily basis since the Internet as a whole does not guarantee
> the delivery of packets.
> 
> On the other hand, /dev/random is something that has always promised
> to deliver random numbers that are totally unpredictable.  People out
> there *depend* on this.
> 
> If that assumption is violated the result could be catastrophic.

Yes, and we had huge security hole where it sometimes gave same random
data to two different processes on smp, and noone noticed for 10
years.... /dev/random is not as critical as you paint it.

								Pavel
-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
