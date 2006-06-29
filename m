Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932506AbWF2UsO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932506AbWF2UsO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jun 2006 16:48:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932507AbWF2UsO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jun 2006 16:48:14 -0400
Received: from mx3.mail.elte.hu ([157.181.1.138]:63388 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S932506AbWF2UsN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jun 2006 16:48:13 -0400
Date: Thu, 29 Jun 2006 22:43:28 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Andrew Morton <akpm@osdl.org>
Cc: kaos@ocs.com.au, ak@suse.de, linux-kernel@vger.kernel.org
Subject: Re: i386 IPI handlers running with hardirq_count == 0
Message-ID: <20060629204328.GA31307@elte.hu>
References: <p73wtb0w6dp.fsf@verdi.suse.de> <9914.1151600442@ocs3.ocs.com.au> <20060629201752.GA25300@elte.hu> <20060629134731.518120b8.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060629134731.518120b8.akpm@osdl.org>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.1
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.1 required=5.9 tests=AWL,BAYES_50 autolearn=no SpamAssassin version=3.0.3
	0.0 BAYES_50               BODY: Bayesian spam probability is 40 to 60%
	[score: 0.5010]
	0.1 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Andrew Morton <akpm@osdl.org> wrote:

> There's a risk that spin_unlock() in an IPI handler could blow up due 
> to it trying to reschedule.  But preempt_schedule() explicitly checks 
> the CPU's interupt flag so as long as that doesn't change we're OK.

yes. Enabling hardirqs in an IPI handler would be a quite bad idea 
anyway, they are all quite short.

	Ingo
