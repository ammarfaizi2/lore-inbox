Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261296AbVAWLbp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261296AbVAWLbp (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 23 Jan 2005 06:31:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261297AbVAWLbp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 23 Jan 2005 06:31:45 -0500
Received: from mx2.elte.hu ([157.181.151.9]:39625 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S261296AbVAWLbn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 23 Jan 2005 06:31:43 -0500
Date: Sun, 23 Jan 2005 12:31:11 +0100
From: Ingo Molnar <mingo@elte.hu>
To: andyliu <liudeyan@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.11-rc2-V0.7.36-00
Message-ID: <20050123113111.GA11965@elte.hu>
References: <20041122005411.GA19363@elte.hu> <20050115133454.GA8748@elte.hu> <20050122122915.GA7098@elte.hu> <200501221622.24273.gene.heskett@verizon.net> <aad1205e05012301271de3e365@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aad1205e05012301271de3e365@mail.gmail.com>
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


* andyliu <liudeyan@gmail.com> wrote:

> hi , ingo
> 
> i am trying to understand your patch,but the patch file is so long and
> complex. i am wondering is there some documents about your patch?
> 
> :)

well, it mainly offers the PREEMPT_RT feature, which is a 'no
compromises' variant of kernel preemption: virtually everything
(including normal spinlocked sections) is preemptable, with the goal of
providing hard-realtime category ~10-20 usecs maximum scheduling latency
guarantees on a typical PC (or embedded platform). Those long and
complex changes are almost all needed to achieve this goal.

this tree is mainly an experiment to see what it takes to achieve that
latency goal, and to see how much of that can go upstream (without
having to decide whether upstream wants to have the PREEMPT_RT feature
or not). (A couple of dozen patches were already split out of this patch
and are in the current upstream kernel - they already made a latency
difference for the 2.6.10 kernel.)

	Ingo
