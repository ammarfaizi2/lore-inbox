Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751481AbVKPRBu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751481AbVKPRBu (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Nov 2005 12:01:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751484AbVKPRBu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Nov 2005 12:01:50 -0500
Received: from e36.co.us.ibm.com ([32.97.110.154]:46480 "EHLO
	e36.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751481AbVKPRBt
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Nov 2005 12:01:49 -0500
Date: Wed, 16 Nov 2005 09:02:25 -0800
From: "Paul E. McKenney" <paulmck@us.ibm.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: "K.R. Foley" <kr@cybsft.com>, linux-kernel@vger.kernel.org,
       Steven Rostedt <rostedt@goodmis.org>,
       Thomas Gleixner <tglx@linutronix.de>, pluto@agmk.net,
       john cooper <john.cooper@timesys.com>,
       Benedikt Spranger <bene@linutronix.de>,
       Daniel Walker <dwalker@mvista.com>,
       Tom Rini <trini@kernel.crashing.org>,
       George Anzinger <george@mvista.com>
Subject: Re: 2.6.14-rt13
Message-ID: <20051116170225.GC4976@us.ibm.com>
Reply-To: paulmck@us.ibm.com
References: <20051115090827.GA20411@elte.hu> <437AABFF.2010405@cybsft.com> <20051116084037.GC14829@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051116084037.GC14829@elte.hu>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 16, 2005 at 09:40:37AM +0100, Ingo Molnar wrote:
> 
> * K.R. Foley <kr@cybsft.com> wrote:
> 
> > >  - big RCU torture-test update (Paul E. McKenney)
> > 
> > In case anyone else makes the same mistake I did. If you are using the 
> > same config from a previous build, you may have RCU_TORTURE_TEST=Y 
> > (not module) and not even know it when running RT patches. You will 
> > however definitely notice it if you use the config to build a non RT 
> > kernel like 2.6.15-rc1. The previous RT patch defaulted 
> > RCU_TORTURE_TEST=y. By the way, the fact that I didn't even notice 
> > that the torture test was running with the RT kernel is a true measure 
> > of how well things have progressed. :-)
> 
> yeah - i left it on by default, i usually do that with new debugging 
> features, to give new code more exposure. In other words, mass 
> distributed RCU stress-testing by stealth ;-)

Cool!!!  If anyone sees a printk line starting with "rcutorture:" 
that includes the string "!!!", please pass it along accompanied by
your config and what your workload was doing at the time.

						Thanx, Paul

> I'll make it default-off once the RCU related changes have calmed down.  
> The rcutorture kernel threads run at nice +19 so they should be barely 
> noticeable. (except for a sudden and unexplained spike in the world's 
> power consumption, and the resulting energy crisis ;-)
> 
> 	Ingo
> 
