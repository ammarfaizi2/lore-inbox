Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261158AbVA0UDf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261158AbVA0UDf (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Jan 2005 15:03:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261155AbVA0UDX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Jan 2005 15:03:23 -0500
Received: from mustang.oldcity.dca.net ([216.158.38.3]:51160 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S261157AbVA0UB3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Jan 2005 15:01:29 -0500
Subject: Re: [patch, 2.6.11-rc2] sched: RLIMIT_RT_CPU_RATIO feature
From: Lee Revell <rlrevell@joe-job.com>
To: "Jack O'Quin" <joq@io.com>
Cc: Nick Piggin <nickpiggin@yahoo.com.au>, Ingo Molnar <mingo@elte.hu>,
       Paul Davis <paul@linuxaudiosystems.com>,
       Con Kolivas <kernel@kolivas.org>, linux <linux-kernel@vger.kernel.org>,
       CK Kernel <ck@vds.kolivas.org>, utz <utz@s2y4n2c.de>,
       Andrew Morton <akpm@osdl.org>, alexn@dsv.su.se,
       Rui Nuno Capela <rncbc@rncbc.org>, Chris Wright <chrisw@osdl.org>,
       Arjan van de Ven <arjanv@redhat.com>
In-Reply-To: <87pszr1mi1.fsf@sulphur.joq.us>
References: <200501201542.j0KFgOwo019109@localhost.localdomain>
	 <87y8eo9hed.fsf@sulphur.joq.us> <20050120172506.GA20295@elte.hu>
	 <87wtu6fho8.fsf@sulphur.joq.us> <20050122165458.GA14426@elte.hu>
	 <87hdl940ph.fsf@sulphur.joq.us> <20050124085902.GA8059@elte.hu>
	 <20050124125814.GA31471@elte.hu> <20050125135613.GA18650@elte.hu>
	 <87sm4opxto.fsf@sulphur.joq.us> <20050126070404.GA27280@elte.hu>
	 <87fz0neshg.fsf@sulphur.joq.us> <1106782165.5158.15.camel@npiggin-nld.site>
	 <874qh3bo1u.fsf@sulphur.joq.us> <1106796360.5158.39.camel@npiggin-nld.site>
	 <87pszr1mi1.fsf@sulphur.joq.us>
Content-Type: text/plain
Date: Thu, 27 Jan 2005 15:01:24 -0500
Message-Id: <1106856085.25754.10.camel@krustophenia.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-01-26 at 23:15 -0600, Jack O'Quin wrote:
> >> > And finally, with rlimit support, is there any reason why lockup
> >> > detection and correction can't go into userspace? Even RT
> >> > throttling could probably be done in a userspace daemon.
> >> 
> >> It can.  But, doing it in the kernel is more efficient, and probably
> >> more reliable.
> >
> > Possibly. But the people who want a solution seem to be in a very
> > small minority, and I'm not sure how much you care about efficiency.
> 
> I do care.  The average overhead of running a watchdog daemon at max
> priority is tiny.  But, its impact on worst-case trigger latencies is
> non-trivial and must be added to everything else in the RT subsystem.

Keep in mind that with the max RT prio rlimit solution audio systems
using JACK would not even need the external watchdog thread, because
JACK already has its own watchdog thread.  I also like the max RT prio
rlimit approach with (optional) watchdog thread running as root because
it really seems to be the least intrusive out of several good solutions
to the problem and puts policy details (when to throttle an RT thread)
in userspace.

Lee

