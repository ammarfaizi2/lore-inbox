Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751177AbVKJRRt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751177AbVKJRRt (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Nov 2005 12:17:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751182AbVKJRRt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Nov 2005 12:17:49 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:19756 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S1751177AbVKJRRt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Nov 2005 12:17:49 -0500
Date: Thu, 10 Nov 2005 18:18:56 +0100
From: Jens Axboe <axboe@suse.de>
To: Tejun Heo <htejun@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] noop-iosched: reimplementation
Message-ID: <20051110171855.GF3699@suse.de>
References: <20051110141751.GB26030@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051110141751.GB26030@htj.dyndns.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 10 2005, Tejun Heo wrote:
> The original implementation directly used dispatch queue.  As new
> generic dispatch queue imposes stricter rules over ioscheds and
> dispatch queue usage, this direct use becomes somewhat problematic.
> This patch reimplements noop-iosched such that it complies to generic
> iosched model better.  Request merging with q->last_merge and
> rq->queuelist.prev/next work again now.

Yep this looks like what I had in mind as well, I'll apply it.

> Jens, this one also received several hours of testing which involves a
> lot of request merging, but it might still be a better idea to wait
> for the next release.  Oh... Are we still in the merging window for
> 2.6.15?  If so, this one can go in, I guess.

I guess we can sneak this one in after the window even, if we
characterize it as a regression fix as compared to 2.6.14 :-)

-- 
Jens Axboe

