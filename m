Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269206AbUJQR0i@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269206AbUJQR0i (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 17 Oct 2004 13:26:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269217AbUJQR0h
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Oct 2004 13:26:37 -0400
Received: from mx2.elte.hu ([157.181.151.9]:64405 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S269206AbUJQR0a (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Oct 2004 13:26:30 -0400
Date: Sun, 17 Oct 2004 19:27:47 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Rui Nuno Capela <rncbc@rncbc.org>
Cc: Lee Revell <rlrevell@joe-job.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       mark_h_johnson@raytheon.com, "K.R. Foley" <kr@cybsft.com>,
       Daniel Walker <dwalker@mvista.com>, Bill Huey <bhuey@lnxw.com>,
       Andrew Morton <akpm@osdl.org>, Adam Heath <doogie@debian.org>,
       Lorenzo Allegrucci <l_allegrucci@yahoo.it>,
       Andrew Rodland <arodland@entermail.net>
Subject: Re: [patch] Real-Time Preemption, -VP-2.6.9-rc4-mm1-U3
Message-ID: <20041017172747.GA28131@elte.hu>
References: <1097888438.6737.63.camel@krustophenia.net> <1097894120.31747.1.camel@krustophenia.net> <20041016064205.GA30371@elte.hu> <1097917325.1424.13.camel@krustophenia.net> <20041016103608.GA3548@elte.hu> <32801.192.168.1.5.1098018846.squirrel@192.168.1.5> <20041017132107.GA18462@elte.hu> <32793.192.168.1.5.1098023139.squirrel@192.168.1.5> <20041017161228.GB22620@elte.hu> <32798.192.168.1.5.1098033608.squirrel@192.168.1.5>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <32798.192.168.1.5.1098033608.squirrel@192.168.1.5>
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


* Rui Nuno Capela <rncbc@rncbc.org> wrote:

> > ok, then please try to do a sysrq-T. The bootup is soft-hung for some
> > reason, lets see what tasks are around.
> >
> 
> Hey, all the captured files I've sent, minicom.cap{0,1,2,3,4,5}, includes
> the SysRq-T output, taken right after the hang. Am I missing something?

ah, ok, my fault. I started with minicom.cap.0 and stopped here:

SysRq : Emergency Sync

because this itself caused some regression too. It seems init is blocked
on the dcache_lock mutex, but lets first see whether 8K stacks fix your
box - stack overflows can cause nasty, mostly random bugs that look like
real bugs.

	Ingo
