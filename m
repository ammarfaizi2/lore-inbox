Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261561AbVFENuG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261561AbVFENuG (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Jun 2005 09:50:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261564AbVFENuG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Jun 2005 09:50:06 -0400
Received: from mx2.elte.hu ([157.181.151.9]:39588 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S261561AbVFENuB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Jun 2005 09:50:01 -0400
Date: Sun, 5 Jun 2005 15:49:16 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Esben Nielsen <simlo@phys.au.dk>
Cc: Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
       Inaky Perez-Gonzalez <inaky.perez-gonzalez@intel.com>,
       Daniel Walker <dwalker@mvista.com>, Oleg Nesterov <oleg@tv-sign.ru>
Subject: Re: [patch] Real-Time Preemption, plist fixes
Message-ID: <20050605134916.GA20721@elte.hu>
References: <20050605082616.GA26824@elte.hu> <Pine.OSF.4.05.10506051044340.4252-100000@da410.phys.au.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.OSF.4.05.10506051044340.4252-100000@da410.phys.au.dk>
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


* Esben Nielsen <simlo@phys.au.dk> wrote:

> [...] In extreme load situations we could end up with a lot of waiters 
> on mmap_sem forinstance.

what do you mean by extreme load. Extreme number of RT tasks, or extreme 
number of tasks altogether? The sorted-list implementation i had in -RT 
had all non-RT tasks handled in an O(1) way - the O(N) component was for 
adding RT tasks (removal was O(1)).

so the question is - can we have an extreme (larger than 140) number of 
RT tasks? If yes, why are they all RT - they can have no expectation of 
good latencies with a possible load factor of 140!

	Ingo
