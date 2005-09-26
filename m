Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932090AbVIZVDt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932090AbVIZVDt (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Sep 2005 17:03:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932091AbVIZVDs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Sep 2005 17:03:48 -0400
Received: from mx1.redhat.com ([66.187.233.31]:33246 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932090AbVIZVDq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Sep 2005 17:03:46 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
From: Roland McGrath <roland@redhat.com>
To: george@mvista.com
X-Fcc: ~/Mail/linus
Cc: tglx@linutronix.de, Ingo Molnar <mingo@elte.hu>,
       Oleg Nesterov <oleg@tv-sign.ru>, linux-kernel@vger.kernel.org,
       Steven Rostedt <rostedt@goodmis.org>,
       "Paul E. McKenney" <paulmck@us.ibm.com>,
       "'high-res-timers-discourse@lists.sourceforge.net'" 
	<high-res-timers-discourse@lists.sourceforge.net>
Subject: Re: [PATCH 2.6.13-rc6-rt9]  PI aware dynamic priority adjustment
In-Reply-To: George Anzinger's message of  Friday, 19 August 2005 18:36:30 -0700 <4306891E.9060409@mvista.com>
X-Zippy-Says: I'll take ROAST BEEF if you're out of LAMB!!
Message-Id: <20050926210334.65BC7180E1F@magilla.sf.frob.com>
Date: Mon, 26 Sep 2005 14:03:34 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On another issue along this line, I have been thinking of changing the 
> x86 TSC arch cycle size to 1ns.  (NOT the resolution, the units for the 
> arch cycle.)  The reason to do this is to correctly track changes in cpu 
> frequency as it is today, we would need to track down and update all 
> pending HR timers when ever the frequency changed.  By using a common 
> unit all we need to do is change the conversion constants (well I guess 
> they would not be constants any more :).  I REALLY don't want to do this 
> as it does add conversion overhead, but I can not think of another clean 
> way to track TSC frequency changes.

sched_clock does this conversion at sampling time, too.
