Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261368AbVDDUMF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261368AbVDDUMF (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Apr 2005 16:12:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261359AbVDDUMF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Apr 2005 16:12:05 -0400
Received: from mx2.elte.hu ([157.181.151.9]:43483 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S261368AbVDDUBJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Apr 2005 16:01:09 -0400
Date: Mon, 4 Apr 2005 22:00:43 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Gene Heskett <gene.heskett@verizon.net>,
       LKML <linux-kernel@vger.kernel.org>, "K.R. Foley" <kr@cybsft.com>,
       Lee Revell <rlrevell@joe-job.com>, Rui Nuno Capela <rncbc@rncbc.org>
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.12-rc1-V0.7.43-00
Message-ID: <20050404200043.GA16736@elte.hu>
References: <200504011419.20964.gene.heskett@verizon.net> <424D9F6A.8080407@cybsft.com> <200504011834.22600.gene.heskett@verizon.net> <20050402051254.GA23786@elte.hu> <1112470675.27149.14.camel@localhost.localdomain> <1112472372.27149.23.camel@localhost.localdomain> <20050402203550.GB16230@elte.hu> <1112474659.27149.39.camel@localhost.localdomain> <1112479772.27149.48.camel@localhost.localdomain> <1112486812.27149.76.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1112486812.27149.76.camel@localhost.localdomain>
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


* Steven Rostedt <rostedt@goodmis.org> wrote:

> So it is probably stuck in some spinning "yield" loop, which was the 
> reason I was writing this test to begin with!  It's most likely also 
> waiting for kjournald to do some work, and is starving it in a 
> schedule or yield loop never actually going to sleep letting kjournald 
> do the real work.

actually, what priorities do the yielding tasks have? sched_yield() does 
not guarantee that the CPU will be given up, of if a highest-prio 
SCHED_FIFO task is in a yield() loop it will livelock the system.

	Ingo

