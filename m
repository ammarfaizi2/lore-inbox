Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262546AbVHDNv5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262546AbVHDNv5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Aug 2005 09:51:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262548AbVHDNvy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Aug 2005 09:51:54 -0400
Received: from mx2.elte.hu ([157.181.151.9]:7610 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S262546AbVHDNvZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Aug 2005 09:51:25 -0400
Date: Thu, 4 Aug 2005 15:52:00 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Yang Yi <yang.yi@bmrtech.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] latency logger for realtime-preempt-2.6.12-final-V0.7.51-30
Message-ID: <20050804135200.GA14402@elte.hu>
References: <1123042757.2997.5.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1123042757.2997.5.camel@localhost.localdomain>
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


* Yang Yi <yang.yi@bmrtech.com> wrote:

> > looks pretty good! I'll look at merging your patch after KS/OLS.
> 
> Do you have any trouble while you merge that latency logger patch?

i've merged it to the -52-11 patch that, and i've uploaded it a couple 
of minutes ago.

i have done a number of cleanups on it - e.g. instead of latency logging 
it's now called latency histogram, and i've also fixed a number of 
coding style issues. Please double-check that it's still OK, seems to 
work here.

would be nice to clean up the impact of the latency-histogram code some 
more though: e.g. the #ifdef jungle check_critical_timing() is 
disgusting. Could be cleaned up by always recording the latency_type 
being currently traced into a new tr->latency_type field, and then using 
that in check_critical_timing().

	Ingo
