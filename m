Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030211AbVKPIkz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030211AbVKPIkz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Nov 2005 03:40:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030231AbVKPIkz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Nov 2005 03:40:55 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:55491 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1030211AbVKPIkx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Nov 2005 03:40:53 -0500
Date: Wed, 16 Nov 2005 09:40:37 +0100
From: Ingo Molnar <mingo@elte.hu>
To: "K.R. Foley" <kr@cybsft.com>
Cc: linux-kernel@vger.kernel.org, "Paul E. McKenney" <paulmck@us.ibm.com>,
       Steven Rostedt <rostedt@goodmis.org>,
       Thomas Gleixner <tglx@linutronix.de>, pluto@agmk.net,
       john cooper <john.cooper@timesys.com>,
       Benedikt Spranger <bene@linutronix.de>,
       Daniel Walker <dwalker@mvista.com>,
       Tom Rini <trini@kernel.crashing.org>,
       George Anzinger <george@mvista.com>
Subject: Re: 2.6.14-rt13
Message-ID: <20051116084037.GC14829@elte.hu>
References: <20051115090827.GA20411@elte.hu> <437AABFF.2010405@cybsft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <437AABFF.2010405@cybsft.com>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=AWL autolearn=disabled SpamAssassin version=3.0.4
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* K.R. Foley <kr@cybsft.com> wrote:

> >  - big RCU torture-test update (Paul E. McKenney)
> 
> In case anyone else makes the same mistake I did. If you are using the 
> same config from a previous build, you may have RCU_TORTURE_TEST=Y 
> (not module) and not even know it when running RT patches. You will 
> however definitely notice it if you use the config to build a non RT 
> kernel like 2.6.15-rc1. The previous RT patch defaulted 
> RCU_TORTURE_TEST=y. By the way, the fact that I didn't even notice 
> that the torture test was running with the RT kernel is a true measure 
> of how well things have progressed. :-)

yeah - i left it on by default, i usually do that with new debugging 
features, to give new code more exposure. In other words, mass 
distributed RCU stress-testing by stealth ;-)

I'll make it default-off once the RCU related changes have calmed down.  
The rcutorture kernel threads run at nice +19 so they should be barely 
noticeable. (except for a sudden and unexplained spike in the world's 
power consumption, and the resulting energy crisis ;-)

	Ingo
