Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268043AbUHKMo3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268043AbUHKMo3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Aug 2004 08:44:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268045AbUHKMo3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Aug 2004 08:44:29 -0400
Received: from mx1.elte.hu ([157.181.1.137]:14226 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S268043AbUHKMo2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Aug 2004 08:44:28 -0400
Date: Wed, 11 Aug 2004 14:43:42 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Florian Schmidt <mista.tapas@gmx.net>
Cc: Lee Revell <rlrevell@joe-job.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
Subject: Re: [patch] voluntary-preempt-2.6.8-rc3-O5
Message-ID: <20040811124342.GA17017@elte.hu>
References: <20040729222657.GA10449@elte.hu> <20040801193043.GA20277@elte.hu> <20040809104649.GA13299@elte.hu> <20040810132654.GA28915@elte.hu> <1092174959.5061.6.camel@mindpipe> <20040811073149.GA4312@elte.hu> <20040811074256.GA5298@elte.hu> <1092210765.1650.3.camel@mindpipe> <20040811090639.GA8354@elte.hu> <20040811141649.447f112f@mango.fruits.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040811141649.447f112f@mango.fruits.de>
User-Agent: Mutt/1.4.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: timed out
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Florian Schmidt <mista.tapas@gmx.net> wrote:

> > i'm currently running a loop of mlockall-test 100MB on a 466 MHz
> > Celeron, and not a single blip on the radar with a 1000 usecs
> > threshold, after 1 hour of runtime ...
> 
> I suppose you're not using jackd. As i have noticed that these
> critical sections only get reported when jackd is running. It seems
> jackd is producing a certain kind of load which exposes them..

so you can only trigger the latencies via mlockall-test if jackd is also 
running? Or do the latencies only trigger in jackd (and related 
programs)?

if the later, then i'm wondering whether any of the audio code turns off
caching for specific pages or does DMA to user pages, or mmap()s device
(PCI) memory?

	Ingo
