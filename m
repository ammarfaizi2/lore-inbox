Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261623AbVBKRzb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261623AbVBKRzb (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Feb 2005 12:55:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262157AbVBKRwN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Feb 2005 12:52:13 -0500
Received: from mx1.elte.hu ([157.181.1.137]:408 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S262244AbVBKRtW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Feb 2005 12:49:22 -0500
Date: Fri, 11 Feb 2005 18:49:05 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Matt Mackall <mpm@selenic.com>
Cc: Chris Wright <chrisw@osdl.org>, "Jack O'Quin" <jack.oquin@gmail.com>,
       Andrew Morton <akpm@osdl.org>, Christoph Hellwig <hch@infradead.org>,
       linux-kernel@vger.kernel.org, Paul Davis <paul@linuxaudiosystems.com>,
       Con Kolivas <kernel@kolivas.org>, rlrevell@joe-job.com
Subject: Re: 2.6.11-rc3-mm2
Message-ID: <20050211174905.GC17387@elte.hu>
References: <a075431a050210125145d51e8c@mail.gmail.com> <20050211000425.GC2474@waste.org> <20050210164727.M24171@build.pdx.osdl.net> <20050211020956.GC15058@waste.org> <20050211081422.GB2287@elte.hu> <20050211084107.GG15058@waste.org> <20050211085942.GB3980@elte.hu> <20050211094021.GJ15058@waste.org> <20050211095327.GB6229@elte.hu> <20050211173751.GK15058@waste.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050211173751.GK15058@waste.org>
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


* Matt Mackall <mpm@selenic.com> wrote:

> > > Yes. There's also the whole soft limit thing.
> > 
> > i'm curious, how does this 'per-app' rlimit thing work? If a user has
> > jackd installed and runs it from X unprivileged, how does it get the
> > elevated rlimit?
> 
> It needs a setuid launcher. It would be nice to be able to elevate the
> rlimits of running processes but the API doesn't exist yet.

With a setuid launcher you need _zero_ kernel help to get SCHED_FIFO: if
you have a launcher then already today it can just give SCHED_FIFO to
jackd and be done with it!

	Ingo
