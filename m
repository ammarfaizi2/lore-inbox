Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751210AbWANKiO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751210AbWANKiO (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Jan 2006 05:38:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751215AbWANKiO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Jan 2006 05:38:14 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:54208 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1751210AbWANKiN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Jan 2006 05:38:13 -0500
Date: Sat, 14 Jan 2006 11:38:27 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Smarduch Mario-CMS063 <CMS063@motorola.com>
Cc: rml@tech9.net, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Proposed patch for Precise Process Accounting
Message-ID: <20060114103827.GB9533@elte.hu>
References: <2D25C6D9C1440E4E8228FC62AE2864989E7AF7@de01exm69.ds.mot.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2D25C6D9C1440E4E8228FC62AE2864989E7AF7@de01exm69.ds.mot.com>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: -2.1
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-2.1 required=5.9 tests=ALL_TRUSTED,AWL autolearn=no SpamAssassin version=3.0.3
	-2.8 ALL_TRUSTED            Did not pass through any untrusted hosts
	0.7 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Smarduch Mario-CMS063 <CMS063@motorola.com> wrote:

> [...] The feature as it stands currently is divided into 3-patches - 
> (i) architecture independent which by itself provides useful data (ii) 
> arch dependent adds support for sys call, interrupt accounting (iii) 
> arch dependent with additional features. I'm interested if it has 
> potential for inclusion into the kernel, i.e. from Linux 
> performance/phylisophical stand point.

more accurate accounting of scheduling and interrupt time might be 
considered (especially since we already timestamp in the scheduler, so 
those codepaths could be merged) - but per-syscall accounting of system 
time and user time is pretty much out of the question, it's a way to hot 
codepath as your own measurements show:

> [...] however there are cicumstances such as consecutive calls to 
> light system calls (i.e. getpid()) where it may account for upto 7% 
> overhead.

but everything will depend on the quality of the actual patches 
themselves - the quality requirements are pretty strict for the affected 
codepaths.

	Ingo
