Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932270AbWCPEU3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932270AbWCPEU3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Mar 2006 23:20:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752164AbWCPEU3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Mar 2006 23:20:29 -0500
Received: from mustang.oldcity.dca.net ([216.158.38.3]:29338 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S1752156AbWCPEU2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Mar 2006 23:20:28 -0500
Subject: Re: libata/sata_nv latency on NVIDIA CK804 [was Re: AMD64 X2 lost
	ticks on PM timer]
From: Lee Revell <rlrevell@joe-job.com>
To: "Bill Rugolsky Jr." <brugolsky@telemetry-investments.com>
Cc: Jeff Garzik <jeff@garzik.org>, Ingo Molnar <mingo@elte.hu>,
       Andi Kleen <ak@suse.de>, Jason Baron <jbaron@redhat.com>,
       linux-kernel@vger.kernel.org, john stultz <johnstul@us.ibm.com>,
       Allen Martin <AMartin@nvidia.com>
In-Reply-To: <20060316031528.GF17817@ti64.telemetry-investments.com>
References: <4408BEB5.7000407@garzik.org>
	 <20060303234330.GA14401@ti64.telemetry-investments.com>
	 <200603040107.27639.ak@suse.de>
	 <20060315213638.GA17817@ti64.telemetry-investments.com>
	 <20060315215020.GA18241@elte.hu> <20060315221119.GA21775@elte.hu>
	 <44189654.2080607@garzik.org> <20060315224408.GC24074@elte.hu>
	 <44189A3D.5090202@garzik.org>
	 <20060315231426.GD17817@ti64.telemetry-investments.com>
	 <20060316031528.GF17817@ti64.telemetry-investments.com>
Content-Type: text/plain
Date: Wed, 15 Mar 2006 23:20:24 -0500
Message-Id: <1142482825.1671.148.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.0 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-03-15 at 22:15 -0500, Bill Rugolsky Jr. wrote:
> 
> I'm heading home now (it's 22:00, and I've been here 16 hours
> already), but I figured that I'd post what I have thus far, and
> perhaps you can tell me what the problem is.
> 

I think it would be better to try to identify the exact circumstances
that trigger the large PIO delay, than to start over debugging a new and
untested driver, especially if the SMM hypothesis has been ruled out.

You mentioned before the bug only hits with writes to multiple drives -
can you try to identify a pattern here - stress the drives one at a
time, try RAID vs. stressing both drives independently, remove one from
the bus.  See if anything affects the duration of the latencies, etc.

Lots of people have these boards and it seems like if the problem was
widespread, I would have seen it on the Linux audio lists, as many of
those users run Ingo's instrumented kernel and they all know to report
latency traces when they get them.

Lee

