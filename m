Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751696AbWDCPVi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751696AbWDCPVi (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Apr 2006 11:21:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751702AbWDCPVi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Apr 2006 11:21:38 -0400
Received: from ms-smtp-01.nyroc.rr.com ([24.24.2.55]:32428 "EHLO
	ms-smtp-01.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S1751696AbWDCPVh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Apr 2006 11:21:37 -0400
Subject: [PATCH -rt 00/02] fix wrapping of get time of day.
From: Steven Rostedt <rostedt@goodmis.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@elte.hu>, john stultz <johnstul@us.ibm.com>,
       LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Date: Mon, 03 Apr 2006 11:21:29 -0400
Message-Id: <1144077689.21444.6.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.2.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thomas,

Can you look at these next two patches to see if they are decent.

The first patch is a simple update to allow for CB_IRQSAFE functions to
return HRTIMER_RESTART.  The next patch uses this in timeofday to
periodically update a time interval so that the last_cycle doesn't wrap.
Now if we have HIGH_RES turned off, this needs an update to make the
cycle update function a high priority.  But since that isn't simple to
do yet without hacking a change of priority when setting up, I'm leaving
it as is.

-- Steve


