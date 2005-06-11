Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261227AbVFKEgq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261227AbVFKEgq (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Jun 2005 00:36:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261246AbVFKEgp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Jun 2005 00:36:45 -0400
Received: from mx2.elte.hu ([157.181.151.9]:14032 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S261227AbVFKEgo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Jun 2005 00:36:44 -0400
Date: Sat, 11 Jun 2005 06:32:31 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Esben Nielsen <simlo@phys.au.dk>
Cc: Gabor MICSKO <gmicsko@szintezis.hu>, linux-kernel@vger.kernel.org
Subject: Re: hackbench: 2.6.12-rc6 vs.  2.6.12-rc6-RT-V0.7.48-06
Message-ID: <20050611043231.GA16500@elte.hu>
References: <1118436975.1702.11.camel@alderaan.trey.hu> <Pine.OSF.4.05.10506102306360.5042-100000@da410.phys.au.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.OSF.4.05.10506102306360.5042-100000@da410.phys.au.dk>
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

> Depends on the configuration options. If you used the same configs 
> they should be the same but if you activated PREEMPT_RT it should slow 
> things down due to the overhead of irq-threading and mutexes instead 
> of spinlocks - although I am surprised the factor is _that_ big!

one has to make sure the default debug options are disabled.  
(DEADLOCK_DETECT, PREEMPT_DEBUG, etc.) But even then there will be 
considerable overhead. Until recently, the overhead used to be even 
bigger. Note that hackbench is pretty much the worst-case for 
PREEMPT_RT: lots of locking and scheduling done and we compare the UP 
kernel to the SMP kernel in essence. (in fact PREEMPT_RT's locking is 
currently higher overhead than SMP)

	Ingo
