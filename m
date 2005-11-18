Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030288AbVKRSFL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030288AbVKRSFL (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Nov 2005 13:05:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030276AbVKRSFL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Nov 2005 13:05:11 -0500
Received: from smtp3.Stanford.EDU ([171.67.16.138]:50616 "EHLO
	smtp3.Stanford.EDU") by vger.kernel.org with ESMTP id S1030293AbVKRSFI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Nov 2005 13:05:08 -0500
Subject: Re: 2.6.14-rt13
From: Fernando Lopez-Lezcano <nando@ccrma.Stanford.EDU>
To: Ingo Molnar <mingo@elte.hu>
Cc: nando@ccrma.Stanford.EDU, linux-kernel@vger.kernel.org,
       "Paul E. McKenney" <paulmck@us.ibm.com>, "K.R. Foley" <kr@cybsft.com>,
       Steven Rostedt <rostedt@goodmis.org>,
       Thomas Gleixner <tglx@linutronix.de>, pluto@agmk.net,
       john cooper <john.cooper@timesys.com>,
       Benedikt Spranger <bene@linutronix.de>,
       Daniel Walker <dwalker@mvista.com>,
       Tom Rini <trini@kernel.crashing.org>,
       George Anzinger <george@mvista.com>
In-Reply-To: <20051115090827.GA20411@elte.hu>
References: <20051115090827.GA20411@elte.hu>
Content-Type: text/plain
Date: Fri, 18 Nov 2005 10:02:34 -0800
Message-Id: <1132336954.20672.11.camel@cmn3.stanford.edu>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-11-15 at 10:08 +0100, Ingo Molnar wrote:
> i have released the 2.6.14-rt13 tree, which can be downloaded from the 
> usual place:
> 
>    http://redhat.com/~mingo/realtime-preempt/
> 
> lots of fixes in this release affecting all supported architectures, all 
> across the board. Big MIPS update from John Cooper.

Hi Ingo, I'm back from the trip and built -rt13 to test on my dual core
Athlons. As I emailed you yesterday off the list it looked good, but I
guess it took longer than usual for things to degrade. This morning I'm
seeing the usual warnings from Jack. And, for the first time in a while,
actual xruns. I'll try your suggestion of booting with idle=poll. 

[begin speculation]
You mentioned before that the TSC's from both cpus could drift from each
other over time. Assuming that is the source of timing (I have no idea)
that could explain the behavior of Jack, it gets a reference time from
one of the cpus and then compares that with what it gets from either cpu
depending on where it is running at a given time. If it is the same cpu
all is fine, if it is the other and it has drifted then the warning is
printed. 

-- Fernando


