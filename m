Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263045AbVCXFf2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263045AbVCXFf2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Mar 2005 00:35:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263044AbVCXFf1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Mar 2005 00:35:27 -0500
Received: from mx2.elte.hu ([157.181.151.9]:19624 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S263037AbVCXFfN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Mar 2005 00:35:13 -0500
Date: Thu, 24 Mar 2005 06:34:56 +0100
From: Ingo Molnar <mingo@elte.hu>
To: "Paul E. McKenney" <paulmck@us.ibm.com>
Cc: linux-kernel@vger.kernel.org, Esben Nielsen <simlo@phys.au.dk>
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.12-rc1-V0.7.41-07
Message-ID: <20050324053456.GA14494@elte.hu>
References: <20050321090622.GA8430@elte.hu> <20050322054345.GB1296@us.ibm.com> <20050322072413.GA6149@elte.hu> <20050322092331.GA21465@elte.hu> <20050322093201.GA21945@elte.hu> <20050322100153.GA23143@elte.hu> <20050322112856.GA25129@elte.hu> <20050323061601.GE1294@us.ibm.com> <20050323063317.GB31626@elte.hu> <20050324052854.GA1298@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050324052854.GA1298@us.ibm.com>
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

> Now, it is true that CPU#2 might record a quiescent state during this 
> time, but this will have no effect because -all- CPUs must pass 
> through a quiescent state before any callbacks will be invoked.  Since 
> CPU#1 is refusing to record a quiescent state, grace periods will be 
> blocked for the full extent of task 1's RCU read-side critical 
> section.

ok, great. So besides the barriers issue (and the long grace period time 
issue), the current design is quite ok. And i think your original flip 
pointers suggestion can be used to force synchronization.

	Ingo
