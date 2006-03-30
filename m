Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751093AbWC3Lhe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751093AbWC3Lhe (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Mar 2006 06:37:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751329AbWC3Lhe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Mar 2006 06:37:34 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:54945 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1751093AbWC3Lhd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Mar 2006 06:37:33 -0500
Date: Thu, 30 Mar 2006 13:34:52 +0200
From: Ingo Molnar <mingo@elte.hu>
To: emin ak <eminak71@gmail.com>
Cc: Kumar Gala <galak@kernel.crashing.org>,
       Nick Piggin <nickpiggin@yahoo.com.au>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.16-rt10 crash on ppc
Message-ID: <20060330113452.GA9901@elte.hu>
References: <2cf1ee820603270656w6697778ai83935217ea5ab3a5@mail.gmail.com> <2cf1ee820603271231l69187925j3150098097c7ca15@mail.gmail.com> <44288FB3.5030208@yahoo.com.au> <20060329150815.GA24741@elte.hu> <442B4890.6000905@yahoo.com.au> <20060330071322.GA3137@elte.hu> <F86880BD-2EE9-4078-AB28-F769EF507C3B@kernel.crashing.org> <20060330072339.GB3941@elte.hu> <2cf1ee820603300225x3c5a6f98qe8bdda1023f0d74f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2cf1ee820603300225x3c5a6f98qe8bdda1023f0d74f@mail.gmail.com>
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


* emin ak <eminak71@gmail.com> wrote:

> Soryy fot the late answer. I have change the driver to use 
> SA_INTERRUPT, OOM messages disappeared but the ethernet throughput 
> decreased significantly as Kumar said before(90MBit for 1518Byte 
> packet, and throughput without the patch is about 900Bits) and the 
> system can't manage load balancing between to interfaces,the system 
> acts like the priorty of tsec0 (eth0) is higher then tsec1 because of 
> this, under heavy load on tsec0 blocks packet receiving on tsec1 
> (eth1). And also I have tried Nick solution, increased 
> /proc/sys/vm/min_free_kbytes to 10MB, the result did'nt changed, OOM 
> messages was repeated again.
> I'll try Ingo patch immediately and and report you the results.

well, if SA_INTERRUPT made a difference then you are likely not running 
PREEMPT_RT nor PREEMPT_HARDIRQS. Could you send me your .config?

	Ingo
