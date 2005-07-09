Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261613AbVGIRWW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261613AbVGIRWW (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Jul 2005 13:22:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261626AbVGIRWW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Jul 2005 13:22:22 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:1530 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S261613AbVGIRWV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Jul 2005 13:22:21 -0400
Subject: Re: PREEMPT_RT and I-PIPE: the numbers, part 4
From: Daniel Walker <dwalker@mvista.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: Kristian Benoit <kbenoit@opersys.com>, linux-kernel@vger.kernel.org,
       paulmck@us.ibm.com, bhuey@lnxw.com, andrea@suse.de, tglx@linutronix.de,
       karim@opersys.com, pmarques@grupopie.com, bruce@andrew.cmu.edu,
       nickpiggin@yahoo.com.au, ak@muc.de, sdietrich@mvista.com,
       hch@infradead.org, akpm@osdl.org, rpm@xenomai.org
In-Reply-To: <20050709071911.GB31100@elte.hu>
References: <42CF05BE.3070908@opersys.com>  <20050709071911.GB31100@elte.hu>
Content-Type: text/plain
Date: Sat, 09 Jul 2005 10:22:07 -0700
Message-Id: <1120929727.22337.15.camel@c-67-188-6-232.hsd1.ca.comcast.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2005-07-09 at 09:19 +0200, Ingo Molnar wrote:


> (if your goal was to check how heavily external interrupts can influence 
> a PREEMPT_RT box, you should chrt the network IRQ thread to SCHED_OTHER 
> and renice it and softirq-net-rx and softirq-net-tx to nice +19.)
> 

This is interesting. I wonder how much tuning like this , just changing
thread priorities, which would effect the results of these tests.
PREEMPT_RT is not pre-tuned for every situation , but the bests
performance is achieved when the system is tuned. If any of these tests
rely on a low priority thread, then we just raise the priority and you
have better performance.

These other systems like Vanilla 2.6.x , and I-pipe aren't massively
tunable like PREEMPT_RT . 

Daniel 

