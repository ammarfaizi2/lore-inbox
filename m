Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262254AbVBQH5k@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262254AbVBQH5k (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Feb 2005 02:57:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262255AbVBQH5k
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Feb 2005 02:57:40 -0500
Received: from mx1.elte.hu ([157.181.1.137]:18921 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S262254AbVBQH5b (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Feb 2005 02:57:31 -0500
Date: Thu, 17 Feb 2005 08:57:13 +0100
From: Ingo Molnar <mingo@elte.hu>
To: rostedt@kihontech.com
Cc: "David S. Miller" <davem@davemloft.net>, mgross@linux.intel.com,
       linux-kernel@vger.kernel.org, Mark_H_Johnson@raytheon.com
Subject: Re: queue_work from interrupt Real time preemption2.6.11-rc2-RT-V0.7.37-03
Message-ID: <20050217075713.GB21621@elte.hu>
References: <200502141240.14355.mgross@linux.intel.com> <200502141429.11587.mgross@linux.intel.com> <20050215104153.GB19866@elte.hu> <200502151006.44809.mgross@linux.intel.com> <20050216051645.GB15197@elte.hu> <20050216081143.50d0a9d6.davem@davemloft.net> <Pine.LNX.4.58.0502161242180.14526@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0502161242180.14526@localhost.localdomain>
User-Agent: Mutt/1.4.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Steven Rostedt <rostedt@goodmis.org> wrote:

> > See net/core/dev.c:softnet_data
> 
> How about a design to put softirq's into domains. [...]

just to make sure that the context of this discussion is not lost to
David and other readers of lkml. We are not redesigning softirqs in any
way, shape or form for the normal kernel - there they remain what they
are.

This discussion is about seemless (automatic) extensions/modifications
to the softirq concept on PREEMPT_RT, for latency reduction purposes.
PREEMPT_SOFTIRQS is already such an extension.

	Ingo
