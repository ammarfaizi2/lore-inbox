Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261654AbSJAN7c>; Tue, 1 Oct 2002 09:59:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261657AbSJAN7c>; Tue, 1 Oct 2002 09:59:32 -0400
Received: from dsl-213-023-043-077.arcor-ip.net ([213.23.43.77]:41626 "EHLO
	starship") by vger.kernel.org with ESMTP id <S261654AbSJAN7b>;
	Tue, 1 Oct 2002 09:59:31 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@arcor.de>
To: Andrew Morton <akpm@digeo.com>,
       Lorenzo Allegrucci <l.allegrucci@tiscalinet.it>
Subject: Re: qsbench, interesting results
Date: Tue, 1 Oct 2002 16:05:15 +0200
X-Mailer: KMail [version 1.3.2]
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
References: <200209291615.24158.l.allegrucci@tiscalinet.it> <3D97E7D7.442733ED@digeo.com>
In-Reply-To: <3D97E7D7.442733ED@digeo.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E17wNeG-0005th-00@starship>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 30 September 2002 07:57, Andrew Morton wrote:
> I'll take a look at some preferential throttling later on.  But
> I must say that I'm not hugely worried about performance regression
> under wild swapstorms.  The correct fix is to go buy some more
> RAM, and the kernel should not be trying to cater for underprovisioned
> machines if that affects the usual case.

The operative phrase here is "if that affects the usual case".  Actually,
the quicksort bench is not that bad a model of a usual case, i.e., a
working set 50% bigger than RAM.  The page replacement algorithm ought to
do something sane with it, and swap performance ought to be decent in
general, since desktop users typically have less than 1/2 GB.  With media
apps, bloated desktops and all, it doesn't go as far as it used to.

My impression is that page replacement just hasn't gotten a lot of
attention recently, and there is nothing wrong with that.  It's tuning,
not a feature.

The sort failure is something to worry about though - that's clearly a
bug.

-- 
Daniel
