Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262919AbUCRU2E (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Mar 2004 15:28:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262922AbUCRU2E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Mar 2004 15:28:04 -0500
Received: from mx1.elte.hu ([157.181.1.137]:12180 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S262919AbUCRU2A (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Mar 2004 15:28:00 -0500
Date: Thu, 18 Mar 2004 21:28:56 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Andrea Arcangeli <andrea@suse.de>
Cc: Andrew Morton <akpm@osdl.org>, torvalds@osdl.org, hch@infradead.org,
       drepper@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: sched_setaffinity usability
Message-ID: <20040318202856.GA10437@elte.hu>
References: <40595842.5070708@redhat.com> <20040318112913.GA13981@elte.hu> <20040318120709.A27841@infradead.org> <Pine.LNX.4.58.0403180748070.24088@ppc970.osdl.org> <20040318182407.GA1287@elte.hu> <20040318103352.1a65126a.akpm@osdl.org> <20040318183944.GA3710@elte.hu> <20040318200111.GA16743@dualathlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040318200111.GA16743@dualathlon.random>
User-Agent: Mutt/1.4.1i
X-ELTE-SpamVersion: MailScanner 4.26.8-itk2 (ELTE 1.1) SpamAssassin 2.63 ClamAV 0.65
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Andrea Arcangeli <andrea@suse.de> wrote:

> > architecture that wants to accelerate syscalls in user-space (and/or
> 
> x86-64 is the first arch ever implementing vsyscalls in production
> with the fastest possible API.
> 
> The API doesn't contemplate the idea of relocating the vsyscall
> address, but it can be extended easily with a relocation API.

you'd end up doing much like what a DSO does. Anyway, what you say does
not conflict with the idea of the VDSO at all. It's only that x86 has
the most complex needs in this area so it was the first to do a real
DSO.

	Ingo
