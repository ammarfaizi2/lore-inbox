Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261255AbVGKSdx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261255AbVGKSdx (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Jul 2005 14:33:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261939AbVGKPQo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Jul 2005 11:16:44 -0400
Received: from mx1.elte.hu ([157.181.1.137]:25035 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S261966AbVGKPQe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Jul 2005 11:16:34 -0400
Date: Mon, 11 Jul 2005 17:16:27 +0200
From: Ingo Molnar <mingo@elte.hu>
To: "Paul E. McKenney" <paulmck@us.ibm.com>
Cc: linux-kernel@vger.kernel.org, dipankar@in.ibm.com
Subject: Re: [RFC] RCU and CONFIG_PREEMPT_RT progress, part 2
Message-ID: <20050711151627.GA19794@elte.hu>
References: <20050625013821.GA2996@us.ibm.com> <20050711150728.GA1497@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050711150728.GA1497@us.ibm.com>
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


* Paul E. McKenney <paulmck@us.ibm.com> wrote:

> Hello!
> 
> More progress on CONFIG_PREEMPT_RT-compatible RCU.
> 
> o	Continued prototyping Linux-kernel implementation, still
> 	in the CONFIG_PREEMPT environment.

cool! With the debugging code removed it doesnt look all that complex.  
Do you think i can attempt to plug this into the -RT tree, or should i 
wait some more? (One observation: if you know some branch is slowpath in 
a common codepath then it's useful to mark the condition via unlikely().  
That results in better code layout and is also a guidance for the casual 
reader of the code.)

	Ingo
