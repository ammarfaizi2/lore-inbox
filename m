Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751509AbWA0Qzq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751509AbWA0Qzq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Jan 2006 11:55:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751514AbWA0Qzq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Jan 2006 11:55:46 -0500
Received: from mail.gmx.de ([213.165.64.21]:30173 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1751509AbWA0Qzq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Jan 2006 11:55:46 -0500
X-Authenticated: #14349625
Message-Id: <5.2.1.1.2.20060127175530.00c3db30@pop.gmx.net>
X-Mailer: QUALCOMM Windows Eudora Version 5.2.1
Date: Fri, 27 Jan 2006 17:57:32 +0100
To: Mike Galbraith <efault@gmx.de>
From: Con Kolivas <kernel@kolivas.org> (by way of Mike Galbraith
	<efault@gmx.de>)
Subject: Re: [SCHED] wrong priority calc - SIMPLE test case
Cc: Paolo Ornati <ornati@fastwebnet.it>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Ingo Molnar <mingo@elte.hu>, Nick Piggin <nickpiggin@yahoo.com.au>,
       Andrew Morton <akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
X-Antivirus: avast! (VPS 0604-3, 01/26/2006), Outbound message
X-Antivirus-Status: Clean
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 14 January 2006 03:15, Mike Galbraith wrote:
 > At 01:34 AM 1/14/2006 +1100, Con Kolivas wrote:
 > >On Saturday 14 January 2006 00:01, Mike Galbraith wrote:
 > > > At 09:51 PM 1/13/2006 +1100, Con Kolivas wrote:
 > > > >See my followup patches that I have posted following "[PATCH 0/5]
 > > > > sched - interactivity updates". The first 3 patches are what you
 > > > > tested. These patches are being put up for testing hopefully in -mm.
 > > >
 > > > Then the (buggy) version of my simple throttling patch will need to
 > > > come out.  (which is OK, I have a debugged potent++ version)
 > >
 > >Your code need not be mutually exclusive with mine. I've simply damped the
 > >current behaviour. Your sanity throttling is a good idea.
 >
 > I didn't mean to imply that they're mutually exclusive, and after doing
 > some testing, I concluded that it (or something like it) is definitely
 > still needed.  The version that's in mm2 _is_ buggy however, so ripping it
 > back out wouldn't hurt my delicate little feelings one bit.  In fact, it
 > would give me some more time to instrument and test integration with your
 > changes.

Ok I've communicated this to Andrew (cc'ed here too) so he should remove your
patch pending a new version from you.

 > (Which I think are good btw because they remove what I considered
 > to be warts; the pipe and uninterruptible sleep barriers.

Yes I felt your abuse wrt to these in an earlier email...

 > Um... try irman2
 > now... pure evilness)

Hrm I've been using staircase which is immune for so long I'd all but
forgotten about this test case. Looking at your code I assume your changes
should help this?

Con
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/

