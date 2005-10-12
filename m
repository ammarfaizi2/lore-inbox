Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932397AbVJLHKU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932397AbVJLHKU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Oct 2005 03:10:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932398AbVJLHKU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Oct 2005 03:10:20 -0400
Received: from mx3.mail.elte.hu ([157.181.1.138]:60392 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S932397AbVJLHKT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Oct 2005 03:10:19 -0400
Date: Wed, 12 Oct 2005 09:10:37 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Fernando Lopez-Lezcano <nando@ccrma.Stanford.EDU>
Cc: linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
       Steven Rostedt <rostedt@goodmis.org>, dwalker@mvista.com,
       david singleton <dsingleton@mvista.com>
Subject: Re: 2.6.14-rc4-rt1
Message-ID: <20051012071037.GA19018@elte.hu>
References: <20051011111454.GA15504@elte.hu> <1129064151.5324.6.camel@cmn3.stanford.edu> <20051012061455.GA16586@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051012061455.GA16586@elte.hu>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=AWL autolearn=disabled SpamAssassin version=3.0.3
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


another thing: might be worth trying PREEMPT_RT too, maybe it makes a 
difference.

Also, i noticed an unrelated .config thing: while you have 
PREEMPT_DESKTOP, PREEMPT_BKL and irq/softirq threading turned on, you 
dont have PREEMPT_RCU enabled. PREEMPT_RCU is pretty useful, it can get 
rid of a number of latency sources. Might be worth a try for your 
kernel.

	Ingo
