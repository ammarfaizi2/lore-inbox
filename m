Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262871AbUCRSlp (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Mar 2004 13:41:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262864AbUCRSku
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Mar 2004 13:40:50 -0500
Received: from mx1.elte.hu ([157.181.1.137]:18402 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S262871AbUCRSiv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Mar 2004 13:38:51 -0500
Date: Thu, 18 Mar 2004 19:39:44 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Andrew Morton <akpm@osdl.org>
Cc: torvalds@osdl.org, hch@infradead.org, drepper@redhat.com,
       linux-kernel@vger.kernel.org
Subject: Re: sched_setaffinity usability
Message-ID: <20040318183944.GA3710@elte.hu>
References: <40595842.5070708@redhat.com> <20040318112913.GA13981@elte.hu> <20040318120709.A27841@infradead.org> <Pine.LNX.4.58.0403180748070.24088@ppc970.osdl.org> <20040318182407.GA1287@elte.hu> <20040318103352.1a65126a.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040318103352.1a65126a.akpm@osdl.org>
User-Agent: Mutt/1.4.1i
X-ELTE-SpamVersion: MailScanner 4.26.8-itk2 (ELTE 1.1) SpamAssassin 2.63 ClamAV 0.65
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-3.229, required 5.9,
	BAYES_00 -4.90, NO_COST 1.67
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -3
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Andrew Morton <akpm@osdl.org> wrote:

> >  Right now the VDSO mostly contains code and exception-handling data, but
> >  it could contain real, userspace-visible data just as much: info that is
> >  only known during the kernel build. There's basically no cost in adding
> >  more fields to the VDSO, and it seems to be superior to any of the other
> >  approaches. Is there any reason not to do it?
> 
> It's x86-specific?

x86-64 has a VDSO page as well, and it can be implemented on any
architecture that wants to accelerate syscalls in user-space (and/or
wants to provide alternate methods of system-entry).

and a non-existent VDSO is something glibc handles already.

	Ingo
