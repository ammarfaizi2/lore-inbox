Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261276AbVCHBlC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261276AbVCHBlC (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Mar 2005 20:41:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261822AbVCHBgy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Mar 2005 20:36:54 -0500
Received: from rproxy.gmail.com ([64.233.170.199]:4164 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261825AbVCGWvV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Mar 2005 17:51:21 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=nfJwLbiB74dm580hxryNceCVSEfIiVzPP5DrX2TcYxxLUHvPwzON4o3x5QfSmxLkxkc8Nq7zu1CoqvIFVHC/APQj1SqRNFT3xtEiOUpE8i0paJMCEDwNFPNkKvHu/kX1ECG4nyZxOMSk8yX8vaZY5FWSyifLXKCow9mT7sLbomo=
Message-ID: <29495f1d05030714515c44caf2@mail.gmail.com>
Date: Mon, 7 Mar 2005 14:51:21 -0800
From: Nish Aravamudan <nish.aravamudan@gmail.com>
Reply-To: Nish Aravamudan <nish.aravamudan@gmail.com>
To: johnpol@2ka.mipt.ru
Subject: Re: [8/many] acrypto: crypto_dev.c
Cc: linux-kernel@vger.kernel.org, Fruhwirth Clemens <clemens@endorphin.org>,
       Herbert Xu <herbert@gondor.apana.org.au>, cryptoapi@lists.logix.cz,
       James Morris <jmorris@redhat.com>, David Miller <davem@davemloft.net>,
       Andrew Morton <akpm@osdl.org>
In-Reply-To: <20050308021431.1313971a@zanzibar.2ka.mipt.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <11102278542733@2ka.mipt.ru> <1110227854480@2ka.mipt.ru>
	 <29495f1d0503071440562f054@mail.gmail.com>
	 <20050308021431.1313971a@zanzibar.2ka.mipt.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 8 Mar 2005 02:14:31 +0300, Evgeniy Polyakov <johnpol@2ka.mipt.ru> wrote:
> On Mon, 7 Mar 2005 14:40:52 -0800
> Nish Aravamudan <nish.aravamudan@gmail.com> wrote:
> 
> > On Mon, 7 Mar 2005 23:37:34 +0300, Evgeniy Polyakov <johnpol@2ka.mipt.ru> wrote:
> > > --- /tmp/empty/crypto_dev.c     1970-01-01 03:00:00.000000000 +0300
> > > +++ ./acrypto/crypto_dev.c      2005-03-07 20:35:36.000000000 +0300
> > > @@ -0,0 +1,421 @@
> > > +/*
> > > + *     crypto_dev.c
> >
> > <snip>
> >
> > > +                       while (atomic_read(&__dev->refcnt)) {

<snip>

> > > +                               set_current_state(TASK_UNINTERRUPTIBLE);
> > > +                               schedule_timeout(HZ);
> >
> > I don't see any wait-queues in the immediate area of this code. Can
> > this be an ssleep(1)?
> 
> Yes, you are right, this loop just spins until all pending sessions
> are removed from given crypto device, so it can just ssleep(1) here.

Would you like me to send an incremental patch or will you be changing
it yourself?

Thanks,
Nish
