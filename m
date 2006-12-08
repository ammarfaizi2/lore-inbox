Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1425471AbWLHMEn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1425471AbWLHMEn (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Dec 2006 07:04:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1425464AbWLHMEg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Dec 2006 07:04:36 -0500
Received: from brick.kernel.dk ([62.242.22.158]:5874 "EHLO kernel.dk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1425454AbWLHME0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Dec 2006 07:04:26 -0500
Date: Fri, 8 Dec 2006 13:05:23 +0100
From: Jens Axboe <jens.axboe@oracle.com>
To: Avantika Mathur <mathur@us.ibm.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: cfq performance gap
Message-ID: <20061208120522.GN23887@kernel.dk>
References: <1165536200.25180.1.camel@dyn9047017105.beaverton.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1165536200.25180.1.camel@dyn9047017105.beaverton.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 07 2006, Avantika Mathur wrote:
> Hi Jens, 

(you probably noticed now, but the axboe@suse.de email is no longer
valid)

> I've noticed a performance gap between the cfq scheduler and other io
> schedulers when running the rawio benchmark. 
> Results from rawio on 2.6.19, cfq and noop schedulers: 
> 
> CFQ: 
> 
> procs           device    num read   KB/sec     I/O Ops/sec 
> -----  ---------------  ----------  -------  -------------- 
>   16         /dev/sda       16412     8338            2084 
> -----  ---------------  ----------  -------  -------------- 
>   16                        16412     8338            2084 
> 
> Total run time 0.492072 seconds 
> 
> 
> NOOP: 
> 
> procs           device    num read   KB/sec     I/O Ops/sec 
> -----  ---------------  ----------  -------  -------------- 
>   16         /dev/sda       16399    29224            7306 
> -----  ---------------  ----------  -------  -------------- 
>   16                        16399    29224            7306 
> 
> Total run time 0.140284 seconds 
> 
> The benchmark workload is 16 processes running 4k random reads. 
> 
> Is this performance gap a known issue? 

CFQ could be a little slower at this benchmark, but your results are
much worse than I would expect. What is the queueing depth of sda? How
are you invoking rawio?

Your runtime is very low, how does it look if you allow the test to run
for much longer? 30MiB/sec random read bandwidth seems very high, I'm
wondering what exactly is being tested here.

-- 
Jens Axboe

