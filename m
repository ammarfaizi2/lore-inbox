Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264903AbUGUGDP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264903AbUGUGDP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jul 2004 02:03:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265055AbUGUGDO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jul 2004 02:03:14 -0400
Received: from viper.oldcity.dca.net ([216.158.38.4]:63684 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S264903AbUGUGDN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jul 2004 02:03:13 -0400
Subject: Re: [linux-audio-dev] Re: [announce] [patch] Voluntary Kernel
	Preemption Patch
From: Lee Revell <rlrevell@joe-job.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: Andrew Morton <akpm@osdl.org>, linux-audio-dev@music.columbia.edu,
       arjanv@redhat.com, linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20040721053007.GA8376@elte.hu>
References: <20040709182638.GA11310@elte.hu>
	 <20040710222510.0593f4a4.akpm@osdl.org>
	 <1089673014.10777.42.camel@mindpipe>
	 <20040712163141.31ef1ad6.akpm@osdl.org>
	 <1089677823.10777.64.camel@mindpipe>
	 <20040712174639.38c7cf48.akpm@osdl.org> <20040719102954.GA5491@elte.hu>
	 <1090380467.1212.3.camel@mindpipe> <20040721000348.39dd3716.akpm@osdl.org>
	 <20040721053007.GA8376@elte.hu>
Content-Type: text/plain
Message-Id: <1090389791.901.31.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Wed, 21 Jul 2004 02:03:12 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-07-21 at 01:30, Ingo Molnar wrote:
> * Andrew Morton <akpm@osdl.org> wrote:
> 
> > >  discovered I can reliably produce a large XRUN by toggling Caps Lock, 
> > > Scroll Lock, or Num Lock.  This is with 2.6.8-rc1-mm1 + voluntary
> > > preempt
> > 
> > That's odd.  I wonder if the hardware is sick.  What is the duration is the
> > underrun?  The info you sent didn't include that.
> 
> no, it's the ps2 driver that is sick. The ps2 keyboard driver is one of
> the few places that busy-polls for IRQ completion from within a tasklet
> context for things like led switching (yuck) - this can cause many
> millisecs delays on all boards i tried.
> 

I can also add that La Monte H. P. Yarroll's patch to daemonize softirqs
seems to provide major improvements in latency (does not help this
problem of course).  There has been at least one other patch posted to
LKML that that does the same thing.  Will this feature be in the kernel
anytime soon?

Lee



