Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030279AbVHKLdZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030279AbVHKLdZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Aug 2005 07:33:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030280AbVHKLdZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Aug 2005 07:33:25 -0400
Received: from mx2.elte.hu ([157.181.151.9]:57996 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S1030279AbVHKLdY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Aug 2005 07:33:24 -0400
Date: Thu, 11 Aug 2005 13:33:36 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Daniel Walker <dwalker@mvista.com>
Cc: Yang Yi <yang.yi@bmrtech.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] latency logger for realtime-preempt-2.6.12-final-V0.7.51-30
Message-ID: <20050811113336.GA22591@elte.hu>
References: <1123042757.2997.5.camel@localhost.localdomain> <20050804135200.GA14402@elte.hu> <1123724676.8187.17.camel@dhcp153.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1123724676.8187.17.camel@dhcp153.mvista.com>
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


* Daniel Walker <dwalker@mvista.com> wrote:

> On Thu, 2005-08-04 at 15:52 +0200, Ingo Molnar wrote:
> 
> > would be nice to clean up the impact of the latency-histogram code some 
> > more though: e.g. the #ifdef jungle check_critical_timing() is 
> > disgusting. Could be cleaned up by always recording the latency_type 
> > being currently traced into a new tr->latency_type field, and then using 
> > that in check_critical_timing().
> 
> the code appears to be adding ifdefs to make preempt_max_latency work 
> like preempt_threshold , I think all the nasty ifdefs could go away if 
> we just made it use preempt_threshold .. Plus it logs latency during 
> boot up cause preempt_max_latency equals zero .

yes. Would be nice to have these cleanups too. The #ifdef impact of the 
LATENCY_HIST code is quite high at the moment, and it needs to be 
decreased.

	Ingo
