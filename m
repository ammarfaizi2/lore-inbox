Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261711AbULNWuk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261711AbULNWuk (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Dec 2004 17:50:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261726AbULNWtj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Dec 2004 17:49:39 -0500
Received: from mustang.oldcity.dca.net ([216.158.38.3]:6589 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S261709AbULNWrP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Dec 2004 17:47:15 -0500
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.10-rc3-mm1-V0.7.33-0
From: Lee Revell <rlrevell@joe-job.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: Steven Rostedt <rostedt@goodmis.org>, LKML <linux-kernel@vger.kernel.org>,
       Rui Nuno Capela <rncbc@rncbc.org>,
       Mark Johnson <Mark_H_Johnson@RAYTHEON.COM>,
       "K.R. Foley" <kr@cybsft.com>, Bill Huey <bhuey@lnxw.com>,
       Adam Heath <doogie@debian.org>, Florian Schmidt <mista.tapas@gmx.net>,
       Thomas Gleixner <tglx@linutronix.de>,
       Fernando Pablo Lopez-Lezcano <nando@ccrma.Stanford.EDU>,
       George Anzinger <george@mvista.com>,
       Paul Davis <paul@linuxaudiosystems.com>
In-Reply-To: <20041214223118.GD22043@elte.hu>
References: <20041124101626.GA31788@elte.hu>
	 <20041203205807.GA25578@elte.hu> <20041207132927.GA4846@elte.hu>
	 <20041207141123.GA12025@elte.hu> <20041214132834.GA32390@elte.hu>
	 <1103052853.3582.46.camel@localhost.localdomain>
	 <1103054908.14699.20.camel@krustophenia.net>
	 <1103057144.3582.51.camel@localhost.localdomain>
	 <20041214211828.GA17216@elte.hu>
	 <1103062423.14699.48.camel@krustophenia.net>
	 <20041214223118.GD22043@elte.hu>
Content-Type: text/plain
Date: Tue, 14 Dec 2004 17:47:11 -0500
Message-Id: <1103064432.14699.69.camel@krustophenia.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-12-14 at 23:31 +0100, Ingo Molnar wrote:
> * Lee Revell <rlrevell@joe-job.com> wrote:
> 
> > On Tue, 2004-12-14 at 22:18 +0100, Ingo Molnar wrote:
> > > the two projects are obviously complementary and i have no intention to
> > > reinvent the wheel in any way. Best would be to bring hires timers up to
> > > upstream-mergable state (independently of the -RT patch) and ask Andrew
> > > to include it in -mm, then i'd port -RT to it automatically.
> > 
> > Among other things I think Paul Davis mentioned that George's high res
> > timer patch would make it possible for JACK to send MIDI clock.  This
> > would be a huge improvement.
> 
> <clueless question> roughly what latency/accuracy requirements does the
> MIDI clock have, and why is it an advantage if Linux generates it? What
> generates it otherwise - external MIDI hardware? Or was the problem
> mainly not latency/accuracy but that Linux couldnt generate a
> finegrained enough clock?

Being able to send or receive MIDI clock is a common feature for
hardware and software samplers, sequencers, etc.  It just allows more
flexibility in your setup.  I think currently Linux can receive MIDI
clock better than it can send.

To answer the last question I think the clock was not fine grained
enough.  But as far as timing requirements I don't actually know the
details.  Paul?

Lee



