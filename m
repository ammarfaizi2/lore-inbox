Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267505AbUG2SMR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267505AbUG2SMR (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jul 2004 14:12:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267474AbUG2SJY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jul 2004 14:09:24 -0400
Received: from mx2.elte.hu ([157.181.151.9]:37567 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S264936AbUG2SEy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jul 2004 14:04:54 -0400
Date: Thu, 29 Jul 2004 20:04:11 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Lee Revell <rlrevell@joe-job.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       William Lee Irwin III <wli@holomorphy.com>,
       Lenar L?hmus <lenar@vision.ee>, Andrew Morton <akpm@osdl.org>,
       Arjan van de Ven <arjanv@redhat.com>
Subject: Re: [patch] voluntary-preempt-2.6.8-rc2-L2, preemptable hardirqs
Message-ID: <20040729180411.GA16323@elte.hu>
References: <1090830574.6936.96.camel@mindpipe> <20040726083537.GA24948@elte.hu> <1090832436.6936.105.camel@mindpipe> <20040726124059.GA14005@elte.hu> <20040726204720.GA26561@elte.hu> <20040727162759.GA32548@elte.hu> <1090968457.743.3.camel@mindpipe> <20040728050535.GA14742@elte.hu> <1091051452.791.52.camel@mindpipe> <1091063295.18598.2.camel@mindpipe>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1091063295.18598.2.camel@mindpipe>
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


* Lee Revell <rlrevell@joe-job.com> wrote:

> Here are some more results.  I am up to 56 million interrupts and I
> have yet to trigger a latency higher than 46 usecs.  It looks like
> this is a hard upper limit.

nice - what is the average (and minimum?) latency reported by jackd? 
I'd say 46 usecs on a 600 MHz box is quite close to what it takes to
handle an interrupt and schedule to the cache-cold jackd task. It should
definitely be well below the latency required for jackd to do its job
reliably.

	Ingo
