Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265688AbSJXWXk>; Thu, 24 Oct 2002 18:23:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265691AbSJXWXj>; Thu, 24 Oct 2002 18:23:39 -0400
Received: from packet.digeo.com ([12.110.80.53]:32153 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S265688AbSJXWXi>;
	Thu, 24 Oct 2002 18:23:38 -0400
Message-ID: <3DB87458.F5C7DABA@digeo.com>
Date: Thu, 24 Oct 2002 15:29:44 -0700
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre4 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: cmm@us.ibm.com
CC: Hugh Dickins <hugh@veritas.com>, manfred@colorfullife.com,
       linux-kernel@vger.kernel.org, dipankar@in.ibm.com,
       lse-tech@lists.sourceforge.net
Subject: Re: [PATCH]updated ipc lock patch
References: <Pine.LNX.4.44.0210211946470.17128-100000@localhost.localdomain> <3DB86B05.447E7410@us.ibm.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 24 Oct 2002 22:29:44.0297 (UTC) FILETIME=[DA118D90:01C27BAC]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

mingming cao wrote:
> 
> Hi Andrew,
> 
> Here is the updated ipc lock patch:

Well I can get you a bit of testing and attention, but I'm afraid
my knowledge of the IPC code is negligible.

So to be able to commend this change to Linus I'd have to rely on
assurances from people who _do_ understand IPC (Hugh?) and on lots
of testing.

So yes, I'll include it, and would solicit success reports from
people who are actually exercising that code path, thanks.

> http://www.osdl.org/projects/dbt1prfrns/results/mingming/index.html

DBT1 is really interesting, and I'm glad the OSDL team have
put it together.  If people would only stop sending me patches
I'd be using it ;)

Could someone please help explain the results?  Comparing, say,
http://www.osdl.org/projects/dbt1prfrns/results/mingming/run.2cpu.42-mm2.r5/index.html
and
http://www.osdl.org/projects/dbt1prfrns/results/mingming/run.18.r5/index.html

It would appear that 2.5 completely smoked 2.4 on response time,
yet the overall bogotransactions/sec is significantly lower.
What should we conclude from this?

Also I see:

	14.7 minute duration
and
	Time for DBT run 19:36

What is the 14.7 minutes referring to?

Also:

	2.5: Time for key creation 1:27
	2.4: Time for key creation 14:24
versus:
	2.5: Time for table creation 16:48
	2.4: Time for table creation 8:58

So it's all rather confusing.  Masses of numbers usually _are_
confusing.  What really adds tons of value to such an exercise is
for the person who ran the test to write up some conclusions.  To
tell the developers what went well, what went poorly, what areas
to focus on, etc.  To use your own judgement to tell us what to
zoom in on.

Is that something which could be added?
