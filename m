Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750740AbWDINTX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750740AbWDINTX (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 Apr 2006 09:19:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750741AbWDINTX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 Apr 2006 09:19:23 -0400
Received: from mx3.mail.elte.hu ([157.181.1.138]:41192 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1750740AbWDINTW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 Apr 2006 09:19:22 -0400
Date: Sun, 9 Apr 2006 15:16:49 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Darren Hart <darren@dvhart.com>
Cc: linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
       "Stultz, John" <johnstul@us.ibm.com>,
       Peter Williams <pwil3058@bigpond.net.au>,
       "Siddha, Suresh B" <suresh.b.siddha@intel.com>,
       Nick Piggin <nickpiggin@yahoo.com.au>
Subject: Re: RT task scheduling
Message-ID: <20060409131649.GA19082@elte.hu>
References: <200604052025.05679.darren@dvhart.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200604052025.05679.darren@dvhart.com>
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


* Darren Hart <darren@dvhart.com> wrote:

> My last mail specifically addresses preempt-rt, but I'd like to know 
> people's thoughts regarding this issue in the mainline kernel.  Please 
> see my previous post "realtime-preempt scheduling - rt_overload 
> behavior" for a testcase that produces unpredictable scheduling 
> results.

thanks for the testcase! It indeed triggered a bug in the -rt tree's 
"RT-overload" balancing feature. The nature of the bug made it trigger 
much less likely on 2-way boxes (where i do most of my -rt testing), 
probably that's why it didnt get discovered before. I've uploaded the 
-rt14 tree with this bug fixed - does it fix the failures for you?

	Ingo
