Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269679AbUJSQgD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269679AbUJSQgD (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Oct 2004 12:36:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269667AbUJSQaQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Oct 2004 12:30:16 -0400
Received: from mx1.elte.hu ([157.181.1.137]:17368 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S269658AbUJSQ2D (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Oct 2004 12:28:03 -0400
Date: Tue, 19 Oct 2004 18:28:11 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Rui Nuno Capela <rncbc@rncbc.org>
Cc: linux-kernel@vger.kernel.org, Lee Revell <rlrevell@joe-job.com>,
       mark_h_johnson@raytheon.com, "K.R. Foley" <kr@cybsft.com>,
       Bill Huey <bhuey@lnxw.com>, Adam Heath <doogie@debian.org>,
       Florian Schmidt <mista.tapas@gmx.net>,
       Thomas Gleixner <tglx@linutronix.de>,
       Michal Schmidt <xschmi00@stud.feec.vutbr.cz>,
       Fernando Pablo Lopez-Lezcano <nando@ccrma.stanford.edu>
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.9-rc4-mm1-U6
Message-ID: <20041019162811.GA13454@elte.hu>
References: <20041014143131.GA20258@elte.hu> <20041014234202.GA26207@elte.hu> <20041015102633.GA20132@elte.hu> <20041016153344.GA16766@elte.hu> <20041018145008.GA25707@elte.hu> <20041019124605.GA28896@elte.hu> <20041019144642.GA6512@elte.hu> <28172.195.245.190.93.1098199429.squirrel@195.245.190.93> <20041019155008.GA9116@elte.hu> <20041019162047.GA12055@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041019162047.GA12055@elte.hu>
User-Agent: Mutt/1.4.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Ingo Molnar <mingo@elte.hu> wrote:

> 
> * Ingo Molnar <mingo@elte.hu> wrote:
> 
> > > Hasn't anybody else stumbled on this?
> > 
> > i'm using it myself and havent seen the problem yet. Could you send me
> > the latest .configs, the working and the broken one too? I'll try to
> > reprodue it (or maybe someone else with a serial console sees it too).
> 
> i found older .config's from you and i tried your desktop one and it
> didnt crash. But when i tried your laptop's U3 .config then i got the
> bootup crash immediately. Debugging it ...

one difference in your config is that you have 4K stacks enabled. Could
you disable them? Especially with rwsem-detection and tracing enabled
the stack footprint can get pretty large ...

	Ingo
