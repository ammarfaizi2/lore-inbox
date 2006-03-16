Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752272AbWCPJUm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752272AbWCPJUm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Mar 2006 04:20:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752278AbWCPJUm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Mar 2006 04:20:42 -0500
Received: from mx3.mail.elte.hu ([157.181.1.138]:36037 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1752277AbWCPJUl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Mar 2006 04:20:41 -0500
Date: Thu, 16 Mar 2006 10:18:03 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Lee Revell <rlrevell@joe-job.com>
Cc: "Bill Rugolsky Jr." <brugolsky@telemetry-investments.com>,
       Jeff Garzik <jeff@garzik.org>, Andi Kleen <ak@suse.de>,
       Jason Baron <jbaron@redhat.com>, linux-kernel@vger.kernel.org,
       john stultz <johnstul@us.ibm.com>, Allen Martin <AMartin@nvidia.com>
Subject: Re: libata/sata_nv latency on NVIDIA CK804 [was Re: AMD64 X2 lost ticks on PM timer]
Message-ID: <20060316091803.GA23098@elte.hu>
References: <200603040107.27639.ak@suse.de> <20060315213638.GA17817@ti64.telemetry-investments.com> <20060315215020.GA18241@elte.hu> <20060315221119.GA21775@elte.hu> <44189654.2080607@garzik.org> <20060315224408.GC24074@elte.hu> <44189A3D.5090202@garzik.org> <20060315231426.GD17817@ti64.telemetry-investments.com> <20060316031528.GF17817@ti64.telemetry-investments.com> <1142482825.1671.148.camel@mindpipe>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1142482825.1671.148.camel@mindpipe>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=AWL autolearn=no SpamAssassin version=3.0.3
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Lee Revell <rlrevell@joe-job.com> wrote:

> On Wed, 2006-03-15 at 22:15 -0500, Bill Rugolsky Jr. wrote:
> > 
> > I'm heading home now (it's 22:00, and I've been here 16 hours
> > already), but I figured that I'd post what I have thus far, and
> > perhaps you can tell me what the problem is.
> > 
> 
> I think it would be better to try to identify the exact circumstances 
> that trigger the large PIO delay, than to start over debugging a new 
> and untested driver, especially if the SMM hypothesis has been ruled 
> out.

well, but it's nevertheless a nice thing that the driver got enhanced - 
and Bill's patch seems to be quite close to usable. If that driver 
enhancement also ends up solving the latency then why not?

one more thing to try (in the old driver) would be to surround the inb() 
line in the offending function with mcount(); calls, and redo the 
latency trace. That will tell us for sure whether it's the PIO 
instruction that causes the delay.

	Ingo
