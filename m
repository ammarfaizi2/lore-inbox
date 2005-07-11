Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262236AbVGKFDh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262236AbVGKFDh (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Jul 2005 01:03:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262240AbVGKFDh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Jul 2005 01:03:37 -0400
Received: from mx2.elte.hu ([157.181.151.9]:14266 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S262236AbVGKFDg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Jul 2005 01:03:36 -0400
Date: Mon, 11 Jul 2005 07:03:03 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Serge Noiraud <serge.noiraud@bull.net>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: PREEMPT_RT and latency_trace
Message-ID: <20050711050303.GA13190@elte.hu>
References: <1120826951.6225.167.camel@ibiza.btsn.frna.bull.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1120826951.6225.167.camel@ibiza.btsn.frna.bull.fr>
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


* Serge Noiraud <serge.noiraud@bull.net> wrote:

> Hi,
> 
> I have a big dilemna on one machine :
> I run a task with RT priority which make a loop to mesure the system
> perturbation.
> It works well except on  one machine.
> On a multi-cpu, If I run the program on cpu 1, I get 23us. It's OK.
> If I run the same program on cpu 0, I get 17373us !

could you try the -51-24 (or later) kernel, does it have any better 
latencies? It has a PI fix that fixes the recent priority leakage 
observed on SMP systems. The priority leakage can lead to excessive 
delays in RT apps.

	Ingo
