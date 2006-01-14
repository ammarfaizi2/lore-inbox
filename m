Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1945972AbWANBuK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1945972AbWANBuK (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Jan 2006 20:50:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1945973AbWANBuK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Jan 2006 20:50:10 -0500
Received: from e36.co.us.ibm.com ([32.97.110.154]:8917 "EHLO e36.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S1945972AbWANBuI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Jan 2006 20:50:08 -0500
Subject: RE: Dual core Athlons and unsynced TSCs
From: john stultz <johnstul@us.ibm.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Lee Revell <rlrevell@joe-job.com>, Thomas Gleixner <tglx@linutronix.de>,
       Ingo Molnar <mingo@elte.hu>, Roger Heflin <rheflin@atipa.com>,
       "'linux-kernel'" <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.58.0601132042050.7584@gandalf.stny.rr.com>
References: <EXCHG2003rmTIVvLVKi00000c7b@EXCHG2003.microtech-ks.com>
	 <1137168254.7241.32.camel@localhost.localdomain>
	 <1137174463.15108.4.camel@mindpipe>
	 <Pine.LNX.4.58.0601131252300.8806@gandalf.stny.rr.com>
	 <1137174848.15108.11.camel@mindpipe>
	 <Pine.LNX.4.58.0601131338370.6971@gandalf.stny.rr.com>
	 <1137178506.15108.38.camel@mindpipe>
	 <1137182991.8283.7.camel@localhost.localdomain>
	 <1137198221.11300.21.camel@cog.beaverton.ibm.com>
	 <1137201012.6727.1.camel@localhost.localdomain>
	 <1137201250.1408.39.camel@mindpipe>
	 <1137201821.11300.30.camel@cog.beaverton.ibm.com>
	 <1137202039.1408.42.camel@mindpipe>
	 <1137202773.11300.37.camel@cog.beaverton.ibm.com>
	 <Pine.LNX.4.58.0601132042050.7584@gandalf.stny.rr.com>
Content-Type: text/plain
Date: Fri, 13 Jan 2006 17:50:02 -0800
Message-Id: <1137203402.11300.41.camel@cog.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-01-13 at 20:43 -0500, Steven Rostedt wrote:
> On Fri, 13 Jan 2006, john stultz wrote:
> 
> >
> > This is as I understand it:
> >
> > With 2.6.15 on x86-64:
> > 	If available, alternate timesources (HPET, ACPI PM) will be used if
> > available on AMD SMP systems. (clock= is i386 only)
> 
> Hmm, should I boot without the clock= to prove this?

Feel free. That or grep the x86-64 time.c code.

Look for:
	time.c: Using PM based timekeeping.

To verify the timesource selection.

thanks
-john

