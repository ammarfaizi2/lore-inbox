Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261714AbVGITmi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261714AbVGITmi (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Jul 2005 15:42:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261710AbVGITme
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Jul 2005 15:42:34 -0400
Received: from mx2.elte.hu ([157.181.151.9]:57050 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S261714AbVGITmc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Jul 2005 15:42:32 -0400
Date: Sat, 9 Jul 2005 21:42:20 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Andi Kleen <ak@suse.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [patch] compress the stack layout of do_page_fault(), x86
Message-ID: <20050709194220.GA20791@elte.hu>
References: <20050709144116.GA9444@elte.hu.suse.lists.linux.kernel> <20050709152924.GA13492@elte.hu.suse.lists.linux.kernel> <p73ll4f29m7.fsf@verdi.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <p73ll4f29m7.fsf@verdi.suse.de>
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


* Andi Kleen <ak@suse.de> wrote:

> Ingo Molnar <mingo@elte.hu> writes:
> >  
> > +static void force_sig_info_fault(int si_signo, int si_code,
> > +				 unsigned long address, struct task_struct *tsk)
> 
> This won't work with a unit-at-a-time compiler which happily inlines 
> everything static with only a single caller. Use noinline

this function has two callers.

	Ingo
