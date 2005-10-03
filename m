Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750861AbVJCOgv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750861AbVJCOgv (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Oct 2005 10:36:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750872AbVJCOgu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Oct 2005 10:36:50 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:48323 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1750851AbVJCOgu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Oct 2005 10:36:50 -0400
Subject: Re: [PATCH] RCU torture testing
From: Arjan van de Ven <arjan@infradead.org>
To: paulmck@us.ibm.com
Cc: Pavel Machek <pavel@ucw.cz>, linux-kernel@vger.kernel.org, akpm@osdl.org,
       dipankar@in.ibm.com, vatsa@in.ibm.com, rusty@au1.ibm.com, mingo@elte.hu,
       manfred@colorfullife.com
In-Reply-To: <20051003143009.GB1300@us.ibm.com>
References: <20051001182056.GA1613@us.ibm.com>
	 <20051002210549.GA8503@elf.ucw.cz>  <20051003143009.GB1300@us.ibm.com>
Content-Type: text/plain
Date: Mon, 03 Oct 2005 16:36:28 +0200
Message-Id: <1128350188.17024.14.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-Spam-Score: 2.9 (++)
X-Spam-Report: SpamAssassin version 3.0.4 on pentafluge.infradead.org summary:
	Content analysis details:   (2.9 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	0.1 RCVD_IN_SORBS_DUL      RBL: SORBS: sent directly from dynamic IP address
	[80.57.133.107 listed in dnsbl.sorbs.net]
	2.8 RCVD_IN_DSBL           RBL: Received via a relay in list.dsbl.org
	[<http://dsbl.org/listing?80.57.133.107>]
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-10-03 at 07:30 -0700, Paul E. McKenney wrote:
> On Sun, Oct 02, 2005 at 11:05:49PM +0200, Pavel Machek wrote:
> > Hi!
> > 
> > > The attached patch adds CONFIG_RCU_TORTURE_TEST, which enables a /proc-based
> > > intense torture test of the RCU infrastructure.  This is needed due to the
> > > continued changes to RCU infrastructure to accommodate dynamic ticks, CPU
> > > hotplug, and so on.  Most of the code is in a separate file that is compiled
> > > only if the CONFIG variable is set.  Documentation on how to run the test
> > > and interpret the output is also included.
> > > 
> > > This code has been tested on i386 and ppc64, and an earlier version of the
> > > code has seen extensive testing on a number of architectures as part of the
> > > PREEMPT_RT patchset.
> > > 
> > > Signed-off-by: <paulmck@us.ibm.com>
> > 
> > Can you just run the tests from time to time inside IBM?
> 
> In principle, I could, but in practice it is appropriate for non-IBMers to
> be able to test the RCU infrastructure easily and thoroughly when they
> work on it.

how hard would it be to make the few parameters just be module
options... and then fail module load if the test fails or something?
(and spew loudly in dmesg :)

I'd be all in favor of having such a module in the kernel; in fact it
would be nice if we roughly could standardize on an way to load/start
and then find the result, I'd love to have a "make runtests" or
something that would load such modules one by one

(and no that's not the task of ltp, ltp should test userspace; things
that test in kernel code should really be part of the kernel)


