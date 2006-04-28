Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030357AbWD1KQS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030357AbWD1KQS (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Apr 2006 06:16:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030360AbWD1KQS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Apr 2006 06:16:18 -0400
Received: from mail.gmx.net ([213.165.64.20]:54726 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1030357AbWD1KQR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Apr 2006 06:16:17 -0400
X-Authenticated: #14349625
Subject: Re: [ckrm-tech] Re: [PATCH 0/9] CPU controller
From: Mike Galbraith <efault@gmx.de>
To: Con Kolivas <kernel@kolivas.org>
Cc: linux-kernel@vger.kernel.org, Kirill Korotaev <dev@sw.ru>,
       MAEDA Naoaki <maeda.naoaki@jp.fujitsu.com>, akpm@osdl.org,
       ckrm-tech@lists.sourceforge.net
In-Reply-To: <200604282009.41725.kernel@kolivas.org>
References: <20060428013730.9582.9351.sendpatchset@moscone.dvs.cs.fujitsu.co.jp>
	 <1146208288.7551.19.camel@homer> <1146210395.7551.37.camel@homer>
	 <200604282009.41725.kernel@kolivas.org>
Content-Type: text/plain
Date: Fri, 28 Apr 2006 12:16:12 +0200
Message-Id: <1146219372.8067.31.camel@homer>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.0 
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-04-28 at 20:09 +1000, Con Kolivas wrote:
> On Friday 28 April 2006 17:46, Mike Galbraith wrote:
> > On Fri, 2006-04-28 at 09:11 +0200, Mike Galbraith wrote:
> > > On Fri, 2006-04-28 at 09:56 +0400, Kirill Korotaev wrote:
> > > > I'm also pretty sure, that CPU controller based on timeslice tricks
> > > > behaves poorly on burstable load patterns as well and with interactive
> > > > tasks. So before commiting I propose to perform a good testing on
> > > > different load patterns.
> > >
> > > Yes, it can only react very slowly.
> >
> > Actually, this might not be that much of a problem.  I know I can
> > traverse queue heads periodically very cheaply.  Traversing both active
> > and expired arrays to requeue starving tasks once every 100ms costs max
> > 4usecs (3GHz P4) for a typical distribution.
> 
> How many tasks? Your function was O(n) so the more tasks the longer that max 
> value was.

Nope.  It's not O(tasks), it's O(occupied_queues).  Occupied queues is
generally not a large number.

	-Mike

