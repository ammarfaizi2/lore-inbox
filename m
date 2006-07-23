Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751247AbWGWQFS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751247AbWGWQFS (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 23 Jul 2006 12:05:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751249AbWGWQFR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 23 Jul 2006 12:05:17 -0400
Received: from ms-smtp-01.nyroc.rr.com ([24.24.2.55]:31421 "EHLO
	ms-smtp-01.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S1751247AbWGWQFQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 23 Jul 2006 12:05:16 -0400
Subject: Re: [patch 3/3] [-rt] Fixes the timeout-bug in the
	rtmutex/PI-futex.
From: Steven Rostedt <rostedt@goodmis.org>
To: Esben Nielsen <nielsen.esben@googlemail.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@elte.hu>,
       LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.64.0607231756070.9903@localhost.localdomain>
References: <20060723005210.973833000@localhost>
	 <Pine.LNX.4.64.0607230217390.11861@localhost.localdomain>
	 <1153666661.4002.4.camel@localhost.localdomain>
	 <Pine.LNX.4.64.0607231756070.9903@localhost.localdomain>
Content-Type: text/plain
Date: Sun, 23 Jul 2006 12:05:11 -0400
Message-Id: <1153670711.4002.9.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> > haven't analyzed it enough yet.  But just so that you know that your
> > changes don't break the code, and to make it easier for me to look at
> > it. Please update Documentation/rt-mutex-design.txt including your
> > changes.  This will be a good exercise to see if it doesn't really break
> > anything, and it will give other reviewers a better starting point for
> > review.
> 
> Is that up-to-date in the -rt tree? The last patch you sent was to 
> 2.6.18-rc2, right?

Ah, you're right. I thought this was for mainline.  Didn't notice the
-rt in the subject.  Don't worry about documenting the -rt side of
things.  That is not stable enough to do so.  When portions of the rt
patch go to -mm, that will need to be documented. (willing to help in
this effort?)

I'll try later today to review your code a little deeper (no guarantees
since I just came home from Ottawa, and my family would like to see me a
little more).  I'm not sure if the semantics of the changes to the
sched.[ch] are correct, so I'll let Ingo comment on them.  I'll spend my
time looking at the changes to rtmutex.c.
 
-- Steve

