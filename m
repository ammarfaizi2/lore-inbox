Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269688AbUJSVay@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269688AbUJSVay (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Oct 2004 17:30:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266357AbUJSVLW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Oct 2004 17:11:22 -0400
Received: from mustang.oldcity.dca.net ([216.158.38.3]:26331 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S269896AbUJSVAl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Oct 2004 17:00:41 -0400
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.9-rc4-mm1-U6
From: Lee Revell <rlrevell@joe-job.com>
To: Adam Heath <doogie@debian.org>
Cc: Ingo Molnar <mingo@elte.hu>, linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.58.0410191351550.1219@gradall.private.brainfood.com>
References: <20041012195424.GA3961@elte.hu> <20041013061518.GA1083@elte.hu>
	 <20041014002433.GA19399@elte.hu> <20041014143131.GA20258@elte.hu>
	 <20041014234202.GA26207@elte.hu> <20041015102633.GA20132@elte.hu>
	 <20041016153344.GA16766@elte.hu> <20041018145008.GA25707@elte.hu>
	 <20041019124605.GA28896@elte.hu>
	 <Pine.LNX.4.58.0410191222050.1216@gradall.private.brainfood.com>
	 <20041019173510.GA18323@elte.hu>
	 <Pine.LNX.4.58.0410191351550.1219@gradall.private.brainfood.com>
Content-Type: text/plain
Message-Id: <1098219574.23367.3.camel@krustophenia.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Tue, 19 Oct 2004 16:59:34 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-10-19 at 14:52, Adam Heath wrote:
> On Tue, 19 Oct 2004, Ingo Molnar wrote:
> 
> >
> > * Adam Heath <doogie@debian.org> wrote:
> >
> > > I am still having the same bug(repeatable by running liquidwar) as I
> > > reported with -U5(see my earlier email).
> >
> > ok, this seems to be some questionable code in OSS. It really has no
> > business up()-ing the inode semaphore - nobody down()-ed it before! This
> > could be either a bad workaround for a bug/hang someone saw, or an old
> > VFS assumption that doesnt hold anymore. In any case, could you try the
> > patch below, does it fix liquidwar?
> 
> Yup, the below fixes it.  However, this problem *only* started occuring in
> -U5.  I've been running liquidwar on all versions(it's my current
> game-to-play-when-I-feel-stupid program).

The real fix is to use ALSA. :-)

Lee

