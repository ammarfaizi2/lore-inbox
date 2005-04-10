Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261457AbVDJJ4E@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261457AbVDJJ4E (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Apr 2005 05:56:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261459AbVDJJ4E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Apr 2005 05:56:04 -0400
Received: from arnor.apana.org.au ([203.14.152.115]:51217 "EHLO
	arnor.apana.org.au") by vger.kernel.org with ESMTP id S261457AbVDJJz4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Apr 2005 05:55:56 -0400
From: Herbert Xu <herbert@gondor.apana.org.au>
To: johnpol@2ka.mipt.ru
Subject: Re: [Fwd: Re: connector is missing in 2.6.12-rc2-mm1]
Cc: jmorris@redhat.com, kay.sievers@vrfy.org, ijc@hellion.org.uk,
       guillaume.thouvenin@bull.net, greg@kroah.com,
       linux-kernel@vger.kernel.org, akpm@osdl.org, netdev@oss.sgi.com
Organization: Core
In-Reply-To: <1112942924.28858.234.camel@uganda>
X-Newsgroups: apana.lists.os.linux.kernel
User-Agent: tin/1.7.4-20040225 ("Benbecula") (UNIX) (Linux/2.4.27-hx-1-686-smp (i686))
Message-Id: <E1DKZ7e-00070D-00@gondolin.me.apana.org.au>
Date: Sun, 10 Apr 2005 19:52:54 +1000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Please add netdev to the CC list since this discussion pertains to
the networking subsystem.

Evgeniy Polyakov <johnpol@2ka.mipt.ru> wrote:
> 
> User should not know about low-level transport - 
> it is like socket layer -  write only data and do not care about
> how it will be delivered.

The delineation between transport and upper layer is fuzzy.
In one situation the protocol might be transport and in another
it could be above the transport.

So I don't buy this argument.
 
> In the previous versions netlink group was assigned as incremented
> counter, 
> that was not convenient, but now we have 2-way ID, which is better
> from users point of view - idx is supposed to be major id, val - 
> some subsystem of that set.

Actually netlink does let you bind to a specific ID.

Of course you may argue that a single u32 is not enough.  However,
nothing is stopping you from introducing netlink v2 that extends
this.

In fact this is my main gripe with your patch: Why aren't you
extending netlink instead of hacking something on top of the existing
netlink? If the extensions require breaking compatibility: Fine,
you just need to call it netlink v2.

Cheers,
-- 
Visit Openswan at http://www.openswan.org/
Email: Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
