Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264838AbUEKQbX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264838AbUEKQbX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 May 2004 12:31:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264866AbUEKQ24
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 May 2004 12:28:56 -0400
Received: from mail.tmr.com ([216.238.38.203]:31493 "EHLO gatekeeper.tmr.com")
	by vger.kernel.org with ESMTP id S264826AbUEKQ1w (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 May 2004 12:27:52 -0400
Date: Tue, 11 May 2004 12:24:24 -0400 (EDT)
From: Bill Davidsen <davidsen@tmr.com>
To: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.6-rc3-mm2 (4KSTACK)
In-Reply-To: <200405092025.41297.bzolnier@elka.pw.edu.pl>
Message-ID: <Pine.LNX.3.96.1040511121328.16430C-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 9 May 2004, Bartlomiej Zolnierkiewicz wrote:

> On Sunday 09 of May 2004 19:00, Bill Davidsen wrote:
> > No it's not that simple, this has nothing to do with binary modules, and
> > everything to do with not making 4k stack the only available
> > configuration in 2.6. Options are fine, but in a stable kernel series I
> > don't think think that the default should change part way into the
> > series, and certainly the availability of the original functionality
> > shouldn't go away, which is what I read AKPMs original post to state as
> > the goal.
> 
> What functionality are you talking about?
> We don't care about out of tree kernel code (be it GPL or Proprietary).

Let me say this one more time, since you keep changing the topic so you
can say that you don't care about something I never mentioned. I am
**NOT** talking about binary modules, I am **NOT** talking about out of
tree code, I am talking about applications which make calls that cause the
**IN TREE** code to use more than 4k.

> 
> > Making changes to the kernel which will break existing applications
> > seems to be the opposite of "stable." People who want a new kernel for
> > fixes don't usually want to have to upgrade and/or rewrite their
> > applications. The "we change the system interface everything we fix a
> 
> You don't understand what the patch is really about.
> 
> This is kernel stack not the user-space one so
> this change can't brake any application.

Right, the kernel code does not contain any places where the data passed
in a system call isn't reflected in stack usage.

> 
> > bug" approach comes from a well-known software company, but shouldn't be
> > the way *good* software is done.
> 
> It doesn't change any kernel interface visible to user-space
> and stack hungry kernel code needs fixing anyway.

And what better way to detect it than to release it in a stable kernel.
Don't bother to say "don't use -mm" AKPM has said it is intended for the
stable kernel, work or not.

===
Third request for info
===
I still haven't seen any objective data showing that there is any
measureable benefit from this, although I agree that smaller is good
practice, I don't think that throwing in a feature in a stable kernel,
which has been reported by others to corrupt data, is the best way to do
it.

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

