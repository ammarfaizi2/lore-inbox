Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269091AbUIHKSg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269091AbUIHKSg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Sep 2004 06:18:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269092AbUIHKSg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Sep 2004 06:18:36 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:10476 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S269091AbUIHKSc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Sep 2004 06:18:32 -0400
Date: Wed, 8 Sep 2004 12:17:19 +0200
From: Jens Axboe <axboe@suse.de>
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
Subject: Re: [patch] max-sectors-2.6.9-rc1-bk14-A0
Message-ID: <20040908101719.GH2258@suse.de>
References: <20040908100448.GA4994@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040908100448.GA4994@elte.hu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 08 2004, Ingo Molnar wrote:
> 
> this is a re-send of the max-sectors patch against 2.6.9-rc1-bk14.
> 
> the attached patch introduces two new /sys/block values:
> 
>   /sys/block/*/queue/max_hw_sectors_kb
>   /sys/block/*/queue/max_sectors_kb
> 
> max_hw_sectors_kb is the maximum that the driver can handle and is
> readonly. max_sectors_kb is the current max_sectors value and can be
> tuned by root. PAGE_SIZE granularity is enforced.
> 
> It's all locking-safe and all affected layered drivers have been updated
> as well. The patch has been in testing for a couple of weeks already as
> part of the voluntary-preempt patches and it works just fine - people
> use it to reduce IDE IRQ handling latencies. Please apply.

Wasn't the move of the ide_lock grabbing enough to solve this problem by
itself?


-- 
Jens Axboe

