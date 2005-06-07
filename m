Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261964AbVFGT2r@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261964AbVFGT2r (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Jun 2005 15:28:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261966AbVFGT2q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Jun 2005 15:28:46 -0400
Received: from mx2.elte.hu ([157.181.151.9]:55495 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S261964AbVFGT2l (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Jun 2005 15:28:41 -0400
Date: Tue, 7 Jun 2005 21:25:09 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Michal Schmidt <xschmi00@stud.feec.vutbr.cz>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.12-rc6-V0.7.47-20
Message-ID: <20050607192509.GA8315@elte.hu>
References: <20050607110409.GA14613@elte.hu> <42A5EF2D.5030905@stud.feec.vutbr.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42A5EF2D.5030905@stud.feec.vutbr.cz>
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


* Michal Schmidt <xschmi00@stud.feec.vutbr.cz> wrote:

> Ingo Molnar wrote:
> > - performance feature: i've implemented a new scheduler feature called 
> >   'delayed preemption', [...]
> 
> So far it's only for i386. On x84_64 the kernel doesn't compile.
> Attached is my attempt to make it work on x86_64.
> The diff is against RT-V0.7.47-26.
> 
> Warning: I don't know what I'm doing! But at least it compiles and boots 
> for me.

i'd not have done it differently :) The most important bits are the 
entry.S changes: to correctly update bit-tests to mask-tests and to 
extend any byte-test to a word-test (because bit 9 falls outside of the 
low byte) - you've done that all correctly. I've applied your patch and 
have uploaded the -47-28 release. Boots fine on my x64 box too.

	Ingo
