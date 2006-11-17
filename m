Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1755513AbWKQHMK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755513AbWKQHMK (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Nov 2006 02:12:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755516AbWKQHMJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Nov 2006 02:12:09 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:38796 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1755513AbWKQHMH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Nov 2006 02:12:07 -0500
Date: Fri, 17 Nov 2006 07:54:40 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Daniel Walker <dwalker@mvista.com>
Cc: Esben Nielsen <nielsen.esben@googlemail.com>, linux-kernel@vger.kernel.org,
       Thomas Gleixner <tglx@linutronix.de>,
       Arjan van de Ven <arjan@infradead.org>
Subject: Re: 2.6.19-rc6-rt0, -rt YUM repository
Message-ID: <20061117065440.GA13246@elte.hu>
References: <20061116153553.GA12583@elte.hu> <1163694712.26026.1.camel@localhost.localdomain> <Pine.LNX.4.64.0611162212110.21141@frodo.shire> <1163713469.26026.4.camel@localhost.localdomain> <20061116220733.GA17217@elte.hu> <1163716638.26026.8.camel@localhost.localdomain> <20061117055521.GA30189@elte.hu> <20061117065043.GA12664@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061117065043.GA12664@elte.hu>
User-Agent: Mutt/1.4.2.2i
X-ELTE-SpamScore: -4.1
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-4.1 required=5.9 tests=ALL_TRUSTED,AWL,BAYES_20 autolearn=no SpamAssassin version=3.0.3
	-3.3 ALL_TRUSTED            Did not pass through any untrusted hosts
	-2.0 BAYES_20               BODY: Bayesian spam probability is 5 to 20%
	[score: 0.1932]
	1.2 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Ingo Molnar <mingo@elte.hu> wrote:

> 
> * Ingo Molnar <mingo@elte.hu> wrote:
> 
> > > Did you look at the BKL reacquire issue I sent? Just looking over 
> > > the code briefly, it looks like it's still there.
> > 
> > yeah, will do that. It's quite low-prio, evidently no-one in the past 
> > couple of months even attempted to build a !PREEMPT_RT && !PREEMPT_BKL 
> > (!) kernel.
> 
> doh - i have re-read your report and the problem should hit PREEMPT_RT 
> too. I'm looking at it.

actually, it should only hit CONFIG_SPINLOCK_BKL, which is an option 
no-one should be using these days. I'll disable that option for now.

	Ingo
