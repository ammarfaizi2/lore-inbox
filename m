Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262425AbVAEN6g@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262425AbVAEN6g (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Jan 2005 08:58:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262431AbVAEN6g
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Jan 2005 08:58:36 -0500
Received: from dfw-gate4.raytheon.com ([199.46.199.233]:17112 "EHLO
	dfw-gate4.raytheon.com") by vger.kernel.org with ESMTP
	id S262425AbVAEN6a (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Jan 2005 08:58:30 -0500
Subject: Re: Real-Time Preemption, comparison to 2.6.10-mm1
To: Lee Revell <rlrevell@joe-job.com>
Cc: Andrew Morton <akpm@osdl.org>, Bill Huey <bhuey@lnxw.com>,
       Adam Heath <doogie@debian.org>, "K.R. Foley" <kr@cybsft.com>,
       linux-kernel@vger.kernel.org, Ingo Molnar <mingo@elte.hu>,
       Florian Schmidt <mista.tapas@gmx.net>,
       Fernando Pablo Lopez-Lezcano <nando@ccrma.Stanford.EDU>,
       Rui Nuno Capela <rncbc@rncbc.org>, Steven Rostedt <rostedt@goodmis.org>,
       Thomas Gleixner <tglx@linutronix.de>
X-Mailer: Lotus Notes Release 5.0.8  June 18, 2001
Message-ID: <OFA8EC1208.C9EB05D9-ON86256F80.004C2451@raytheon.com>
From: Mark_H_Johnson@raytheon.com
Date: Wed, 5 Jan 2005 07:55:55 -0600
X-MIMETrack: Serialize by Router on RTSHOU-DS01/RTS/Raytheon/US(Release 6.5.2|June 01, 2004) at
 01/05/2005 07:57:34 AM
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
X-SPAM: 0.00
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Tue, 2005-01-04 at 14:11 -0600, Mark_H_Johnson@raytheon.com wrote:
> > The non RT application starvation for mm1 was much less
> > pronounced but still present. I could watch the disk light
> > on the last two tests & see it go out (and stay out) for an
> > extended period. It does not make sense to me that a single RT
> > application (on a two CPU machine) and a nice'd non RT application
> > can cause this starvation behavior. This behavior was not
> > present on the 2.4 kernels and seems to be a regression to me.

> I think I am seeing this problem too.  It doesn't just apply to RT
> tasks, it seems that CPU bound tasks starve each other.  I noticed that
> with the RT kernel, a kernel compile or dpkg will starve evolution, to
> the point where it takes 30 seconds to display a message.  If I go and
> background the CPU hog, the message renders _instantly_.

> It's definitely present with 2.6.10-rc2 + RT (PK config) and absent with
> 2.6.10 vanilla.  I need to figure out whether -mm has the problem.
My point was that -mm definitely has the problem (though to a lesser
degree). The tests I ran showed it on both the disk read and disk copy
stress tests. I guess I should try a vanilla 2.6.10 run as well to see
if it is something introduced in the -mm series (it certainly is not a
recent change...).

--Mark H Johnson
  <mailto:Mark_H_Johnson@raytheon.com>

