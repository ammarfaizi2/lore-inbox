Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262566AbVCVIvA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262566AbVCVIvA (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Mar 2005 03:51:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262567AbVCVIvA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Mar 2005 03:51:00 -0500
Received: from mx2.elte.hu ([157.181.151.9]:3795 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S262566AbVCVIu3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Mar 2005 03:50:29 -0500
Date: Tue, 22 Mar 2005 09:50:15 +0100
From: Ingo Molnar <mingo@elte.hu>
To: "Paul E. McKenney" <paulmck@us.ibm.com>
Cc: "Magnus Naeslund(t)" <mag@fbab.net>, linux-kernel@vger.kernel.org
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.12-rc1-V0.7.41-01
Message-ID: <20050322085015.GA16804@elte.hu>
References: <20050319191658.GA5921@elte.hu> <20050320174508.GA3902@us.ibm.com> <20050321085332.GA7163@elte.hu> <20050321090122.GA8066@elte.hu> <20050321090622.GA8430@elte.hu> <423F5456.5010908@fbab.net> <20050322054025.GA1296@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050322054025.GA1296@us.ibm.com>
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

>  		return;
>  	}
>  	rdp->donelist = NULL;
> -	rdp->donetail = &rdp->waitlist;
> +	rdp->donetail = &rdp->donelist;
>  	put_cpu_var(rcu_data);
>  	while (list) {
>  		next = list->next;

seems like the RCU code should use list.h primitives, to avoid bugs like
this and to make the code more readable.

	Ingo
