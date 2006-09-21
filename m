Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751035AbWIUIEs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751035AbWIUIEs (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Sep 2006 04:04:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751036AbWIUIEs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Sep 2006 04:04:48 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:16324 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1751035AbWIUIEo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Sep 2006 04:04:44 -0400
Date: Thu, 21 Sep 2006 09:56:33 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Bill Huey <billh@gnuppy.monkey.org>
Cc: linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
       John Stultz <johnstul@us.ibm.com>,
       "Paul E. McKenney" <paulmck@us.ibm.com>,
       Dipankar Sarma <dipankar@in.ibm.com>,
       Arjan van de Ven <arjan@infradead.org>,
       Esben Nielsen <simlo@phys.au.dk>
Subject: Re: [PATCH] move put_task_struct() reaping into a thread [Re: 2.6.18-rt1]
Message-ID: <20060921075633.GA30343@elte.hu>
References: <20060920141907.GA30765@elte.hu> <20060921065624.GA9841@gnuppy.monkey.org> <20060921065402.GA22089@elte.hu> <20060921071838.GA10337@gnuppy.monkey.org> <20060921071624.GA25281@elte.hu> <20060921073222.GC10337@gnuppy.monkey.org> <20060921072908.GA27280@elte.hu> <20060921074805.GA11644@gnuppy.monkey.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060921074805.GA11644@gnuppy.monkey.org>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: -2.9
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-2.9 required=5.9 tests=ALL_TRUSTED,AWL,BAYES_50 autolearn=no SpamAssassin version=3.0.3
	-3.3 ALL_TRUSTED            Did not pass through any untrusted hosts
	0.5 BAYES_50               BODY: Bayesian spam probability is 40 to 60%
	[score: 0.4979]
	-0.1 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Bill Huey <billh@gnuppy.monkey.org> wrote:

> [...] If the upstream kernel used RCU function in a task allocation or 
> task struct reading in the first place then call_rcu() would be a 
> clear choice. However, I didn't see it used in that way (I could be 
> wrong) [...]

it was RCU-ified briefly but then it was further improved to direct 
freeing, because upstream _can_ free it directly.

	Ingo
