Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751271AbVKJHqd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751271AbVKJHqd (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Nov 2005 02:46:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751278AbVKJHqd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Nov 2005 02:46:33 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:21294 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S1751271AbVKJHqd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Nov 2005 02:46:33 -0500
Date: Thu, 10 Nov 2005 08:47:39 +0100
From: Jens Axboe <axboe@suse.de>
To: Tejun Heo <htejun@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] blk: cfq forced dispatching fix
Message-ID: <20051110074738.GR3699@suse.de>
References: <20051109171758.GC24115@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051109171758.GC24115@htj.dyndns.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 10 2005, Tejun Heo wrote:
> cfq forced dispatching might not return all requests on the queue.
> This bug can hang elevator switchinig and corrupt request ordering
> during flush sequence.
> 
> Signed-off-by: Tejun Heo <htejun@gmail.com>
> 
> ---
> 
> Jens, I implemented a separate code path for forced dispatching as it
> seemed too complex/error-prone to handle forced case in normal
> dispatch path.  How do you like this approach?

I like this approach better then mixing the 'force' into various logic
around the function. So applied.

-- 
Jens Axboe

