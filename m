Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751062AbWI0JFh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751062AbWI0JFh (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Sep 2006 05:05:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751064AbWI0JFh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Sep 2006 05:05:37 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:31157 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1751062AbWI0JFg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Sep 2006 05:05:36 -0400
Date: Wed, 27 Sep 2006 10:57:12 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Bill Huey <billh@gnuppy.monkey.org>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>, linux-kernel@vger.kernel.org,
       Thomas Gleixner <tglx@linutronix.de>, John Stultz <johnstul@us.ibm.com>,
       "Paul E. McKenney" <paulmck@us.ibm.com>,
       Dipankar Sarma <dipankar@in.ibm.com>,
       Arjan van de Ven <arjan@infradead.org>
Subject: Re: [PATCH] move put_task_struct() reaping into a thread [Re: 2.6.18-rt1]
Message-ID: <20060927085712.GA16938@elte.hu>
References: <20060920141907.GA30765@elte.hu> <20060921065624.GA9841@gnuppy.monkey.org> <m1irjaqaqa.fsf@ebiederm.dsl.xmission.com> <20060927050856.GA16140@gnuppy.monkey.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060927050856.GA16140@gnuppy.monkey.org>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: -2.9
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-2.9 required=5.9 tests=ALL_TRUSTED,AWL,BAYES_50 autolearn=no SpamAssassin version=3.0.3
	-3.3 ALL_TRUSTED            Did not pass through any untrusted hosts
	0.5 BAYES_50               BODY: Bayesian spam probability is 40 to 60%
	[score: 0.4999]
	-0.1 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Bill Huey <billh@gnuppy.monkey.org> wrote:

> Because the conversion of memory allocation routines like kmalloc and 
> kfree aren't safely callable within a preempt_disable critical section 
> since they were incompletely converted in the -rt. [...]

they were not 'incompletely converted' - they are /intentionally/ fully 
preemptible.

	Ingo
