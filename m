Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261893AbVANDdg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261893AbVANDdg (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jan 2005 22:33:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261873AbVANDdf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jan 2005 22:33:35 -0500
Received: from smtp104.mail.sc5.yahoo.com ([66.163.169.223]:19535 "HELO
	smtp104.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S261893AbVANDbl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jan 2005 22:31:41 -0500
Subject: Re: [PATCH] [request for inclusion] Realtime LSM
From: Nick Piggin <nickpiggin@yahoo.com.au>
To: Con Kolivas <kernel@kolivas.org>
Cc: Andrew Morton <akpm@osdl.org>, Paul Davis <paul@linuxaudiosystems.com>,
       lkml@s2y4n2c.de, rlrevell@joe-job.com, arjanv@redhat.com, joq@io.com,
       chrisw@osdl.org, mpm@selenic.com, hch@infradead.org, mingo@elte.hu,
       alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org
In-Reply-To: <41E739F4.1030902@kolivas.org>
References: <1105669451.5402.38.camel@npiggin-nld.site>
	 <200501140240.j0E2esKG026962@localhost.localdomain>
	 <20050113191237.25b3962a.akpm@osdl.org>  <41E739F4.1030902@kolivas.org>
Content-Type: text/plain
Date: Fri, 14 Jan 2005 14:31:21 +1100
Message-Id: <1105673482.5402.58.camel@npiggin-nld.site>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-01-14 at 14:18 +1100, Con Kolivas wrote:
> Andrew Morton wrote:
> > Paul Davis <paul@linuxaudiosystems.com> wrote:
> > 
> >>>SCHED_FIFO and SCHED_RR are definitely privileged operations and you
> >>
> >>this is the crux of what this whole debate is about. for all of you
> >>people who think about linux on multi-user systems with network
> >>connectivity, running servers and so forth, this is clearly a given.
> >>
> >>but there is large and growing body of machines that run linux where
> >>the sole human user of the machine has a strong and overwhelming
> >>desire to have tasks run with the characteristics offered by
> >>SCHED_FIFO and/or SCHED_RR. are they still "privileged" operations on
> >>this class of linux system? what about linux installed on an embedded
> >>system, with a small LCD screen and the sole purpose of running audio
> >>apps live? are they still privileged then?
> >>
> > 
> > 
> > Paul.  Everyone agrees with you.  I think.  We just need to work out
> > the best way of doing it.
> > 
> > Would I be right in suspecting that we know what to do, but nobody has
> > stepped up to write the code?  It's kinda looking like that?
> 
> I thought I made it clear i had already volunteered. I was after a 
> response to my proposal for how to do it.
> 

It sounds to me like both your proposals may be too complex and not
sufficiently deterministic (I don't know for sure, maybe that's
exactly what the RT people want).

I wouldn't have thought it is so much a matter of having real-time-ish
scheduling available that tries to play nicely in a multi user machine.
That must still imply that either the user is able to unduly tie up
resources (and thus it has to be a privileged operation), or that it
sometimes can't meet its "guarantees" (in which case, is it useful?).

I was thinking that the solution might be more along the lines of
a nice way to handle privileges for these guys.

I could be completely off the rails though. I haven't really been
following this thread so please shoot me in my foot if I have put it
in my mouth.



