Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750704AbWGWQ34@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750704AbWGWQ34 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 23 Jul 2006 12:29:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750799AbWGWQ34
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 23 Jul 2006 12:29:56 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:39383 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1750704AbWGWQ3z (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 23 Jul 2006 12:29:55 -0400
Date: Sun, 23 Jul 2006 18:24:04 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Andrew Morton <akpm@osdl.org>
Cc: Linus Torvalds <torvalds@osdl.org>, davej@redhat.com,
       linux-kernel@vger.kernel.org, ashok.raj@intel.com
Subject: Re: remove cpu hotplug bustification in cpufreq.
Message-ID: <20060723162404.GA13129@elte.hu>
References: <20060722194018.GA28924@redhat.com> <Pine.LNX.4.64.0607221707400.29649@g5.osdl.org> <20060722180602.ac0d36f5.akpm@osdl.org> <Pine.LNX.4.64.0607221813020.29649@g5.osdl.org> <20060722223425.c94a858e.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060722223425.c94a858e.akpm@osdl.org>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: -3.1
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-3.1 required=5.9 tests=ALL_TRUSTED,AWL,BAYES_50 autolearn=no SpamAssassin version=3.0.3
	-3.3 ALL_TRUSTED            Did not pass through any untrusted hosts
	0.0 BAYES_50               BODY: Bayesian spam probability is 40 to 60%
	[score: 0.5003]
	0.2 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Andrew Morton <akpm@osdl.org> wrote:

> > I'll try them out. If they don't work, we should just delete the 
> > lock and go totally back to square 1.
> 
> rwsem conversion has the potential to merely hide the problem.  Ingo, 
> does lockdep detect recursive down_read()?

yeah, it does - there are a couple of testcases for it too, in the 
testsuite.

	Ingo
