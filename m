Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261992AbVCGXiS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261992AbVCGXiS (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Mar 2005 18:38:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261557AbVCGXfx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Mar 2005 18:35:53 -0500
Received: from relay.2ka.mipt.ru ([194.85.82.65]:64720 "EHLO 2ka.mipt.ru")
	by vger.kernel.org with ESMTP id S261783AbVCGXB6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Mar 2005 18:01:58 -0500
Date: Tue, 8 Mar 2005 02:27:20 +0300
From: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
To: Nish Aravamudan <nish.aravamudan@gmail.com>
Cc: linux-kernel@vger.kernel.org, Fruhwirth Clemens <clemens@endorphin.org>,
       Herbert Xu <herbert@gondor.apana.org.au>, cryptoapi@lists.logix.cz,
       James Morris <jmorris@redhat.com>, David Miller <davem@davemloft.net>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [8/many] acrypto: crypto_dev.c
Message-ID: <20050308022720.023a7a2b@zanzibar.2ka.mipt.ru>
In-Reply-To: <29495f1d05030714515c44caf2@mail.gmail.com>
References: <11102278542733@2ka.mipt.ru>
	<1110227854480@2ka.mipt.ru>
	<29495f1d0503071440562f054@mail.gmail.com>
	<20050308021431.1313971a@zanzibar.2ka.mipt.ru>
	<29495f1d05030714515c44caf2@mail.gmail.com>
Reply-To: johnpol@2ka.mipt.ru
Organization: MIPT
X-Mailer: Sylpheed-Claws 0.9.12b (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.7.5 (2ka.mipt.ru [194.85.82.65]); Tue, 08 Mar 2005 02:01:17 +0300 (MSK)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 7 Mar 2005 14:51:21 -0800
Nish Aravamudan <nish.aravamudan@gmail.com> wrote:

> On Tue, 8 Mar 2005 02:14:31 +0300, Evgeniy Polyakov <johnpol@2ka.mipt.ru> wrote:
> > On Mon, 7 Mar 2005 14:40:52 -0800
> > Nish Aravamudan <nish.aravamudan@gmail.com> wrote:
> > 
> > > On Mon, 7 Mar 2005 23:37:34 +0300, Evgeniy Polyakov <johnpol@2ka.mipt.ru> wrote:
> > > > --- /tmp/empty/crypto_dev.c     1970-01-01 03:00:00.000000000 +0300
> > > > +++ ./acrypto/crypto_dev.c      2005-03-07 20:35:36.000000000 +0300
> > > > @@ -0,0 +1,421 @@
> > > > +/*
> > > > + *     crypto_dev.c
> > >
> > > <snip>
> > >
> > > > +                       while (atomic_read(&__dev->refcnt)) {
> 
> <snip>
> 
> > > > +                               set_current_state(TASK_UNINTERRUPTIBLE);
> > > > +                               schedule_timeout(HZ);
> > >
> > > I don't see any wait-queues in the immediate area of this code. Can
> > > this be an ssleep(1)?
> > 
> > Yes, you are right, this loop just spins until all pending sessions
> > are removed from given crypto device, so it can just ssleep(1) here.
> 
> Would you like me to send an incremental patch or will you be changing
> it yourself?

That would be nice to see your changes in the acrypto.
If it will be commited...

> Thanks,
> Nish


	Evgeniy Polyakov

Only failure makes us experts. -- Theo de Raadt
