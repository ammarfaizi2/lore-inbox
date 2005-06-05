Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261541AbVFEJul@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261541AbVFEJul (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Jun 2005 05:50:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261545AbVFEJul
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Jun 2005 05:50:41 -0400
Received: from mx2.elte.hu ([157.181.151.9]:61842 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S261541AbVFEJug (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Jun 2005 05:50:36 -0400
Date: Sun, 5 Jun 2005 11:47:42 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-kernel@vger.kernel.org,
       Inaky Perez-Gonzalez <inaky.perez-gonzalez@intel.com>,
       Daniel Walker <dwalker@mvista.com>, Oleg Nesterov <oleg@tv-sign.ru>,
       Esben Nielsen <simlo@phys.au.dk>
Subject: Re: [patch] Real-Time Preemption, plist fixes
Message-ID: <20050605094742.GA8346@elte.hu>
References: <1117930633.20785.239.camel@tglx.tec.linutronix.de> <20050605082616.GA26824@elte.hu> <1117961624.20785.258.camel@tglx.tec.linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1117961624.20785.258.camel@tglx.tec.linutronix.de>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Thomas Gleixner <tglx@linutronix.de> wrote:

> > but i think the fundamental question remains even on Sunday mornings -
> > is the plist overhead worth it? Compared to the simple sorted list we 
> > exchange O(nr_RT_tasks_running) for O(nr_RT_levels_used) [which is in 
> > the 1-100 range], is that a significant practical improvement? By 
> > overhead i dont just mean cycle cost, but also architectural flexibility 
> > and maintainability.
> 
> That was my question too.

i think it would be handy to resurrect ALL_TASKS_PI. It was one of the 
things that stabilized the sorted list approach so quickly. Nothing 
beats the coverage of running a full graphical desktop with all the PI 
code active :-)

	Ingo
