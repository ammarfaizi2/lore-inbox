Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261599AbVFQDQV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261599AbVFQDQV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Jun 2005 23:16:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261902AbVFQDQV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Jun 2005 23:16:21 -0400
Received: from zeus2.kernel.org ([204.152.191.36]:62175 "EHLO zeus2.kernel.org")
	by vger.kernel.org with ESMTP id S261599AbVFQDQT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Jun 2005 23:16:19 -0400
From: Herbert Xu <herbert@gondor.apana.org.au>
To: hch@infradead.org (Christoph Hellwig)
Subject: Re: network driver disabled interrupts in PREEMPT_RT
Cc: mingo@elte.hu, kbenoit@opersys.com, linux-kernel@vger.kernel.org,
       davem@davemloft.net
Organization: Core
In-Reply-To: <20050613190310.GB4308@infradead.org>
X-Newsgroups: apana.lists.os.linux.kernel
User-Agent: tin/1.7.4-20040225 ("Benbecula") (UNIX) (Linux/2.4.27-hx-1-686-smp (i686))
Message-Id: <E1Dj6z8-0008RK-00@gondolin.me.apana.org.au>
Date: Fri, 17 Jun 2005 12:53:34 +1000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Hellwig <hch@infradead.org> wrote:
> On Mon, Jun 13, 2005 at 08:56:42PM +0200, Ingo Molnar wrote:
>> 
>> * Kristian Benoit <kbenoit@opersys.com> wrote:
>> 
>> > Hi,
>> > I got lots of these messages when accessing the net running
>> > 2.6.12-rc6-RT-V0.7.48-25 :
>> > 
>> > "network driver disabled interrupts: tg3_start_xmit+0x0/0x629 [tg3]"
>> > 
>> > it seem to come from net/sched/sch_generic.c.
>> 
>> does the patch below fix it?
> 
> Wouldn't it be much more useful to add spin_trylock_irq?

Dave has a patch pending that should remove these IRQ disabling calls.

Cheers,
-- 
Visit Openswan at http://www.openswan.org/
Email: Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
