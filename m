Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932120AbWJRIqU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932120AbWJRIqU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Oct 2006 04:46:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932121AbWJRIqU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Oct 2006 04:46:20 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:1431 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S932120AbWJRIqT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Oct 2006 04:46:19 -0400
Date: Wed, 18 Oct 2006 10:34:48 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Lee Revell <rlrevell@joe-job.com>
Cc: dipankar@in.ibm.com, Karsten Wiese <annabellesgarden@yahoo.de>,
       linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
       John Stultz <johnstul@us.ibm.com>,
       "Paul E. McKenney" <paulmck@us.ibm.com>,
       Arjan van de Ven <arjan@infradead.org>
Subject: Re: 2.6.18-rt1
Message-ID: <20061018083447.GA8021@elte.hu>
References: <20060920141907.GA30765@elte.hu> <1159639564.4067.43.camel@mindpipe> <20060930181804.GA28768@in.ibm.com> <200610132318.02512.annabellesgarden@yahoo.de> <20061013212450.GC7477@in.ibm.com> <1160777536.4201.31.camel@mindpipe> <20061013221624.GD7477@in.ibm.com> <1161096395.2919.57.camel@mindpipe>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1161096395.2919.57.camel@mindpipe>
User-Agent: Mutt/1.4.2.2i
X-ELTE-SpamScore: -2.8
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-2.8 required=5.9 tests=ALL_TRUSTED,AWL,BAYES_50 autolearn=no SpamAssassin version=3.0.3
	-3.3 ALL_TRUSTED            Did not pass through any untrusted hosts
	0.5 BAYES_50               BODY: Bayesian spam probability is 40 to 60%
	[score: 0.5000]
	-0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Lee Revell <rlrevell@joe-job.com> wrote:

> > Can you try whatever you were doing with nmi_watchdog=0 ? If it is 
> > stable, then that would explain the problem. I believe Andi enabled 
> > nmi watchdog on x86_64 by default recently, that might be why we are 
> > seeing it now.
> 
> Looks like that was the problem, the hard lockups are gone.

ok. Meanwhile i discovered that i fixed this bug on i686 but not on 
x86_64. Could you try -rt6, does it work with the NMI watchdog 
re-enabled?

	Ingo
