Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751205AbVL3Hoi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751205AbVL3Hoi (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Dec 2005 02:44:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751206AbVL3Hoi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Dec 2005 02:44:38 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:48547 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1751205AbVL3Hoh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Dec 2005 02:44:37 -0500
Date: Fri, 30 Dec 2005 08:44:24 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Lee Revell <rlrevell@joe-job.com>
Cc: kus Kusche Klaus <kus@keba.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Latency traces I cannot interpret (sa1100, 2.6.15-rc7-rt1)
Message-ID: <20051230074424.GB25637@elte.hu>
References: <AAD6DA242BC63C488511C611BD51F367323307@MAILIT.keba.co.at> <1135927789.12146.1.camel@mindpipe>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1135927789.12146.1.camel@mindpipe>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: -1.9
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-1.9 required=5.9 tests=ALL_TRUSTED,AWL autolearn=no SpamAssassin version=3.0.3
	-2.8 ALL_TRUSTED            Did not pass through any untrusted hosts
	0.9 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


there seem to be leaked preempt counts:

  <idle>-0     0.n.1 8974us : touch_critical_timing (cpu_idle)

we should never have preemption disabled in cpu_idle(). To debug leaked 
preemption counts, enable CONFIG_DEBUG_PREEMPT.

	Ingo
