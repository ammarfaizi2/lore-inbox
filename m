Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751289AbWF2UQd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751289AbWF2UQd (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jun 2006 16:16:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751290AbWF2UQd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jun 2006 16:16:33 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:53662 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1751289AbWF2UQb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jun 2006 16:16:31 -0400
Date: Thu, 29 Jun 2006 22:11:45 +0200
From: Ingo Molnar <mingo@elte.hu>
To: "Paul E. McKenney" <paulmck@us.ibm.com>
Cc: Dipankar Sarma <dipankar@in.ibm.com>, linux-kernel@vger.kernel.org,
       Ananth N Mavinakayanahalli <ananth@in.ibm.com>,
       Prasanna Panchamukhi <prasanna@in.ibm.com>
Subject: Re: [PATCH] 2.6.17-rt1 : fix x86_64 oops
Message-ID: <20060629201144.GA24287@elte.hu>
References: <20060627200105.GA13966@in.ibm.com> <20060628182137.GA23979@in.ibm.com> <20060628193256.GA4392@elte.hu> <20060628200247.GA7932@in.ibm.com> <20060629142442.GA11546@elte.hu> <20060629163236.GD1294@us.ibm.com> <20060629194145.GA2327@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060629194145.GA2327@us.ibm.com>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: -3.1
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-3.1 required=5.9 tests=ALL_TRUSTED,AWL,BAYES_50 autolearn=no SpamAssassin version=3.0.3
	-3.3 ALL_TRUSTED            Did not pass through any untrusted hosts
	0.0 BAYES_50               BODY: Bayesian spam probability is 40 to 60%
	[score: 0.5000]
	0.2 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Paul E. McKenney <paulmck@us.ibm.com> wrote:

> > This was on i386, x86_64, or on something else?
> > 
> > Ah!  This would have been a CONFIG_PREEMPT build, right?
> 
> OK, I ran this with both torture types (rcu and rcu_bh) on i386 with 
> CONFIG_PREEMPT=y on 2.6.17-mm4 and didn't see any "scheduling while 
> atomic" oopses -- or any other oopses, for that matter.
> 
> Here is the .config file I used.  What am I missing here?

hm, i'm seeing some other types of crashes too - so rcutorture could 
just have been collateral damage. It was on i386, an allyesconfig 
bzImage kernel.

	Ingo
