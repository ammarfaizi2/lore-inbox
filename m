Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268080AbUJOPoj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268080AbUJOPoj (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Oct 2004 11:44:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268084AbUJOPoi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Oct 2004 11:44:38 -0400
Received: from mx1.elte.hu ([157.181.1.137]:32701 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S268080AbUJOPoZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Oct 2004 11:44:25 -0400
Date: Fri, 15 Oct 2004 17:45:42 +0200
From: Ingo Molnar <mingo@elte.hu>
To: "Paul E. McKenney" <paulmck@us.ibm.com>
Cc: Dipankar Sarma <dipankar@in.ibm.com>, Sven Dietrich <sdietrich@mvista.com>,
       Daniel Walker <dwalker@mvista.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, abatyrshin@ru.mvista.com,
       amakarov@ru.mvista.com, emints@ru.mvista.com, ext-rt-dev@mvista.com,
       hzhang@ch.mvista.com, yyang@ch.mvista.com,
       "Witold. Jaworski@Unibw-Muenchen. De" 
	<witold.jaworski@unibw-muenchen.de>,
       arnd.heursch@unibw-muenchen.de
Subject: Re: [ANNOUNCE] Linux 2.6 Real Time Kernel
Message-ID: <20041015154542.GA8257@elte.hu>
References: <20041011215420.GA19796@elte.hu> <EOEGJOIIAIGENMKBPIAECEIEDKAA.sdietrich@mvista.com> <20041012055029.GB1479@elte.hu> <20041014050905.GA6927@in.ibm.com> <20041014071810.GB9729@elte.hu> <20041015145915.GA1266@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041015145915.GA1266@us.ibm.com>
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


* Paul E. McKenney <paulmck@us.ibm.com> wrote:

> One caution (which you are no doubt already aware of) -- if an RCU
> algorithm that reads (rcu_read_lock()/rcu_read_unlock()) in process
> context and updates in softirq/bh/irq context, you can see deadlocks.

yeah - but in the PREEMPT_REALTIME kernel there are simply no irq or
softirq contexts in process contexts - everything is a task. So
everything can (and does) block.

	Ingo
