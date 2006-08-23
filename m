Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965155AbWHWTnf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965155AbWHWTnf (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Aug 2006 15:43:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965154AbWHWTnf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Aug 2006 15:43:35 -0400
Received: from relay.2ka.mipt.ru ([194.85.82.65]:38357 "EHLO 2ka.mipt.ru")
	by vger.kernel.org with ESMTP id S965152AbWHWTn1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Aug 2006 15:43:27 -0400
Date: Wed, 23 Aug 2006 23:42:20 +0400
From: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
To: Grzegorz Kulewski <kangur@polcom.net>
Cc: lkml <linux-kernel@vger.kernel.org>, David Miller <davem@davemloft.net>,
       Ulrich Drepper <drepper@redhat.com>, Andrew Morton <akpm@osdl.org>,
       netdev <netdev@vger.kernel.org>, Zach Brown <zach.brown@oracle.com>,
       Christoph Hellwig <hch@infradead.org>
Subject: Re: [take13 0/3] kevent: Generic event handling mechanism.
Message-ID: <20060823194220.GA27685@2ka.mipt.ru>
References: <11563322941645@2ka.mipt.ru> <Pine.LNX.4.63.0608231313370.8007@alpha.polcom.net> <20060823122509.GA5744@2ka.mipt.ru> <Pine.LNX.4.63.0608231437170.8007@alpha.polcom.net> <20060823134227.GC29056@2ka.mipt.ru> <20060823185624.GA8438@2ka.mipt.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
In-Reply-To: <20060823185624.GA8438@2ka.mipt.ru>
User-Agent: Mutt/1.5.9i
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.7.5 (2ka.mipt.ru [0.0.0.0]); Wed, 23 Aug 2006 23:42:22 +0400 (MSD)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 23, 2006 at 10:56:24PM +0400, Evgeniy Polyakov (johnpol@2ka.mipt.ru) wrote:
> > It can be done by selecting special event type, which in turn will reuse
> > special fields as length.
> > But variable-sized members can not be put into cache and without
> > knowledge of it's size it is impossible to put htem into mapped buffer.
> 
> And thinking more about this issue, I can say that I'm again
> variable-sized structures - they can not be placed into ring buffer (at
> least into simple one), they do not allow allocation from cache, it is
> impossible to get them correctly from userspace if there is now exact
> knowledge about nature of that events and a lot of other problems.
> If one strongly feels that it is required, it is possible to provide
> userspace pointer in the ukevent structure, which then can be read in
> ->enqueue callback by kernelside (there is similar trick in network
> AIO).

I've reread my text - sorry for tons of errors, I use extremely slow
GPRS link, so it is almost impossible to return and correct errors using
it, I think it is simple to understand what I meant :)

-- 
	Evgeniy Polyakov
