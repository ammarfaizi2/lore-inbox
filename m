Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261766AbTIHAa6 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Sep 2003 20:30:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261785AbTIHAa6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Sep 2003 20:30:58 -0400
Received: from warden3-p.diginsite.com ([208.147.64.186]:65215 "HELO
	warden3.diginsite.com") by vger.kernel.org with SMTP
	id S261766AbTIHAa5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Sep 2003 20:30:57 -0400
From: David Lang <david.lang@digitalinsight.com>
To: Con Kolivas <kernel@kolivas.org>
Cc: John Yau <jyau_kernel_dev@hotmail.com>,
       Nick Piggin <piggin@cyberone.com.au>, linux-kernel@vger.kernel.org
Date: Sun, 7 Sep 2003 17:27:47 -0700 (PDT)
Subject: Re: [PATCH] Minor scheduler fix to get rid of skipping in xmms
In-Reply-To: <200309081022.59850.kernel@kolivas.org>
Message-ID: <Pine.LNX.4.44.0309071722430.20816-100000@dlang.diginsite.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 8 Sep 2003, Con Kolivas wrote:

> Ultra short timeslices would dissolve a lot of the interactivity issues but
> come with a serious problem - most cpu caches these days, which are
> incredibly valuable to cpu performance, take time to be filled and emptied,
> and 1ms timeslices are just too short to use their benefits. The time
> required to derive useful benefit depends on the cpu type but can be up to
> 20ms. In my patches, the most interactive tasks round robin every 10ms which
> can cause some detriment to performance, but fortunately interactive tasks
> tend not to be as cpu bound as other tasks. What also happens is that if an
> interactive task decides to use a burst of cpu it will always be dropped by
> at least one priority so the tasks that only ever use small amounts of cpu
> (read audio apps) will always go first.

Con,
doesn't this get affected more with the CPU and memory speed then with
clock time? (i.e. the faster CPU is calling for addresses in a sorter time
period since it gets through more of the program and the faster memory
gets the cache misses into cache faster)

or are the caches getting enough larger as CPU and memeory
speeds climb that the clock time is close to being consistant?

it just seems wrong to list a specific wall clock time nessasary to fill a
cache with so many variables, it may have been correct as of the date that
time was calculated, but as CPU's change I would expect the minimum time
to vary quite a bit based on the particular CPU (which brings up the
question of if the timeslices should be different for different CPU's)

David Lang

