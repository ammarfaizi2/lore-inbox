Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262645AbVDAGAy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262645AbVDAGAy (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Apr 2005 01:00:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262648AbVDAGAy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Apr 2005 01:00:54 -0500
Received: from mx1.elte.hu ([157.181.1.137]:43450 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S262645AbVDAGAt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Apr 2005 01:00:49 -0500
Date: Fri, 1 Apr 2005 07:55:39 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Mark Gross <mgross@linux.intel.com>
Cc: rostedt@kihontech.com, Steven Rostedt <rostedt@goodmis.org>,
       "David S. Miller" <davem@davemloft.net>, linux-kernel@vger.kernel.org,
       Mark_H_Johnson@raytheon.com
Subject: Re: queue_work from interrupt Real time preemption2.6.11-rc2-RT-V0.7.37-03
Message-ID: <20050401055539.GB24508@elte.hu>
References: <200502141240.14355.mgross@linux.intel.com> <200502170814.42903.mgross@linux.intel.com> <20050329085734.GA7074@elte.hu> <200503311041.05955.mgross@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200503311041.05955.mgross@linux.intel.com>
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


* Mark Gross <mgross@linux.intel.com> wrote:

> BTW:
> 
> My work on this has been mostly in the context of a 2.6 kernel based 
> generalization of a softIRQ as thread patch for 2.4 that enables 
> priority tuning of the bottom half processing as well as /proc support 
> for turning on and off the feature.  We got it to work.
> 
> However; I don't know what good workloads and metrics to measure the 
> goodness of the work look like.  If folks think priority tuning of 
> bottom half processing is worth persuing and can help me quantify its 
> effectiveness better than running a jitter test while doing a BONNIE 
> test run on a SCSI JBOD, then I'm happy to do more with this.

anything that generates a consistent interrupt rate is pretty good for 
testing. Networking is the most softirq-dependent code, so i'd say 
tbench over a real network ought to be a good benchmark.

	Ingo
