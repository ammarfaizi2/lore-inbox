Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1945911AbWANBK1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1945911AbWANBK1 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Jan 2006 20:10:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1945941AbWANBK1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Jan 2006 20:10:27 -0500
Received: from ms-smtp-02.nyroc.rr.com ([24.24.2.56]:13013 "EHLO
	ms-smtp-02.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S1945911AbWANBK0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Jan 2006 20:10:26 -0500
Subject: RE: Dual core Athlons and unsynced TSCs
From: Steven Rostedt <rostedt@goodmis.org>
To: john stultz <johnstul@us.ibm.com>
Cc: Lee Revell <rlrevell@joe-job.com>, Thomas Gleixner <tglx@linutronix.de>,
       Ingo Molnar <mingo@elte.hu>, Roger Heflin <rheflin@atipa.com>,
       "'linux-kernel'" <linux-kernel@vger.kernel.org>
In-Reply-To: <1137198221.11300.21.camel@cog.beaverton.ibm.com>
References: <EXCHG2003rmTIVvLVKi00000c7b@EXCHG2003.microtech-ks.com>
	 <1137168254.7241.32.camel@localhost.localdomain>
	 <1137174463.15108.4.camel@mindpipe>
	 <Pine.LNX.4.58.0601131252300.8806@gandalf.stny.rr.com>
	 <1137174848.15108.11.camel@mindpipe>
	 <Pine.LNX.4.58.0601131338370.6971@gandalf.stny.rr.com>
	 <1137178506.15108.38.camel@mindpipe>
	 <1137182991.8283.7.camel@localhost.localdomain>
	 <1137198221.11300.21.camel@cog.beaverton.ibm.com>
Content-Type: text/plain
Date: Fri, 13 Jan 2006 20:10:12 -0500
Message-Id: <1137201012.6727.1.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-01-13 at 16:23 -0800, john stultz wrote:

> > Failed! prev: 6279.925610302   current: 6279.874615349
> 
> Not sure, but I think your test is broken.

Yep and it is now fixed:

http://www.kihontech.com/tests/rt/monotonic.c


> 
> Attached is a similar testcase that I've been using myself that avoids
> this issue (although I just converted it from gettimeofday to
> clock_gettime, so there may still be an issue). Let me know if you have
> any comments on it.

Thanks, I'll add that to my list of tests too.

Oh and 2.6.15 passed as well (with clock=pmtmr)

-- Steve


