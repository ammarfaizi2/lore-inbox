Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751048AbVHLGfZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751048AbVHLGfZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Aug 2005 02:35:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751150AbVHLGfZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Aug 2005 02:35:25 -0400
Received: from mx2.elte.hu ([157.181.151.9]:65245 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S1751048AbVHLGfY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Aug 2005 02:35:24 -0400
Date: Fri, 12 Aug 2005 08:36:00 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Lee Revell <rlrevell@joe-job.com>
Cc: "Paul E. McKenney" <paulmck@us.ibm.com>, linux-kernel@vger.kernel.org,
       dipankar@in.ibm.com, rusty@au1.ibm.com, bmark@us.ibm.com,
       Thomas Gleixner <tglx@linutronix.de>, Andrew Morton <akpm@osdl.org>
Subject: Re: [RFC,PATCH] Use RCU to protect tasklist for unicast signals
Message-ID: <20050812063600.GC13397@elte.hu>
References: <20050810171145.GA1945@us.ibm.com> <20050811095634.GA19342@elte.hu> <1123812057.26878.9.camel@mindpipe>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1123812057.26878.9.camel@mindpipe>
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


* Lee Revell <rlrevell@joe-job.com> wrote:

> Doesn't this fix the longest latency we were seeing with 
> PREEMPT_DESKTOP, I don't have a trace handy but the upshot was "signal 
> delivery must remain atomic on !PREEMPT_RT"?

yes - although Paul's patch converts only a portion of the signal code 
to RCU-read-lock, so i'd expect there to be other latencies too. Might 
be worth a test (once we've sorted out the HRT build bugs).

	Ingo
