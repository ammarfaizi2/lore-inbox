Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030623AbVJ1Sop@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030623AbVJ1Sop (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Oct 2005 14:44:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030630AbVJ1Sop
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Oct 2005 14:44:45 -0400
Received: from mustang.oldcity.dca.net ([216.158.38.3]:4992 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S1030623AbVJ1Sop (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Oct 2005 14:44:45 -0400
Subject: Re: Overruns are killing my recordings.
From: Lee Revell <rlrevell@joe-job.com>
To: Mark Knecht <markknecht@gmail.com>
Cc: lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <5bdc1c8b0510280752y5b7a665cpfdd512d15f896482@mail.gmail.com>
References: <3aa654a40510271212j13e0843s9de81c02f4e766ac@mail.gmail.com>
	 <200510271528.28919.diablod3@gmail.com>
	 <3aa654a40510271257t62d2fd82n5f2bcbcae2bcba9d@mail.gmail.com>
	 <1130447216.19492.87.camel@mindpipe>
	 <3aa654a40510271700l49fb06cfv37d8b6030df5ac49@mail.gmail.com>
	 <1130470852.4363.26.camel@mindpipe>
	 <5bdc1c8b0510280752y5b7a665cpfdd512d15f896482@mail.gmail.com>
Content-Type: text/plain
Date: Fri, 28 Oct 2005 14:43:25 -0400
Message-Id: <1130525006.4363.44.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.0 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-10-28 at 07:52 -0700, Mark Knecht wrote:
> On 10/27/05, Lee Revell <rlrevell@joe-job.com> wrote:
> > On Thu, 2005-10-27 at 17:00 -0700, Avuton Olrich wrote:
> > > aggh. Sorry for all the noise,
> > >
> > > I have all my drives on a linear raid and I had hdparm set to put my
> > > IDE drives to sleep after a while, I didn't put it together because it
> > > was happening in the middle of recording.
> >
> > Hey, I think it's a testament to the progress that has been made in the
> > past year and a half that people now consider audio dropouts in a "known
> > good" app like ecasound to be a kernel bug.  For the longest time the
> > answer was "linux isn't an RTOS, deal with it".
> >
> > Lee
> 
> Lee, et. all,
>    Could this possibly be part of what is causing my xrun problems? I
> had a huge rash of xruns yesterday. I seem to run into issues after
> longer times of inactivity. I hadn't considered this possibility
> before.

I really doubt it.  It's more likely that the xruns are caused by a bug
in the new ktimers system.  I am seeing "xruns" here too with -rt1, but
the latency tracer does not report anything over ~120 usecs.  Previous
to all the ktimers/HRT stuff going in, I was xrun free for months.

The reason I think it's a ktimers bug is because sometimes JACK reports
an xrun of negative length which I'd NEVER seen before.

I suspect this might all be fixed in the latest -rt patch but I have not
had time to build it.

Lee

