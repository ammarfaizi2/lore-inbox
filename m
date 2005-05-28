Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261770AbVE1E13@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261770AbVE1E13 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 May 2005 00:27:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261788AbVE1E12
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 May 2005 00:27:28 -0400
Received: from viper.oldcity.dca.net ([216.158.38.4]:698 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S261770AbVE1E1Y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 May 2005 00:27:24 -0400
Subject: Re: RT patch acceptance
From: Lee Revell <rlrevell@joe-job.com>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: "Bill Huey (hui)" <bhuey@lnxw.com>, Andi Kleen <ak@muc.de>,
       Sven-Thorsten Dietrich <sdietrich@mvista.com>,
       Ingo Molnar <mingo@elte.hu>, dwalker@mvista.com, hch@infradead.org,
       akpm@osdl.org, linux-kernel@vger.kernel.org
In-Reply-To: <4297EB57.5090902@yahoo.com.au>
References: <20050524192029.2ef75b89.akpm@osdl.org>
	 <20050525063306.GC5164@elte.hu> <m1br6zxm1b.fsf@muc.de>
	 <1117044019.5840.32.camel@sdietrich-xp.vilm.net>
	 <20050526193230.GY86087@muc.de>
	 <1117138270.1583.44.camel@sdietrich-xp.vilm.net>
	 <20050526202747.GB86087@muc.de> <4296ADE9.50805@yahoo.com.au>
	 <20050527120812.GA375@nietzsche.lynx.com> <429715DE.6030008@yahoo.com.au>
	 <20050527233645.GA2283@nietzsche.lynx.com>  <4297EB57.5090902@yahoo.com.au>
Content-Type: text/plain
Date: Sat, 28 May 2005 00:27:22 -0400
Message-Id: <1117254442.4253.12.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.3.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2005-05-28 at 13:53 +1000, Nick Piggin wrote:
> Run RT programs in your RT kernel, and GP programs in your Linux
> kernel. The only time one will have to cross into the other domain
> is when they want to communicate with one another.
> 

And what about a multithreaded program with RT and non-RT threads?

> 
> > the resources to make every kernel subsystems hard RT capable. You
> > have this idea where you'd like get at SGI's XFS's homogenous object
> > storage to stream video data with guaranteed IO rates. This needs to
> > be running in an RT domain so that guarantees can be tightly controlled
> 
> That may be a complex problem, but it really doesn't get any simpler
> when doing it with a single kernel: all those subsystems still have
> to be contended with.
> 
> But it's getting a little hand-wavy, I think someone would have to
> really be at death's door before trusting Linux (even with PREEMPT_RT)
> and XFS to give hard RT IO guarantees any time in the next 5 or 10
> years.
> 

No one ever said anything about hard RT IO, or making any syscalls hard
RT.  AFAIK this has never even come up during the PREEMPT_RT
development.  We just want our userspace code to be scheduled as soon as
it's runnable.  For the purposes of this entire thread, it's safe to
assume that if the RT thread does make any syscalls, it knows exactly
what it is doing, as in the JACK write() example.

Lee

