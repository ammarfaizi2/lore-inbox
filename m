Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272552AbRIRXaY>; Tue, 18 Sep 2001 19:30:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273964AbRIRXaO>; Tue, 18 Sep 2001 19:30:14 -0400
Received: from maynard.mail.mindspring.net ([207.69.200.243]:61465 "EHLO
	maynard.mail.mindspring.net") by vger.kernel.org with ESMTP
	id <S272552AbRIRXaF>; Tue, 18 Sep 2001 19:30:05 -0400
Subject: Re: Feedback on preemptible kernel patch
From: Robert Love <rml@ufl.edu>
To: Roger Larsson <roger.larsson@norran.net>
Cc: Dieter =?ISO-8859-1?Q?N=FCtzel?= <Dieter.Nuetzel@hamburg.de>,
        Linux Kernel List <linux-kernel@vger.kernel.org>
In-Reply-To: <200109181822.f8IIMv618968@mailg.telia.com>
In-Reply-To: <200109140302.f8E32LG13400@zero.tech9.net>
	<1000530869.32365.21.camel@phantasy>
	<20010918040550Z273827-761+10122@vger.kernel.org> 
	<200109181822.f8IIMv618968@mailg.telia.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.13.99+cvs.2001.09.18.07.08 (Preview Release)
Date: 18 Sep 2001 19:31:28 -0400
Message-Id: <1000855890.19833.51.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2001-09-18 at 14:18, Roger Larsson wrote:
> Do you run with the playback process reniced -N?
> It should really run with a low SCHED_FIFO or SCHED_RT policy.
> But renicing it with a negative value gives some of the benefits...
> (but you need to run as root)
> In addition to this the program might need to lock its pages down - the
> only thing I can think of that could cause several seconds delay would
> be if it has been swapped out...

Certainly giving it a higher priority should improve results (especially
with preemption), but the application should receive a fair amount of
process attention as it is, as it is TASK_RUNNABLE at all times and the
disk I/O should be routinely preempted.  I am interested how much
renicing it helps, though.

Now, if it has to swap pages, that is a very good point.  I tend to
blame this, or perhaps something with a long held lock (the audio
driver?) for the blips.

Its so hard to tell swap/VM issues now with all the VM work, sadly...:)

-- 
Robert M. Love
rml at ufl.edu
rml at tech9.net

