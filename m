Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261883AbULOFFJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261883AbULOFFJ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Dec 2004 00:05:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261887AbULOFFJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Dec 2004 00:05:09 -0500
Received: from news.suse.de ([195.135.220.2]:39388 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S261883AbULOFFF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Dec 2004 00:05:05 -0500
Date: Wed, 15 Dec 2004 06:04:49 +0100
From: Andi Kleen <ak@suse.de>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Ingo Molnar <mingo@elte.hu>, Lee Revell <rlrevell@joe-job.com>,
       Andrea Arcangeli <andrea@suse.de>,
       Manfred Spraul <manfred@colorfullife.com>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       George Anzinger <george@mvista.com>, dipankar@in.ibm.com,
       ganzinger@mvista.com, lkml <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Andi Kleen <ak@suse.de>
Subject: Re: [patch, 2.6.10-rc3] safe_hlt() & NMIs
Message-ID: <20041215050449.GI27225@wotan.suse.de>
References: <41BB2108.70606@colorfullife.com> <41BB25B2.90303@mvista.com> <Pine.LNX.4.61.0412111947280.7847@montezuma.fsmlabs.com> <41BC0854.4010503@colorfullife.com> <20041212093714.GL16322@dualathlon.random> <41BC1BF9.70701@colorfullife.com> <20041212121546.GM16322@dualathlon.random> <1103060437.14699.27.camel@krustophenia.net> <20041214222307.GB22043@elte.hu> <Pine.LNX.4.58.0412141450430.3279@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0412141450430.3279@ppc970.osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> But something like
> 
> 	static inline int kernel_mode(struct pt_regs *regs)
> 	{
> 		return !((regs->eflags & VM_MASK) | (regs->xcs & 3));
> 	}
> 
> should DTRT.
> 
> Can you pls double-check my thinking, and test?

Reasoning looks correct to me. 

-Andi
