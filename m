Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271582AbRHPQNw>; Thu, 16 Aug 2001 12:13:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271584AbRHPQNn>; Thu, 16 Aug 2001 12:13:43 -0400
Received: from coffee.psychology.McMaster.CA ([130.113.218.59]:38416 "EHLO
	coffee.psychology.mcmaster.ca") by vger.kernel.org with ESMTP
	id <S271582AbRHPQNg>; Thu, 16 Aug 2001 12:13:36 -0400
Date: Thu, 16 Aug 2001 16:13:47 +0000 (GMT)
From: Mark Hahn <hahn@physics.mcmaster.ca>
To: Eduardo =?iso-8859-1?q?Cort=E9s=20?= <the_beast@softhome.net>
cc: linux-kernel@vger.kernel.org
Subject: Re: Re: limit cpu
In-Reply-To: <20010816160817Z268342-761+1804@vger.kernel.org>
Message-ID: <Pine.LNX.4.10.10108161610150.19342-100000@coffee.psychology.mcmaster.ca>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > > i want to know if linux can limit the max cpu usage (not cpu time) per
> > > user,
> >
> > no.  doing so would inherently slow down the scheduler.
> 
> but *BSD has this feature, what's the problem in linux?

I said that, thinking that it would require another test along
the scheduler's fast path.  but if we only test when a process
has exhausted its quantum (or perhaps at counter-recalc),
the overhead would be minor.

