Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261804AbULOIvf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261804AbULOIvf (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Dec 2004 03:51:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261807AbULOIvf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Dec 2004 03:51:35 -0500
Received: from mx2.elte.hu ([157.181.151.9]:8614 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S261804AbULOIvd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Dec 2004 03:51:33 -0500
Date: Wed, 15 Dec 2004 09:51:15 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Avi Kivity <avi@argo.co.il>
Cc: Lee Revell <rlrevell@joe-job.com>, Andrea Arcangeli <andrea@suse.de>,
       Manfred Spraul <manfred@colorfullife.com>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       George Anzinger <george@mvista.com>, dipankar@in.ibm.com,
       ganzinger@mvista.com, lkml <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       Andi Kleen <ak@suse.de>
Subject: Re: [patch, 2.6.10-rc3] safe_hlt() & NMIs
Message-ID: <20041215085115.GA13419@elte.hu>
References: <41BB2108.70606@colorfullife.com> <41BB25B2.90303@mvista.com> <Pine.LNX.4.61.0412111947280.7847@montezuma.fsmlabs.com> <41BC0854.4010503@colorfullife.com> <20041212093714.GL16322@dualathlon.random> <41BC1BF9.70701@colorfullife.com> <20041212121546.GM16322@dualathlon.random> <1103060437.14699.27.camel@krustophenia.net> <20041214222307.GB22043@elte.hu> <41BFD966.4010303@argo.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41BFD966.4010303@argo.co.il>
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


* Avi Kivity <avi@argo.co.il> wrote:

> Ingo Molnar wrote:
> 
> >+	if (__kernel_text_address(regs->eip) && *(char *)regs->eip == 0xf4)
> > 
> >
> shouldn't that cast be (unsigned char *), otherwise the test will
> always fail?

yes, i fixed this in the second patch. (the compiler warned about it
too)

	Ingo
