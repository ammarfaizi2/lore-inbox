Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266649AbSKGXwP>; Thu, 7 Nov 2002 18:52:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266656AbSKGXwP>; Thu, 7 Nov 2002 18:52:15 -0500
Received: from packet.digeo.com ([12.110.80.53]:34294 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S266649AbSKGXwN>;
	Thu, 7 Nov 2002 18:52:13 -0500
Message-ID: <3DCAFE38.16DED3BF@digeo.com>
Date: Thu, 07 Nov 2002 15:58:48 -0800
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre4 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Robert Love <rml@tech9.net>
CC: Con Kolivas <conman@kolivas.net>,
       linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: [BENCHMARK] 2.5.46-mm1 with contest
References: <200211080953.22903.conman@kolivas.net> <1036712891.764.2055.camel@phantasy>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 07 Nov 2002 23:58:48.0069 (UTC) FILETIME=[9CFCF350:01C286B9]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Robert Love wrote:
> 
> On Thu, 2002-11-07 at 17:53, Con Kolivas wrote:
> 
> > io_load:
> > Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
> > 2.5.44-mm6 [3]          284.1   28      20      10      3.98
> > 2.5.46 [1]              600.5   13      48      12      8.41
> > 2.5.46-mm1 [5]          134.3   58      6       8       1.88
> >
> > Big change here. IO load is usually the one we feel the most.
> 
> Nice.

Mysterious.

> > Unfortunately I've only run this with preempt enabled so far and I believe
> > many of the improvements are showing this effect.
> 
> Since your aim is desktop performance, I would like it if you always ran
> with kernel preemption enabled.  That is what we are targeting for
> desktop performance.

I'd be interested in average-of-five runs both with and without
preemption.



Preemption seemed to do odd things to process_load as well.  gcc gained
10% and the "load" lost 40%.  But the %LCPU fell only 25%, which is
probably dodgy accounting.  I wonder what's up with all that.
