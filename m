Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267732AbUG3Vrg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267732AbUG3Vrg (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Jul 2004 17:47:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267681AbUG3Vrg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Jul 2004 17:47:36 -0400
Received: from mustang.oldcity.dca.net ([216.158.38.3]:17317 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S267808AbUG3VqS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Jul 2004 17:46:18 -0400
Subject: Re: [patch] voluntary-preempt-2.6.8-rc2-L2 PS2 keyboard gone south
From: Lee Revell <rlrevell@joe-job.com>
To: Shane Shrybman <shrybman@aei.ca>
Cc: mingo@elte.hu, linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <1091223099.2356.17.camel@mars>
References: <1091196403.2401.10.camel@mars>
	 <1091210620.800.61.camel@mindpipe>  <1091223099.2356.17.camel@mars>
Content-Type: text/plain
Message-Id: <1091223998.800.96.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Fri, 30 Jul 2004 17:46:38 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2004-07-30 at 17:31, Shane Shrybman wrote:
> On Fri, 2004-07-30 at 14:03, Lee Revell wrote:
> > On Fri, 2004-07-30 at 10:06, Shane Shrybman wrote:
> > > Twice while using -L2 my IBM PS2 keyboard has become completely
> > > non-responsive. USB mouse and everything else seems to be fine, but no
> > > LEDs or anything from the keyboard.
> > > 
> > > On both occasions the last key I hit on the keyboard was numlock and the
> > > numlock did not come on and I had to reboot after that.
> > > 
> > > UP, x86, gcc 2.95, scsi + ide, bttv
> > > 
> > 
> > This happened to me, also twice necessitating a reboot.  I am pretty
> > sure I did *not* hit Num Lock last, though the system was under load -
> > multiple builds going on, jackd running, and video playback.  I tried to
> > toggle Num Lock to see if the machine was really locked hard, and it
> > worked for a while (though it did not go on/off exactly once for each
> > time I hit it), then stopped responding.
> > 
> 
> Did this happen with both the rc2-L2 and rc2-M5 kernels for you too?
> 

Have not tried M5 yet (still building).  An improved fix was posted for
the PS/2 problem recently which uses a semaphore and work queues rather
than Ingo's original quick fix of just adding a lock-break.  If the
problem is indeed keyboard-related, this may help.

I also have not determined whether the system freezes completely or
whether it is just the input layer that hangs.  Next time this happens I
will try to ssh in.

Lee

