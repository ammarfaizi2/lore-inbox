Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751523AbWGMLla@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751523AbWGMLla (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jul 2006 07:41:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751323AbWGMLla
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jul 2006 07:41:30 -0400
Received: from mx3.mail.elte.hu ([157.181.1.138]:56777 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1751535AbWGMLla (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jul 2006 07:41:30 -0400
Date: Thu, 13 Jul 2006 13:35:50 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Jeff Dike <jdike@addtoit.com>
Cc: Andrea Arcangeli <andrea@suse.de>, Andi Kleen <ak@suse.de>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Arjan van de Ven <arjan@infradead.org>, Adrian Bunk <bunk@stusta.de>,
       Andrew Morton <akpm@osdl.org>, Lee Revell <rlrevell@joe-job.com>,
       linux-kernel@vger.kernel.org, Alan Cox <alan@redhat.com>,
       Linus Torvalds <torvalds@osdl.org>
Subject: Re: [patch] let CONFIG_SECCOMP default to n
Message-ID: <20060713113550.GA14107@elte.hu>
References: <20060630014050.GI19712@stusta.de> <p73wtain80h.fsf@verdi.suse.de> <20060712210732.GA10182@elte.hu> <200607130006.12705.ak@suse.de> <20060712221910.GA12905@elte.hu> <20060713031614.GD9102@opteron.random> <20060713112352.GA3384@ccure.user-mode-linux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060713112352.GA3384@ccure.user-mode-linux.org>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.1
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.1 required=5.9 tests=AWL,BAYES_50 autolearn=no SpamAssassin version=3.0.3
	0.0 BAYES_50               BODY: Bayesian spam probability is 40 to 60%
	[score: 0.5000]
	0.1 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Jeff Dike <jdike@addtoit.com> wrote:

> Now, there were a couple of ways to legitimately escape from UML, and 
> they *did* involve ptrace.  Things like single-stepping a system call 
> instruction or putting a breakpoint on a system call instruction and 
> single-stepping from the breakpoint.  As far as I know, these were 
> discovered and fixed by UML developers before there was any outside 
> awareness of these bugs.

also, UML 'ptrace clients' are allowed alot more leeway than what a 
seccomp-alike ptrace/utrace based syscall filter would allow. It would 
clearly exclude activities like 'setting a breakpoint' or 
'single-stepping' - valid syscalls would be limited to 
read/write/sigreturn/exit.

	Ingo
