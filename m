Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262000AbTELIQm (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 May 2003 04:16:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262001AbTELIQm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 May 2003 04:16:42 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:37769 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S262000AbTELIQk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 May 2003 04:16:40 -0400
Date: Mon, 12 May 2003 10:29:02 +0200
From: Jens Axboe <axboe@suse.de>
To: Nick Piggin <piggin@cyberone.com.au>
Cc: Con Kolivas <kernel@kolivas.org>,
       linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@digeo.com>
Subject: Re: [BENCHMARK] 2.5.69-mm3 with contest
Message-ID: <20030512082902.GA837@suse.de>
References: <200305111655.35543.kernel@kolivas.org> <3EBF538B.50501@cyberone.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3EBF538B.50501@cyberone.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 12 2003, Nick Piggin wrote:
> 
> 
> Con Kolivas wrote:
> 
> snip
> 
> >io_load:
> >Kernel         [runs]   Time    CPU%    Loads   LCPU%   Ratio
> >2.5.68              3   492     15.9    167.1   19.7    6.23
> >2.5.68-mm1          4   128     59.4    47.6    19.4    1.62
> >2.5.68-mm2          4   131     58.8    47.0    18.9    1.64
> >2.5.68-mm3          4   271     28.4    89.2    17.9    3.39
> >2.5.69              4   343     22.7    120.5   19.8    4.29
> >2.5.69-mm3          4   319     24.5    105.3   18.1    4.04
> >
> snip
> 
> >
> >dbench_load:
> >Kernel         [runs]   Time    CPU%    Loads   LCPU%   Ratio
> >2.5.68              3   412     18.4    5.3     47.6    5.22
> >2.5.68-mm1          4   361     21.1    5.5     54.0    4.57
> >2.5.68-mm2          4   345     22.0    4.8     49.3    4.31
> >2.5.68-mm3          4   721     10.5    6.8     33.6    9.01
> >2.5.69              4   374     20.3    5.0     48.1    4.67
> >2.5.69-mm3          4   653     11.6    6.2     34.0    8.27
> >
> >Very similar to 2.5.68-mm3
> >
> Thanks again Con. These two benchmarks especially are fairly suboptimal
> compared with the 68-mm2 days... I hope it is just the larger request queue
> size in place in the rq-dyn patch in mm. If you get some time, could you
> possibly change include/linux/blkdev.h:BLKDEV_MAX_RQ from 1024 to 128 and
> bench these two loads on that setting.

Or just wait for 2.5.70, it has rq-dyn with BLKDEV_MAX_RQ of 128.

-- 
Jens Axboe

