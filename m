Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262441AbVFVW26@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262441AbVFVW26 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Jun 2005 18:28:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261175AbVFVW26
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Jun 2005 18:28:58 -0400
Received: from mx1.elte.hu ([157.181.1.137]:37329 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S262441AbVFVWFK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Jun 2005 18:05:10 -0400
Date: Thu, 23 Jun 2005 00:04:28 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Karim Yaghmour <karim@opersys.com>
Cc: Bill Huey <bhuey@lnxw.com>, Kristian Benoit <kbenoit@opersys.com>,
       linux-kernel@vger.kernel.org, paulmck@us.ibm.com, andrea@suse.de,
       tglx@linutronix.de, pmarques@grupopie.com, bruce@andrew.cmu.edu,
       nickpiggin@yahoo.com.au, ak@muc.de, sdietrich@mvista.com,
       dwalker@mvista.com, hch@infradead.org, akpm@osdl.org, rpm@xenomai.org
Subject: Re: PREEMPT_RT vs I-PIPE: the numbers, part 2
Message-ID: <20050622220428.GA28906@elte.hu>
References: <1119287612.6863.1.camel@localhost> <20050620183115.GA27028@nietzsche.lynx.com> <42B98B20.7020304@opersys.com> <20050622192927.GA13817@nietzsche.lynx.com> <20050622200554.GA16119@elte.hu> <42B9CC98.1040402@opersys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42B9CC98.1040402@opersys.com>
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


* Karim Yaghmour <karim@opersys.com> wrote:

> Ingo Molnar wrote:
> > the UDP-over-localhost latency was a softirq processing bug that is 
> > fixed in current PREEMPT_RT patches. (real over-the-network latency was 
> > never impacted, that's why it wasnt noticed before.)
> 
> That's good to hear, but here are some random stats from the idle run:

please retest using recent (i.e. today's) -RT kernels. There were a
whole bunch of fixes that could affect these numbers. (But i'm sure you
know very well that you cannot expect a fully-preemptible kernel to have
zero runtime cost. In that sense, if you want to be fair, you should
compare it to the SMP kernel, as total preemptability is a similar
technological feat and has very similar parallelism constraints.)

	Ingo
