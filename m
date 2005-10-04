Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964972AbVJDUwZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964972AbVJDUwZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Oct 2005 16:52:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964973AbVJDUwZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Oct 2005 16:52:25 -0400
Received: from 213-239-205-147.clients.your-server.de ([213.239.205.147]:30347
	"EHLO mail.tglx.de") by vger.kernel.org with ESMTP id S964972AbVJDUwY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Oct 2005 16:52:24 -0400
Subject: Re: 2.6.14-rc3-rt2
From: Thomas Gleixner <tglx@linutronix.de>
Reply-To: tglx@linutronix.de
To: Mark Knecht <markknecht@gmail.com>
Cc: Steven Rostedt <rostedt@kihontech.com>, Ingo Molnar <mingo@elte.hu>,
       linux-kernel@vger.kernel.org
In-Reply-To: <5bdc1c8b0510041349g1a4f2484qd17a11812c8ccac3@mail.gmail.com>
References: <20051004084405.GA24296@elte.hu> <43427AD9.9060104@cybsft.com>
	 <20051004130009.GB31466@elte.hu>
	 <5bdc1c8b0510040944q233f14e6g17d53963a4496c1f@mail.gmail.com>
	 <5bdc1c8b0510041111n188b8e14lf5a1398406d30ec4@mail.gmail.com>
	 <1128450029.13057.60.camel@tglx.tec.linutronix.de>
	 <5bdc1c8b0510041158m3620f5dcy2dafda545ad3cd5e@mail.gmail.com>
	 <1128458707.13057.68.camel@tglx.tec.linutronix.de>
	 <5bdc1c8b0510041349g1a4f2484qd17a11812c8ccac3@mail.gmail.com>
Content-Type: text/plain
Organization: linutronix
Date: Tue, 04 Oct 2005 22:53:37 +0200
Message-Id: <1128459217.13057.73.camel@tglx.tec.linutronix.de>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-10-04 at 13:49 -0700, Mark Knecht wrote:
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
> Are you asking me to apply the code you sent or is that for someone else?

Please apply, but the second version I sent :(

Pilot error. Will not solve the other problem you are seeing. Looking
into this right now.

tglx


