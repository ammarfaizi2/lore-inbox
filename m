Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750750AbVKSSgH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750750AbVKSSgH (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Nov 2005 13:36:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750753AbVKSSgG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Nov 2005 13:36:06 -0500
Received: from mustang.oldcity.dca.net ([216.158.38.3]:58022 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S1750750AbVKSSgF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Nov 2005 13:36:05 -0500
Subject: Re: 2.6.14-rt13
From: Lee Revell <rlrevell@joe-job.com>
To: Vojtech Pavlik <vojtech@suse.cz>
Cc: George Anzinger <george@mvista.com>,
       Fernando Lopez-Lezcano <nando@ccrma.Stanford.EDU>,
       Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org,
       "Paul E. McKenney" <paulmck@us.ibm.com>, "K.R. Foley" <kr@cybsft.com>,
       Steven Rostedt <rostedt@goodmis.org>,
       Thomas Gleixner <tglx@linutronix.de>, pluto@agmk.net,
       john cooper <john.cooper@timesys.com>,
       Benedikt Spranger <bene@linutronix.de>,
       Daniel Walker <dwalker@mvista.com>,
       Tom Rini <trini@kernel.crashing.org>
In-Reply-To: <20051119074503.GA12551@midnight.suse.cz>
References: <20051115090827.GA20411@elte.hu>
	 <1132336954.20672.11.camel@cmn3.stanford.edu>
	 <1132350882.6874.23.camel@mindpipe>
	 <1132351533.4735.37.camel@cmn3.stanford.edu>
	 <1132351984.6874.29.camel@mindpipe>
	 <20051118223233.GA7794@midnight.suse.cz> <437E8DC8.4070101@mvista.com>
	 <20051119074503.GA12551@midnight.suse.cz>
Content-Type: text/plain
Date: Sat, 19 Nov 2005 13:27:06 -0500
Message-Id: <1132424827.6874.64.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.0 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2005-11-19 at 08:45 +0100, Vojtech Pavlik wrote:
> On Fri, Nov 18, 2005 at 06:28:24PM -0800, George Anzinger wrote:
> > Finding it is another matter.  It does not have a fixed address (i.e. 
> > it differs from machine to machine, but is constant on any given 
> > machine).  The boot code roots it out of an info block put in memory 
> > by the BIOS.  I suppose one could put a printk in the boot code to 
> > disclose it...
> 
> There is really no reason to do that, since the time to read it (~1200
> ns) is much less than the time to enter the kernel (less than 200 ns),
> so gettimeofday() is definitely easier to use and also doesn't overflow.
> 

Thanks very much, you have answered my question.  We would prefer
gettimeofday() anyway for portability, so if the plan is to make it
faster then we can deal with losing the TSC.

Lee

