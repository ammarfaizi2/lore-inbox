Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030437AbWGZIky@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030437AbWGZIky (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Jul 2006 04:40:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030451AbWGZIky
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Jul 2006 04:40:54 -0400
Received: from mx3.mail.elte.hu ([157.181.1.138]:4045 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1030437AbWGZIkx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Jul 2006 04:40:53 -0400
Date: Wed, 26 Jul 2006 10:34:37 +0200
From: Ingo Molnar <mingo@elte.hu>
To: "Paul E. McKenney" <paulmck@us.ibm.com>
Cc: oleg@tv-sign.ru, linux-kernel@vger.kernel.org, dino@us.ibm.com,
       tytso@us.ibm.com, dvhltc@us.ibm.com,
       Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH -rt] catch put_task_struct RCU handling up to mainline
Message-ID: <20060726083437.GA15144@elte.hu>
References: <20060707192955.GA2219@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060707192955.GA2219@us.ibm.com>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.3
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.3 required=5.9 tests=AWL,BAYES_50 autolearn=no SpamAssassin version=3.0.3
	0.5 BAYES_50               BODY: Bayesian spam probability is 40 to 60%
	[score: 0.5000]
	-0.2 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Paul E. McKenney <paulmck@us.ibm.com> wrote:

> Hello!
> 
> Due to the separate -rt and mainline evolution of RCU signal handling, 
> the -rt patchset now makes each task struct go through two RCU grace 
> periods, with one call_rcu() in release_task() and with another in 
> put_task_struct().  Only the call_rcu() in release_task() is required, 
> since this is the one that is associated with tearing down the task 
> structure.
> 
> This patch removes the extra call_rcu() in put_task_struct(), synching 
> this up with mainline.  Tested lightly on i386.

i've applied your patch to the -rt tree - we'll see how it goes.

	Ingo
