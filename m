Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932591AbVJEKzf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932591AbVJEKzf (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Oct 2005 06:55:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932595AbVJEKzf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Oct 2005 06:55:35 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:53419 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S932591AbVJEKze (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Oct 2005 06:55:34 -0400
Date: Wed, 5 Oct 2005 12:56:05 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Mark Knecht <markknecht@gmail.com>
Cc: tglx@linutronix.de, Steven Rostedt <rostedt@kihontech.com>,
       linux-kernel@vger.kernel.org
Subject: Re: 2.6.14-rc3-rt2
Message-ID: <20051005105605.GA27075@elte.hu>
References: <20051004084405.GA24296@elte.hu> <43427AD9.9060104@cybsft.com> <20051004130009.GB31466@elte.hu> <5bdc1c8b0510040944q233f14e6g17d53963a4496c1f@mail.gmail.com> <5bdc1c8b0510041111n188b8e14lf5a1398406d30ec4@mail.gmail.com> <1128450029.13057.60.camel@tglx.tec.linutronix.de> <5bdc1c8b0510041158m3620f5dcy2dafda545ad3cd5e@mail.gmail.com> <1128458707.13057.68.camel@tglx.tec.linutronix.de> <5bdc1c8b0510041349g1a4f2484qd17a11812c8ccac3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5bdc1c8b0510041349g1a4f2484qd17a11812c8ccac3@mail.gmail.com>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=AWL autolearn=disabled SpamAssassin version=3.0.4
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Mark Knecht <markknecht@gmail.com> wrote:

> On 10/4/05, Thomas Gleixner <tglx@linutronix.de> wrote:
> > On Tue, 2005-10-04 at 11:58 -0700, Mark Knecht wrote:
> > > > I guess its related to the priority leak I'm tracking down right now.
> > > > Can you please set following config options and check if you get a bug
> > > > similar to this ?
> > > >
> > > > BUG: init/1: leaked RT prio 98 (116)?
> > > >
> > > > Steven, it goes away when deadlock detection is enabled. Any pointers
> >
> > Thats actually a red hering caused by asymetric accounting which only
> > happens when
> >
> > CONFIG_DEBUG_PREEMPT=y
> > and
> > # CONFIG_RT_DEADLOCK_DETECT is not set
> 
> OK. I'll keep testing then.
> 
> Are you asking me to apply the code you sent or is that for someone 
> else?

could you try the -rt8 kernel, with the same .config that previously 
produced those messages - do the messages still occur?

	Ingo
