Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262853AbTCYQlF>; Tue, 25 Mar 2003 11:41:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262884AbTCYQlF>; Tue, 25 Mar 2003 11:41:05 -0500
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:18437 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP
	id <S262853AbTCYQlE>; Tue, 25 Mar 2003 11:41:04 -0500
Date: Tue, 25 Mar 2003 11:47:45 -0500 (EST)
From: Bill Davidsen <davidsen@tmr.com>
To: Alan Cox <alan@redhat.com>
cc: Jeff Garzik <jgarzik@pobox.com>, linux-kernel@vger.kernel.org
Subject: Re: Linux 2.5.65-ac3
In-Reply-To: <200303230044.h2N0i9r32560@devserv.devel.redhat.com>
Message-ID: <Pine.LNX.3.96.1030325111656.1437E-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 22 Mar 2003, Alan Cox wrote:

> > Once your tty and ide bits are merged, what's left on the plate (in your 
> > opinion) before 2.6.0-test1?
> 
> 32bit dev_t is a showstopper
> 
> then 
> 
> Debugging, debugging, and more debugging
> Driver porting
> Driver resyncs with 2.4
> Finding the remaining scsi bugs
> A ton more IDE work before I am happy
> Fixing the pci api hotplug races
> DRM 4.3 cleaned up and working
> 
> 
> I think the dev_t one is the only stopper now before we go into
> stop futzing with core code and fix bugs mode

I think there is still a need for futzing with a few things. The elevator
code has several modes, all of which seem to have at least one "jackpot
case" where performance suddenly gets very bad. That's ture of the
scheduler as well.

Since both have improved vastly in the past few months, I think it's worth
giving a little more time to diddle the algorithms in those areas. The
usual people are hard at work, both issues are getting better in recent
versions, and I hope the last bit of touch-up is considered bug fix even
on such core code.

It would be nice if someone could get the older SCSI adaptors to compile
and work, aha152x and 1542 are my personal issues, I have them in some
machine embedded. And I have several machines with a non-functional
parallel port, which works fine under 2.4.18 (and is detected at least by
2.4.20). I see it detected but there's "no /dev/lp0" later. I stopped
posting about it because there are more important things, but a functional
printer would be nice.

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

