Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261878AbVCHANW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261878AbVCHANW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Mar 2005 19:13:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262019AbVCHAMx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Mar 2005 19:12:53 -0500
Received: from relay.2ka.mipt.ru ([194.85.82.65]:8160 "EHLO 2ka.mipt.ru")
	by vger.kernel.org with ESMTP id S261294AbVCHAIr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Mar 2005 19:08:47 -0500
Date: Tue, 8 Mar 2005 03:34:17 +0300
From: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
To: "Randy.Dunlap" <rddunlap@osdl.org>
Cc: linux-kernel@vger.kernel.org, Fruhwirth Clemens <clemens@endorphin.org>,
       Herbert Xu <herbert@gondor.apana.org.au>, cryptoapi@lists.logix.cz,
       James Morris <jmorris@redhat.com>, David Miller <davem@davemloft.net>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [3/many] acrypto: acrypto.h
Message-ID: <20050308033417.6a241235@zanzibar.2ka.mipt.ru>
In-Reply-To: <422CE8C4.8010500@osdl.org>
References: <11102278533380@2ka.mipt.ru>
	<422CE8C4.8010500@osdl.org>
Reply-To: johnpol@2ka.mipt.ru
Organization: MIPT
X-Mailer: Sylpheed-Claws 0.9.12b (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.7.5 (2ka.mipt.ru [194.85.82.65]); Tue, 08 Mar 2005 03:08:16 +0300 (MSK)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 07 Mar 2005 15:50:28 -0800
"Randy.Dunlap" <rddunlap@osdl.org> wrote:

> Evgeniy Polyakov wrote:
> > --- /tmp/empty/acrypto.h	1970-01-01 03:00:00.000000000 +0300
> > +++ ./acrypto/acrypto.h	2005-03-07 20:35:36.000000000 +0300
> > @@ -0,0 +1,245 @@
> > +/*
> > + * 	acrypto.h
> > + *
> > + * Copyright (c) 2004 Evgeniy Polyakov <johnpol@2ka.mipt.ru>
> > + * 
> > + */
> > +
> > +#ifdef __KERNEL__
> > +
> > +#define SESSION_COMPLETED	(1<<15)
> > +#define SESSION_FINISHED	(1<<14)
> > +#define SESSION_STARTED		(1<<13)
> > +#define SESSION_PROCESSED	(1<<12)
> > +#define SESSION_BINDED		(1<<11)
> Just a thought:  SESSION_BOUND  ??
> 
> > +#define SESSION_BROKEN		(1<<10)
> > +#define SESSION_FROM_CACHE	(1<<9)
> > +
> > +#define DEVICE_BROKEN		(1<<0)
> > +
> > +#define device_broken(dev)	(dev->flags & DEVICE_BROKEN)
> > +#define broke_device(dev)	do {dev->flags |= DEVICE_BROKEN;} while(0)
>             break_device(dev)

Mdaa, my spelling is quite broken in some places...

> > +int match_initializer(struct crypto_device *, struct crypto_session_initializer *);
> > +int __match_initializer(struct crypto_capability *, struct crypto_session_initializer *);
> > +
> > +#endif				/* __KERNEL__ */
> > +#endif				/* __ACRYPTO_H */
> 
> Several of these could use some namespace_idents on them (SESSION_xyz,
> DEVICE_xyz, device_xyz, match_xyz)...

Hmm, I think I'm not following...

> -- 
> ~Randy


	Evgeniy Polyakov

Only failure makes us experts. -- Theo de Raadt
