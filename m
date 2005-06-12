Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261895AbVFLGfz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261895AbVFLGfz (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Jun 2005 02:35:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261889AbVFLGfy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Jun 2005 02:35:54 -0400
Received: from mx2.elte.hu ([157.181.151.9]:31170 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S261901AbVFLGfP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Jun 2005 02:35:15 -0400
Date: Sun, 12 Jun 2005 08:11:08 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Karim Yaghmour <karim@opersys.com>
Cc: Kristian Benoit <kbenoit@opersys.com>, linux-kernel@vger.kernel.org,
       paulmck@us.ibm.com, bhuey@lnxw.com, andrea@suse.de, tglx@linutronix.de,
       pmarques@grupopie.com, bruce@andrew.cmu.edu, nickpiggin@yahoo.com.au,
       ak@muc.de, sdietrich@mvista.com, dwalker@mvista.com, hch@infradead.org,
       akpm@osdl.org, rpm@xenomai.org
Subject: Re: PREEMPT_RT vs ADEOS: the numbers, part 1
Message-ID: <20050612061108.GA4554@elte.hu>
References: <42AA6A6B.5040907@opersys.com> <20050611191448.GA24152@elte.hu> <42AB662B.4010104@opersys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42AB662B.4010104@opersys.com>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Karim Yaghmour <karim@opersys.com> wrote:

> Ingo Molnar wrote:
> > how were interrupt response times measured, precisely? What did the 
> > target (measured) system have to do to respond to an interrupt? Did you 
> > use the RTC to measure IRQ latencies?
> 
> The logger used two TSC values. One prior to shooting the interrupt to 
> the target, and one when receiving the response. Responding to an 
> interrupt meant that a driver was hooked to the target's parallel port 
> interrupt and simply acted by toggling an output pin on the parallel 
> port, which in turn was hooked onto the logger's parallel port in a 
> similar fashion. We'll post the code for all components (both logger 
> and target) for everyone to review. There's no validity in any tests 
> if others can't analyze/criticize/ duplicate.

ok, this method should work fine. I suspect you increased the parport 
IRQ's priority to the maximum on the PREEMPT_RT kernel, correct? Was 
there any userspace thread on the target system (receiving the parport 
request and sending the reply), or was it all done in a kernelspace 
parport driver?

	Ingo
