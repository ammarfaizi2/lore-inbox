Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270566AbSISIYe>; Thu, 19 Sep 2002 04:24:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270621AbSISIYe>; Thu, 19 Sep 2002 04:24:34 -0400
Received: from packet.digeo.com ([12.110.80.53]:47500 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S270566AbSISIYe>;
	Thu, 19 Sep 2002 04:24:34 -0400
Message-ID: <3D898AEA.7E53DF1E@digeo.com>
Date: Thu, 19 Sep 2002 01:29:30 -0700
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-rc5 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Daniel Phillips <phillips@arcor.de>
CC: Paolo Ciarrocchi <ciarrocchi@linuxmail.org>, linux-kernel@vger.kernel.org
Subject: Re: [chatroom benchmark version 1.0.1] Results
References: <20020919080602.2986.qmail@linuxmail.org> <E17rwaz-0000vY-00@starship>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 19 Sep 2002 08:29:30.0811 (UTC) FILETIME=[ACD4D0B0:01C25FB6]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Daniel Phillips wrote:
> 
> Just thought I'd bounce this one over to Andrew as a warm-n-fuzzy.

Is a scheduler test, isn't it?

> There's also some kind of hint that preemption improves throughput
> here.

One needs to treat any test which involves networking to localhost
with caution.  They tend to show large (+/- 10% or more) swings
in throughput from one run to the next.  Some sort of cache
associativity thing; not sure.

Running the test between separate machines is much, much more repeatable.

We'll get the cpu-local hot pages list code going soon; that may
provide some benefit to this sort of thing.  Even on uniprocessor.
