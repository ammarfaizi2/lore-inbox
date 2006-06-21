Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751201AbWFUSgn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751201AbWFUSgn (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jun 2006 14:36:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751203AbWFUSgn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jun 2006 14:36:43 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:58849 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1751201AbWFUSgm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jun 2006 14:36:42 -0400
Date: Wed, 21 Jun 2006 20:30:42 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Esben Nielsen <nielsen.esben@googlemail.com>,
       Esben Nielsen <nielsen.esben@gogglemail.com>,
       Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org
Subject: Re: Why can't I set the priority of softirq-hrt? (Re: 2.6.17-rt1)
Message-ID: <20060621183042.GB1693@elte.hu>
References: <1150816429.6780.222.camel@localhost.localdomain> <Pine.LNX.4.64.0606201725550.11643@localhost.localdomain> <Pine.LNX.4.58.0606201229310.729@gandalf.stny.rr.com> <Pine.LNX.4.64.0606201903030.11643@localhost.localdomain> <1150824092.6780.255.camel@localhost.localdomain> <Pine.LNX.4.64.0606202217160.11643@localhost.localdomain> <Pine.LNX.4.58.0606210418160.29673@gandalf.stny.rr.com> <Pine.LNX.4.64.0606211204220.10723@localhost.localdomain> <Pine.LNX.4.64.0606211638560.6572@localhost.localdomain> <1150907165.25491.4.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1150907165.25491.4.camel@localhost.localdomain>
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


* Thomas Gleixner <tglx@linutronix.de> wrote:

> On Wed, 2006-06-21 at 16:43 +0100, Esben Nielsen wrote:
> > What about the patch below. It compiles and my UP labtop runs fine, but I 
> > haven't otherwise tested it.  My labtop runs RTExec without hichups 
> > until now.
> 
> NAK, it puts the burden into the lock path and also does a remove / 
> add which results in walking the chain twice.
> 
> Find an version against the code in -mm below. Not too much tested 
> yet.

i like this one - it does the prio fixup where it should be done.

	Ingo
