Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261174AbUKWMc6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261174AbUKWMc6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Nov 2004 07:32:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261191AbUKWMc6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Nov 2004 07:32:58 -0500
Received: from mx2.elte.hu ([157.181.151.9]:5786 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S261174AbUKWMc4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Nov 2004 07:32:56 -0500
Date: Tue, 23 Nov 2004 14:34:56 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Esben Nielsen <simlo@phys.au.dk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Priority Inheritance Test (Real-Time Preemption)
Message-ID: <20041123133456.GA10453@elte.hu>
References: <Pine.OSF.4.05.10411212107240.29110-100000@da410.ifa.au.dk> <20041122002702.GB16936@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041122002702.GB16936@elte.hu>
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


* Ingo Molnar <mingo@elte.hu> wrote:

> 
> >  From realfeel I wrote a small, simple test to test how well priority
> > inheritance mechanism works. 
> 
> cool - this is a really useful testsuite.

FYI, i've put the 'blocker device' kernel code into the current -RT
patch (-30-7). This makes it possible to build it on SMP (which didnt
work when it was a module), and generally makes it easier to do testing
via pi_test.

The only change needed on the userspace pi_test side was to add -O2 to
the CFLAGS in the Makefile to make the loop() timings equivalent, and to
remove the module compilations. I've added a .config option for it too
and cleaned up the code.

	Ingo
