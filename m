Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262190AbVAKTqf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262190AbVAKTqf (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jan 2005 14:46:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262407AbVAKTqS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jan 2005 14:46:18 -0500
Received: from mail.joq.us ([67.65.12.105]:53667 "EHLO sulphur.joq.us")
	by vger.kernel.org with ESMTP id S262190AbVAKTly (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jan 2005 14:41:54 -0500
To: Matt Mackall <mpm@selenic.com>
Cc: Paul Davis <paul@linuxaudiosystems.com>, Chris Wright <chrisw@osdl.org>,
       Christoph Hellwig <hch@infradead.org>, Andrew Morton <akpm@osdl.org>,
       Lee Revell <rlrevell@joe-job.com>, arjanv@redhat.com, mingo@elte.hu,
       alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [request for inclusion] Realtime LSM
References: <20050110212019.GG2995@waste.org>
	<200501111305.j0BD58U2000483@localhost.localdomain>
	<20050111191701.GT2940@waste.org>
From: "Jack O'Quin" <joq@io.com>
Date: Tue, 11 Jan 2005 13:42:33 -0600
In-Reply-To: <20050111191701.GT2940@waste.org> (Matt Mackall's message of
 "Tue, 11 Jan 2005 11:17:02 -0800")
Message-ID: <87ekgr3g7q.fsf@sulphur.joq.us>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Corporate Culture,
 linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Tue, Jan 11, 2005 at 08:05:08AM -0500, Paul Davis wrote:
>> I am not sure what you mean here. I think we've established that
>> SCHED_OTHER cannot be made adequate for realtime audio work. Its
>> intended purpose (timesharing the machine in ways that should
>> generally benefit tasks that don't do a lot and/or are dominated by
>> user interaction, thus rendering the machine apparently responsive) is
>> really at odds with what we need.

Matt Mackall <mpm@selenic.com> writes:
> We have not established that at all. In principle, because SCHED_OTHER
> tasks running at full priority lie on the boundary between SCHED_OTHER
> and SCHED_FIFO, they can be made to run arbitrarily close to the
> performance of tasks in SCHED_FIFO. With the upside that they won't be
> able to deadlock the machine.
>
> And I mean arbitrarily close in the strict delta-epsilon sense.
> It's not perfect, but neither is SCHED_FIFO, in principle or in
> practice. 

Though inelegant in theory, SCHED_FIFO *has* been shown to work in
practice.  The POSIX 1003.4 committee were not all a bunch of idiots.
That stuff *is* useful and *does* work (given appropriate privileges).

Your assertions have not been reduced to practice.  This is a
significant difference.  Write some code, then we can discuss whether
it solves any problems or not.  I doubt it, but prove me wrong and
next year you can be the proud author of a scheduler used for hundreds
of audio applications.

Meanwhile, what about 2005?  It's "almost upon us".  :-/
-- 
  joq
