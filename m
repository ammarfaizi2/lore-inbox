Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030361AbWD1KL5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030361AbWD1KL5 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Apr 2006 06:11:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030360AbWD1KL5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Apr 2006 06:11:57 -0400
Received: from mail05.syd.optusnet.com.au ([211.29.132.186]:51688 "EHLO
	mail05.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S1030361AbWD1KL4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Apr 2006 06:11:56 -0400
From: Con Kolivas <kernel@kolivas.org>
To: linux-kernel@vger.kernel.org
Subject: Re: [ckrm-tech] Re: [PATCH 0/9] CPU controller
Date: Fri, 28 Apr 2006 20:11:36 +1000
User-Agent: KMail/1.9.1
Cc: Mike Galbraith <efault@gmx.de>, MAEDA Naoaki <maeda.naoaki@jp.fujitsu.com>,
       akpm@osdl.org, ckrm-tech@lists.sourceforge.net
References: <20060428013730.9582.9351.sendpatchset@moscone.dvs.cs.fujitsu.co.jp> <20060428165639.0e4f9a03.maeda.naoaki@jp.fujitsu.com> <1146216552.8067.11.camel@homer>
In-Reply-To: <1146216552.8067.11.camel@homer>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200604282011.36917.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 28 April 2006 19:29, Mike Galbraith wrote:
> On Fri, 2006-04-28 at 16:56 +0900, MAEDA Naoaki wrote:
> > On Fri, 28 Apr 2006 09:41:09 +0200
> >
> > Mike Galbraith <efault@gmx.de> wrote:
> > > On Fri, 2006-04-28 at 16:26 +0900, MAEDA Naoaki wrote:
> > > > On Fri, 28 Apr 2006 08:59:49 +0200
> > > >
> > > > Mike Galbraith <efault@gmx.de> wrote:
> > > > > You simply cannot ignore interactive tasks.  At the very least, you
> > > > > have to disallow requeue if the resource limit has been exceeded,
> > > > > otherwise, this patch set is non-functional.
> > > >
> > > > It can be easily implemented on top of the current code. Do you know
> > > > a good sample program that is judged as interactive but consumes lots
> > > > of cpu?
> > >
> > > X sometimes, Mozilla sometimes,... KDE konsole when scrolling,...
> > > anything that on average sleeps more than roughly 5% of it's slice can
> > > starve you to death either alone, or (worse) with peers.
> >
> > They are true interactive tasks, aren't they?
> > Oh! I should say "that is not interactive, but judged as interactive
> > and consumes lots of cpu".
>
> Why do you care?  There is only one thing that matters, and that is the
> fact that cpu can be used and remain utterly uncontrolled.  This renders
> your system non-functional for resource management.  Period.  All stop.

I agree with Mike here. It's either global resource management or it isn't. If 
one user is using all interactive tasks and the other user none it's unfair 
resource management.

-- 
-ck
