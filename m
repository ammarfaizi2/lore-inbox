Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268316AbUIPXDq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268316AbUIPXDq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Sep 2004 19:03:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268314AbUIPXDp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Sep 2004 19:03:45 -0400
Received: from smtp.Lynuxworks.com ([207.21.185.24]:5130 "EHLO
	smtp.lynuxworks.com") by vger.kernel.org with ESMTP id S268316AbUIPXBV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Sep 2004 19:01:21 -0400
Date: Thu, 16 Sep 2004 16:01:16 -0700
To: "David S. Miller" <davem@davemloft.net>
Cc: Bill Huey <bhuey@lnxw.com>, davidsen@tmr.com, linux-kernel@vger.kernel.org,
       mingo@elte.hu
Subject: Re: [patch] remove the BKL (Big Kernel Lock), this time for real
Message-ID: <20040916230116.GA4427@nietzsche.lynx.com>
References: <m3vfefa61l.fsf@averell.firstfloor.org> <cic7f9$i4m$1@gatekeeper.tmr.com> <20040916222903.GA4089@nietzsche.lynx.com> <20040916154011.3f0dbd54.davem@davemloft.net> <20040916225102.GA4386@nietzsche.lynx.com> <20040916155412.47649ba6.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040916155412.47649ba6.davem@davemloft.net>
User-Agent: Mutt/1.5.6+20040818i
From: Bill Huey (hui) <bhuey@lnxw.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 16, 2004 at 03:54:12PM -0700, David S. Miller wrote:
> On Thu, 16 Sep 2004 15:51:02 -0700
> Bill Huey (hui) <bhuey@lnxw.com> wrote:
> 
> > Judging from how the Linux code is done and the numbers I get from
> > Bill Irwin in casual conversation, the Linux SMP approach is clearly
> > the right track at this time with it's hand honed per-CPU awareness of
> > things. The only serious problem that spinlocks have as they aren't
> > preemptable, which is what Ingo is trying to fix.
> 
> This is what Linus proclaimed 6 or 7 years ago when people were
> trying to convince us to do things like Solaris and other big
> Unixes at the time.

FreeBSD's SMPng project is stalled for the most part and developers that
disagree with that approach have move onto the DragonFly BSD community.
It has a much more top-down driven locking system that's conceptually
CPU local called tokens, effectively deadlock free and difficult to misused.
It's already been able to multi-thread the networking stack using lock-less
techniques, while the FreeBSD-current tree had to retract their "all or
nothing" approach with threading their network stack. Jeffery Hsu is
the main developer pushing that subsystem.

bill

