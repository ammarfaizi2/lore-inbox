Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266688AbRGKN6z>; Wed, 11 Jul 2001 09:58:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266689AbRGKN6g>; Wed, 11 Jul 2001 09:58:36 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.101]:20683 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S266688AbRGKN61>;
	Wed, 11 Jul 2001 09:58:27 -0400
Date: Wed, 11 Jul 2001 19:32:56 +0530
From: Dipankar Sarma <dipankar@sequent.com>
To: Jens Axboe <axboe@suse.de>
Cc: Mike Anderson <mike.anderson@us.ibm.com>, linux-kernel@vger.kernel.org
Subject: Re: io_request_lock patch?
Message-ID: <20010711193256.G9220@in.ibm.com>
Reply-To: dipankar@sequent.com
In-Reply-To: <20010710172545.A8185@in.ibm.com> <20010710160512.A25632@us.ibm.com> <20010711142311.B9220@in.ibm.com> <20010711105339.F17314@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <20010711105339.F17314@suse.de>; from axboe@suse.de on Wed, Jul 11, 2001 at 10:53:39AM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 11, 2001 at 10:53:39AM +0200, Jens Axboe wrote:
> The queue lengths should always be long enough to keep the hw busy of
> course. And in addition, the bigger the queues the bigger the chance of
> skipping seeks due to reordering. But don't worry, I've scaled the queue
> lengths so I'm pretty sure that they are always on the safe side in
> size.
> 
> It's pretty easy to test for yourself if you want, just change
> QUEUE_NR_REQUESTS in blkdev.h. It's currently 8192, the request slots
> are scaled down from this value. 8k will give you twice the amount of
> slots that you have RAM in mb, ie 2048 on a 1gig machine.
> 
> block: queued sectors max/low 683554kB/552482kB, 2048 slots per queue

Hmm.. The tiobench run was done on a 1GB machine and we still ran
out of request slots. Will investigate.

Thanks
Dipankar
-- 
Dipankar Sarma  <dipankar@sequent.com> Project: http://lse.sourceforge.net
Linux Technology Center, IBM Software Lab, Bangalore, India.
