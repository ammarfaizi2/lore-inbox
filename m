Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265670AbSKODJN>; Thu, 14 Nov 2002 22:09:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265677AbSKODJN>; Thu, 14 Nov 2002 22:09:13 -0500
Received: from marcie.netcarrier.net ([216.178.72.21]:50704 "HELO
	marcie.netcarrier.net") by vger.kernel.org with SMTP
	id <S265670AbSKODJM>; Thu, 14 Nov 2002 22:09:12 -0500
Message-ID: <3DD46876.66725D8E@compuserve.com>
Date: Thu, 14 Nov 2002 22:22:30 -0500
From: Kevin Brosius <cobra@compuserve.com>
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.16-4GB i586)
X-Accept-Language: en
MIME-Version: 1.0
To: Jens Axboe <axboe@suse.de>
CC: "David S. Miller" <davem@redhat.com>,
       kernel <linux-kernel@vger.kernel.org>
Subject: Re: bk current build failures (xfrm.h / tpqic02.c)
References: <3DD2F0FF.D1306F88@compuserve.com> <1037247457.10978.2.camel@rth.ninka.net> <20021114123440.GK847@suse.de>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jens Axboe wrote:
> 
> 
> On Wed, Nov 13 2002, David S. Miller wrote:
> > On Wed, 2002-11-13 at 16:40, Kevin Brosius wrote:
> > > net/core/skbuff.c: At top level:
> > > include/net/xfrm.h:104: storage size of `lft' isn't known
> > > include/net/xfrm.h:112: storage size of `replay' isn't known
> > > include/net/xfrm.h:115: storage size of `stats' isn't known
> > > include/net/xfrm.h:117: storage size of `curlft' isn't known
> > > make[2]: *** [net/core/skbuff.o] Error 1
> >
> > Something is wrong with your tree, net/xfrm.h includes linux/xfrm.h
> > which declares the layout of said structures the compiler is
> > complaining about.
> 
> Most likely he is building out of his bk tree and he forgot to bk get
> the files again.

Yes, that's it.  Thank you, and sorry about that.  (I'll go configure
for checkout-get mode now...)

Now I see:
drivers/char/tpqic02.c: In function `__initfn':
drivers/char/tpqic02.c:2798: parse error before "void"
make[2]: *** [drivers/char/tpqic02.o] Error 1

I'm guessing that may be fixed in 2.5.47-ac2[&4]?

-- 
Kevin
