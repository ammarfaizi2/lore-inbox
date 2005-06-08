Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261283AbVFHPAC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261283AbVFHPAC (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Jun 2005 11:00:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261291AbVFHPAC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Jun 2005 11:00:02 -0400
Received: from mx2.elte.hu ([157.181.151.9]:18561 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S261283AbVFHO76 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Jun 2005 10:59:58 -0400
Date: Wed, 8 Jun 2005 16:59:22 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Gene Heskett <gene.heskett@verizon.net>
Cc: linux-kernel@vger.kernel.org, Daniel Walker <dwalker@mvista.com>,
       Esben Nielsen <simlo@phys.au.dk>,
       Michal Schmidt <xschmi00@stud.feec.vutbr.cz>,
       Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.12-rc6-V0.7.47-29
Message-ID: <20050608145922.GA32309@elte.hu>
References: <20050607194119.GA11185@elte.hu> <200506080735.15530.gene.heskett@verizon.net> <20050608115956.GA7652@elte.hu> <200506081054.50001.gene.heskett@verizon.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200506081054.50001.gene.heskett@verizon.net>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9, BAYES_00 -4.90,
	UPPERCASE_25_50 0.00
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Gene Heskett <gene.heskett@verizon.net> wrote:

> [root@coyote linux-2.6.12-rc6-RT-V0.7.47-30]# grep PREEMPT .config
> # CONFIG_PREEMPT_NONE is not set
> CONFIG_PREEMPT_VOLUNTARY=y
> # CONFIG_PREEMPT_DESKTOP is not set
> # CONFIG_PREEMPT_RT is not set
> CONFIG_PREEMPT_SOFTIRQS=y
> CONFIG_PREEMPT_HARDIRQS=y
> # CONFIG_PREEMPT_BKL is not set
> 
> Now, I note that going to the #2 mode (voluntary) turned off threaded 
> RCU's, so I'm going to leave that off and try a mode 3 again. BRB.

please try mode 3 and disable softirq/hardirq threading. If that fixes 
things, could you check which of the two options 
(CONFIG_PREEMPT_SOFTIRQS or CONFIG_PREEMPT_HARDIRQS) causes which type 
of regression?

> And that makes tvtime's video fail with a blue screen, audio ok..
>
> Mode 2, FWIW, makes for quite jerky card motions while playing 
> AisleRiot, the solitaire game.

this doesnt happen on PREEMPT_DESKTOP or PREEMPT_RT?

	Ingo
