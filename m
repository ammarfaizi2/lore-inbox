Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316992AbSF0UjE>; Thu, 27 Jun 2002 16:39:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316993AbSF0UjD>; Thu, 27 Jun 2002 16:39:03 -0400
Received: from web30.achilles.net ([209.151.1.2]:38296 "EHLO
	web30.achilles.net") by vger.kernel.org with ESMTP
	id <S316992AbSF0UjC>; Thu, 27 Jun 2002 16:39:02 -0400
Subject: Re: 2.4.19-rc1 + O(1) scheduler
From: Robert Love <rml@tech9.net>
To: "Alexandre P. Nunes" <alex@PolesApart.wox.org>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <3D1B7440.3040605@PolesApart.wox.org>
References: <Pine.LNX.4.44.0206222202400.7601-100000@PolesApart.dhs.org>	<20020626204721
Message-Id: <20020627203902Z316992-685+79@vger.kernel.org>
Date: Thu, 27 Jun 2002 16:39:02 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	
	.GK22961@holomorphy.com>	<1025125214.1911.40.camel@localhost.localdomain>	<1
	 025128477.1144.3.camel@icbm>
	<20020627005431.GM22961@holomorphy.com>	<1025192465.1084.3.camel@icbm>
	<20020627154712.GO22961@holomorphy.com> <3D1B5982.60008@PolesApart.dhs.org>
	<1025202738.1084.12.camel@icbm> <3D1B5F1D.2000706@PolesApart.wox.org>
	<3D1B7005.2090200@tmsusa.com>  <3D1B7440.3040605@PolesApart.wox.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 27 Jun 2002 16:35:46 -0400
Message-Id: <1025210179.1080.22.camel@icbm>
Mime-Version: 1.0

On Thu, 2002-06-27 at 16:23, Alexandre P. Nunes wrote:

> It seems that the version of O(1) scheduler on 2.4.19-pre10-ac2 is not 
> perfect (see below), but I asked because it gave me overall performance 
> gains, specially in multithreading programs (and now I'm going to try 
> with ngpt 2.00). At least that is the first impression, I'm trying it 
> for a few days.

Alan has some patches queued and I will continue to send him updates as
we get them into 2.5 and they prove stable.

I also will update my 2.4 O(1) scheduler patches when I return from
OLS.  This would allow a 2.4-ac vs 2.4-O(1) test.

> I said "not perfect" because a rather non-important benchmarking called 
> quake 3 seens a lot worse in pre10-ac2 with preemptive patches when 
> compared against -pre10 with preemptive patches: sound and screen popped 
> sometimes, like if there was a background task borrowing some cpu, which 
> was not the case, I mean, no other background tasks compared with 
> testing against -pre10. That was the only exception to the above 
> paragraph that I can remember of.

There is some "rudeness" in the current O(1) scheduler code in 2.4-ac
that could result in poor latency under certain workloads.

The patch should be in a near future 2.4-ac although I will need to
update the preempt-kernel patch to take advantage of it.

	Robert Love

