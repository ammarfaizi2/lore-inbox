Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932734AbWCQN7q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932734AbWCQN7q (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Mar 2006 08:59:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932720AbWCQN7q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Mar 2006 08:59:46 -0500
Received: from mail15.syd.optusnet.com.au ([211.29.132.196]:31417 "EHLO
	mail15.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S932734AbWCQN7o (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Mar 2006 08:59:44 -0500
From: Con Kolivas <kernel@kolivas.org>
To: Andreas Mohr <andi@rhlx01.fht-esslingen.de>
Subject: Re: [ck] Re: [PATCH] sched: activate SCHED BATCH expired
Date: Sat, 18 Mar 2006 00:59:27 +1100
User-Agent: KMail/1.9.1
Cc: Nick Piggin <nickpiggin@yahoo.com.au>, ck@vds.kolivas.org,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
References: <200603081013.44678.kernel@kolivas.org> <200603180036.11326.kernel@kolivas.org> <20060317134740.GA7121@rhlx01.fht-esslingen.de>
In-Reply-To: <20060317134740.GA7121@rhlx01.fht-esslingen.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200603180059.28271.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 18 March 2006 00:47, Andreas Mohr wrote:
> Hi,
>
> On Sat, Mar 18, 2006 at 12:36:10AM +1100, Con Kolivas wrote:
> > I'm not attached to the style, just the feature. If you think it's
> > warranted I'll change it.
>
> Seconded.
>
> An even nicer way (this solution seems somewhat asymmetric) than
>
>    prio_array_t *target = rq->active;
>    if (batch_task(p))
>      target = rq->expired;
>    enqueue_task(p, target);
>
> may be
>
>    prio_array_t *target;
>    if (batch_task(p))
>      target = rq->expired;
>    else
>      target = rq->active;
>    enqueue_task(p, target);

Well I hadn't quite gone to bed so I tried yours for grins too and 
interestingly it produced the identical code to my original version.

> But this discussion is clearly growing out of control now ;)

I prefer a month's worth of this over a single more email about 
cd-fscking-record's amazing perfection.

Cheers,
Con
