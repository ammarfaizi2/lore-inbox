Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932209AbWCZXiF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932209AbWCZXiF (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Mar 2006 18:38:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932216AbWCZXiF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Mar 2006 18:38:05 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:16352 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S932209AbWCZXiE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Mar 2006 18:38:04 -0500
Date: Mon, 27 Mar 2006 01:35:30 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Esben Nielsen <simlo@phys.au.dk>
Cc: tglx@linutronix.de, linux-kernel@vger.kernel.org
Subject: 2.6.16-rt10
Message-ID: <20060326233530.GA22496@elte.hu>
References: <Pine.LNX.4.44L0.0603262214060.8060-100000@lifa03.phys.au.dk> <Pine.LNX.4.44L0.0603262255150.8060-100000@lifa03.phys.au.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.0603262255150.8060-100000@lifa03.phys.au.dk>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: -2.6
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-2.6 required=5.9 tests=ALL_TRUSTED,AWL,BAYES_50 autolearn=no SpamAssassin version=3.0.3
	-3.3 ALL_TRUSTED            Did not pass through any untrusted hosts
	0.0 BAYES_50               BODY: Bayesian spam probability is 40 to 60%
	[score: 0.5000]
	0.7 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Esben Nielsen <simlo@phys.au.dk> wrote:

> rt_mutex_slowlock seems to return -EDEADLK even though caller didn't 
> ask for deadlock detection (detect_deadlock=0). That is bad because 
> then the caller will not check for it. It ought to simply leave the 
> task blocked.
> 
> It only happens with CONFIG_DEBUG_RT_MUTEXES. That one also messes up 
> the task->pi_waiters as earlier reported.

i've released -rt10 with this bug (and other PI related bugs) fixed.

	Ingo
