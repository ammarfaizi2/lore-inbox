Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261187AbUJWNxJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261187AbUJWNxJ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Oct 2004 09:53:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261186AbUJWNxJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Oct 2004 09:53:09 -0400
Received: from mx2.elte.hu ([157.181.151.9]:10452 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S261187AbUJWNxF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Oct 2004 09:53:05 -0400
Date: Sat, 23 Oct 2004 15:54:09 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Rui Nuno Capela <rncbc@rncbc.org>
Cc: linux-kernel@vger.kernel.org, Lee Revell <rlrevell@joe-job.com>,
       mark_h_johnson@raytheon.com, "K.R. Foley" <kr@cybsft.com>,
       Bill Huey <bhuey@lnxw.com>, Adam Heath <doogie@debian.org>,
       Florian Schmidt <mista.tapas@gmx.net>,
       Thomas Gleixner <tglx@linutronix.de>,
       Michal Schmidt <xschmi00@stud.feec.vutbr.cz>,
       Fernando Pablo Lopez-Lezcano <nando@ccrma.stanford.edu>,
       Alexander Batyrshin <abatyrshin@ru.mvista.com>
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.9-mm1-U10.2
Message-ID: <20041023135409.GB18747@elte.hu>
References: <20041020094508.GA29080@elte.hu> <20041021132717.GA29153@elte.hu> <20041022133551.GA6954@elte.hu> <20041022155048.GA16240@elte.hu> <20041022175633.GA1864@elte.hu> <32871.192.168.1.5.1098491242.squirrel@192.168.1.5> <20041023102909.GD30270@elte.hu> <32880.192.168.1.5.1098534617.squirrel@192.168.1.5> <20041023125104.GA10883@elte.hu> <32989.192.168.1.5.1098539101.squirrel@192.168.1.5>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <32989.192.168.1.5.1098539101.squirrel@192.168.1.5>
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


* Rui Nuno Capela <rncbc@rncbc.org> wrote:

> OK. All affirmative. NIC is natsemi.
> 
> Here it is:
> 
> SysRq : IRQ 1/776: BUG in write_msg at drivers/net/netconsole.c:87

doh! Go to line 77 and spot the bug. (yes, the PREEMPT_REALTIME needs to
become CONFIG_PREEMPT_REALTIME) With that fixed does it work for you?

	Ingo
