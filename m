Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932095AbVKXPHw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932095AbVKXPHw (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Nov 2005 10:07:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751365AbVKXPHw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Nov 2005 10:07:52 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:31366 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1751312AbVKXPHv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Nov 2005 10:07:51 -0500
Date: Thu, 24 Nov 2005 16:07:31 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Fernando Lopez-Lezcano <nando@ccrma.Stanford.EDU>,
       Lee Revell <rlrevell@joe-job.com>, linux-kernel@vger.kernel.org,
       "Paul E. McKenney" <paulmck@us.ibm.com>, "K.R. Foley" <kr@cybsft.com>,
       Thomas Gleixner <tglx@linutronix.de>, pluto@agmk.net,
       john cooper <john.cooper@timesys.com>,
       Benedikt Spranger <bene@linutronix.de>,
       Daniel Walker <dwalker@mvista.com>,
       Tom Rini <trini@kernel.crashing.org>,
       George Anzinger <george@mvista.com>
Subject: Re: 2.6.14-rt13
Message-ID: <20051124150731.GD2717@elte.hu>
References: <20051115090827.GA20411@elte.hu> <1132336954.20672.11.camel@cmn3.stanford.edu> <1132350882.6874.23.camel@mindpipe> <1132351533.4735.37.camel@cmn3.stanford.edu> <20051118220755.GA3029@elte.hu> <1132353689.4735.43.camel@cmn3.stanford.edu> <1132367947.5706.11.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1132367947.5706.11.camel@localhost.localdomain>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: -1.4
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-1.4 required=5.9 tests=ALL_TRUSTED,AWL autolearn=no SpamAssassin version=3.0.3
	-2.8 ALL_TRUSTED            Did not pass through any untrusted hosts
	1.4 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Steven Rostedt <rostedt@goodmis.org> wrote:

> OK, I used this as an exercise to learn how kobject and sysfs work 
> (I've been putting this off for too long). So if this isn't exactly 
> proper, let me know :-)
> 
> Ingo, This could be a temporary patch until we come up with a better 
> solution.  This adds /sys/kernel/idle/idle_poll, which if idle=poll is 
> _not_ set, it still lets you switch the machine to idle=poll on the 
> fly, as well as turn it off. If you have idle=poll, this doesn't even 
> show up.

ok, i've applied this one too. Could you also submit it upstream (and 
implement it for x86)? It makes sense to enable/disable the 
polling-based idle routine runtime.

	Ingo
