Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262005AbVCGX52@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262005AbVCGX52 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Mar 2005 18:57:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261916AbVCGXzV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Mar 2005 18:55:21 -0500
Received: from relay.2ka.mipt.ru ([194.85.82.65]:52441 "EHLO 2ka.mipt.ru")
	by vger.kernel.org with ESMTP id S261895AbVCGXj7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Mar 2005 18:39:59 -0500
Date: Tue, 8 Mar 2005 03:05:37 +0300
From: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
To: "Randy.Dunlap" <rddunlap@osdl.org>
Cc: linux-kernel@vger.kernel.org, Fruhwirth Clemens <clemens@endorphin.org>,
       Herbert Xu <herbert@gondor.apana.org.au>, cryptoapi@lists.logix.cz,
       James Morris <jmorris@redhat.com>, David Miller <davem@davemloft.net>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [8/many] acrypto: crypto_dev.c
Message-ID: <20050308030537.4608f026@zanzibar.2ka.mipt.ru>
In-Reply-To: <422CE5BA.9040209@osdl.org>
References: <1110227854480@2ka.mipt.ru>
	<422CE5BA.9040209@osdl.org>
Reply-To: johnpol@2ka.mipt.ru
Organization: MIPT
X-Mailer: Sylpheed-Claws 0.9.12b (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.7.5 (2ka.mipt.ru [194.85.82.65]); Tue, 08 Mar 2005 02:39:34 +0300 (MSK)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 07 Mar 2005 15:37:30 -0800
"Randy.Dunlap" <rddunlap@osdl.org> wrote:

> Evgeniy Polyakov wrote:
> > --- /tmp/empty/crypto_dev.c	1970-01-01 03:00:00.000000000 +0300
> > +++ ./acrypto/crypto_dev.c	2005-03-07 20:35:36.000000000 +0300
> > @@ -0,0 +1,421 @@
> > +/*
> > + * 	crypto_dev.c
> > + *
> > + * Copyright (c) 2004 Evgeniy Polyakov <johnpol@2ka.mipt.ru>
> 
> > +#include <linux/kernel.h>
> > +#include <linux/module.h>
> > +#include <linux/moduleparam.h>
> > +#include <linux/types.h>
> > +#include <linux/list.h>
> > +#include <linux/slab.h>
> > +#include <linux/interrupt.h>
> > +#include <linux/spinlock.h>
> > +#include <linux/device.h>
> 
> In alpha order as much as possible, please.

As far as I remember, some must be first, like kernel.h and module.h,
but I will try to follow alphabet order.

> > +#include "acrypto.h"
> > +
> > +static LIST_HEAD(cdev_list);
> > +static spinlock_t cdev_lock = SPIN_LOCK_UNLOCKED;
> 
> DEFINE_SPINLOCK(cdev_lock);

Yep, I suspect some other files also need that.

Will put it into TODO queue.
 
> -- 
> ~Randy


	Evgeniy Polyakov

Only failure makes us experts. -- Theo de Raadt
