Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964992AbWEaNAY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964992AbWEaNAY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 May 2006 09:00:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964993AbWEaNAY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 May 2006 09:00:24 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:63751 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S964992AbWEaNAX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 May 2006 09:00:23 -0400
Date: Wed, 31 May 2006 15:02:15 +0200
From: Jens Axboe <axboe@suse.de>
To: Mark Lord <lkml@rtr.ca>
Cc: Linus Torvalds <torvalds@osdl.org>, Nick Piggin <nickpiggin@yahoo.com.au>,
       linux-kernel@vger.kernel.org, linux-mm@kvack.org, mason@suse.com,
       andrea@suse.de, hugh@veritas.com
Subject: Re: [rfc][patch] remove racy sync_page?
Message-ID: <20060531130215.GO29535@suse.de>
References: <447BB3FD.1070707@yahoo.com.au> <Pine.LNX.4.64.0605292117310.5623@g5.osdl.org> <447BD31E.7000503@yahoo.com.au> <447BD63D.2080900@yahoo.com.au> <Pine.LNX.4.64.0605301041200.5623@g5.osdl.org> <447CE43A.6030700@yahoo.com.au> <Pine.LNX.4.64.0605301739030.24646@g5.osdl.org> <447CF252.7010704@rtr.ca> <20060531061110.GB29535@suse.de> <447D923B.1080503@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <447D923B.1080503@rtr.ca>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 31 2006, Mark Lord wrote:
> Jens Axboe wrote:
> >
> >NCQ helps us with something we can never fix in software - the
> >rotational latency. Ordering is only a small part of the picture.
> 
> Yup.  And it also helps reduce the command-to-command latencies.

That too, however that's a much much smaller part.

> I'm all for it, and have implemented tagged queuing for a variety
> of device drivers over the past five years (TCQ & NCQ).  In every
> case people say.. wow, I expected more of a difference than that,
> while still noting the end result was faster under Linux than MS$.
> 
> Of course with artificial benchmarks, and the right firmware in
> the right drives, it's easier to create and see a difference.
> But I'm talking more life-like loads than just a multi-threaded
> random seek generator.

Definitely, the random pseudo read work load is about as good as it gets
for NCQ, and it was tailored to keep the queue full at all times. So I
agree, real life will see less of a benefit. But it's still there.

-- 
Jens Axboe

