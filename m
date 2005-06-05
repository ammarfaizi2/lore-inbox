Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261536AbVFEIzA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261536AbVFEIzA (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Jun 2005 04:55:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261537AbVFEIzA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Jun 2005 04:55:00 -0400
Received: from mx2.elte.hu ([157.181.151.9]:22670 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S261536AbVFEIyr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Jun 2005 04:54:47 -0400
Date: Sun, 5 Jun 2005 10:53:13 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Esben Nielsen <simlo@phys.au.dk>
Cc: Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
       Inaky Perez-Gonzalez <inaky.perez-gonzalez@intel.com>,
       Daniel Walker <dwalker@mvista.com>, Oleg Nesterov <oleg@tv-sign.ru>
Subject: Re: patch] Real-Time Preemption, plist fixes
Message-ID: <20050605085313.GA30946@elte.hu>
References: <1117958706.20785.243.camel@tglx.tec.linutronix.de> <Pine.OSF.4.05.10506051014230.4252-100000@da410.phys.au.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.OSF.4.05.10506051014230.4252-100000@da410.phys.au.dk>
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


* Esben Nielsen <simlo@phys.au.dk> wrote:

> When K is a constant or bounded by a constant (140 in this 
> application) any function which is O(K) is O(1) per definition of O!

technically you are right. But the question is - while K is considered a 
constant, and N (nr_running_RT_tasks) is technically not bounded - in 
practice N is bounded just as much. Have you ever seen any hard-RT 
application that has more than 140 threads _running at the same time_ on 
a single CPU? You can even enforce it to be theoretically bounded, via 
ulimits.

in fact, K and N should be pretty close to each other for most 
applications. I'd be interested in real application scenarios where N is 
much (== more than 10 times) larger than K and plists really matter.

	Ingo
