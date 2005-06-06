Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261354AbVFFMI7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261354AbVFFMI7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Jun 2005 08:08:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261365AbVFFMI7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Jun 2005 08:08:59 -0400
Received: from mx2.elte.hu ([157.181.151.9]:17589 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S261354AbVFFMI6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Jun 2005 08:08:58 -0400
Date: Mon, 6 Jun 2005 14:08:16 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Esben Nielsen <simlo@phys.au.dk>
Cc: Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
       Inaky Perez-Gonzalez <inaky.perez-gonzalez@intel.com>,
       Daniel Walker <dwalker@mvista.com>, Oleg Nesterov <oleg@tv-sign.ru>
Subject: Re: [patch] Real-Time Preemption, plist fixes
Message-ID: <20050606120816.GA13413@elte.hu>
References: <20050606073229.GA9143@elte.hu> <Pine.OSF.4.05.10506061050050.4252-100000@da410.phys.au.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.OSF.4.05.10506061050050.4252-100000@da410.phys.au.dk>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Esben Nielsen <simlo@phys.au.dk> wrote:

> > i dont think fusyn's should be made available to non-RT tasks. If this 
> > restriction is preserved then fusyn's would become O(max_nr_RT_tasks) 
> > too.
> 
> My pragmatic side agrees with you. My sense of beauty does not. I think
> you make 2 small hacks here:
>
> 1) Adding a limit like above smells wrong.
> 2) Making PI only apply to RT tasks isn't beautifull either.

Enabling PI for all tasks would certainly make plists the only viable 
choice. To achieve that we'd have to do quite careful coding, as the 
priorities of SCHED_OTHER tasks can change quite frequently, and the PI 
code doesnt follow priority changes that well currently.

	Ingo
