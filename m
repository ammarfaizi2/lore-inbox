Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264673AbTBABzO>; Fri, 31 Jan 2003 20:55:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264681AbTBABzO>; Fri, 31 Jan 2003 20:55:14 -0500
Received: from packet.digeo.com ([12.110.80.53]:4083 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S264673AbTBABzO>;
	Fri, 31 Jan 2003 20:55:14 -0500
Date: Fri, 31 Jan 2003 18:04:42 -0800
From: Andrew Morton <akpm@digeo.com>
To: Con Kolivas <conman@kolivas.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [BENCHMARK] 2.5.59-mm7 with contest
Message-Id: <20030131180442.06e39ffc.akpm@digeo.com>
In-Reply-To: <200302011013.36125.conman@kolivas.net>
References: <200302010930.54538.conman@kolivas.net>
	<3E3B0030.5580060A@digeo.com>
	<200302011013.36125.conman@kolivas.net>
X-Mailer: Sylpheed version 0.8.9 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 01 Feb 2003 02:04:34.0663 (UTC) FILETIME=[44388F70:01C2C996]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Con Kolivas <conman@kolivas.net> wrote:
>
> On Saturday 01 Feb 2003 10:01 am, Andrew Morton wrote:
> > Con Kolivas wrote:
> > > ...
> > > io_load:
> > > Kernel     [runs]       Time    CPU%    Loads   LCPU%   Ratio
> > > 2.5.59          3       153     50.3    8       13.7    1.94
> > > 2.5.59-mm6      2       90      83.3    2       6.7     1.15
> > > 2.5.59-mm7      5       110     68.2    2       6.4     1.41
> > > read_load:
> > > Kernel     [runs]       Time    CPU%    Loads   LCPU%   Ratio
> > > 2.5.59          3       102     76.5    5       4.9     1.29
> > > 2.5.59-mm6      3       733     10.8    56      6.3     9.40
> > > 2.5.59-mm7      4       90      84.4    1       1.3     1.15
> >
> > The background loads took some punishment.
> 
> Yes and I'd say a ratio of only 1.15 suggests kernel compilation got an unfair 
> share of the resources.

A very important metric is system-wide idle/IO-wait CPU time.  As long as
that is kept nice and low, we can then finetune the starvation and fairness
aspects.

