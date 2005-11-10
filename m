Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751331AbVKJHvs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751331AbVKJHvs (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Nov 2005 02:51:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751314AbVKJHvs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Nov 2005 02:51:48 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:58672 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S1751331AbVKJHvr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Nov 2005 02:51:47 -0500
Date: Thu, 10 Nov 2005 08:52:53 +0100
From: Jens Axboe <axboe@suse.de>
To: Tejun Heo <htejun@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] blk: implement elv_drain_elevator
Message-ID: <20051110075253.GS3699@suse.de>
References: <20051109173257.GD24115@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051109173257.GD24115@htj.dyndns.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 10 2005, Tejun Heo wrote:
> This patch adds request_queue->nr_sorted which keeps the number of
> requests in the iosched and implement elv_drain_elevator which
> performs forced dispatching.  elv_drain_elevator checks whether
> iosched actually dispatches all requests it has and prints error
> message if it doesn't.  As buggy forced dispatching can result in
> wrong barrier operations, I think this extra check is worthwhile.

Yeah I agree, especially as it's potentially data integrity violating
with this kind of bug. Applied.

-- 
Jens Axboe

