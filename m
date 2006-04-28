Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030354AbWD1KKL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030354AbWD1KKL (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Apr 2006 06:10:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030359AbWD1KKL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Apr 2006 06:10:11 -0400
Received: from mail09.syd.optusnet.com.au ([211.29.132.190]:2501 "EHLO
	mail09.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S1030354AbWD1KKK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Apr 2006 06:10:10 -0400
From: Con Kolivas <kernel@kolivas.org>
To: linux-kernel@vger.kernel.org
Subject: Re: [ckrm-tech] Re: [PATCH 0/9] CPU controller
Date: Fri, 28 Apr 2006 20:09:40 +1000
User-Agent: KMail/1.9.1
Cc: Mike Galbraith <efault@gmx.de>, Kirill Korotaev <dev@sw.ru>,
       MAEDA Naoaki <maeda.naoaki@jp.fujitsu.com>, akpm@osdl.org,
       ckrm-tech@lists.sourceforge.net
References: <20060428013730.9582.9351.sendpatchset@moscone.dvs.cs.fujitsu.co.jp> <1146208288.7551.19.camel@homer> <1146210395.7551.37.camel@homer>
In-Reply-To: <1146210395.7551.37.camel@homer>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200604282009.41725.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 28 April 2006 17:46, Mike Galbraith wrote:
> On Fri, 2006-04-28 at 09:11 +0200, Mike Galbraith wrote:
> > On Fri, 2006-04-28 at 09:56 +0400, Kirill Korotaev wrote:
> > > I'm also pretty sure, that CPU controller based on timeslice tricks
> > > behaves poorly on burstable load patterns as well and with interactive
> > > tasks. So before commiting I propose to perform a good testing on
> > > different load patterns.
> >
> > Yes, it can only react very slowly.
>
> Actually, this might not be that much of a problem.  I know I can
> traverse queue heads periodically very cheaply.  Traversing both active
> and expired arrays to requeue starving tasks once every 100ms costs max
> 4usecs (3GHz P4) for a typical distribution.

How many tasks? Your function was O(n) so the more tasks the longer that max 
value was.

-- 
-ck
