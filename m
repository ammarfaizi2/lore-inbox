Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932486AbVL1HmX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932486AbVL1HmX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Dec 2005 02:42:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932495AbVL1HmX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Dec 2005 02:42:23 -0500
Received: from mx3.mail.elte.hu ([157.181.1.138]:19400 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S932486AbVL1HmW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Dec 2005 02:42:22 -0500
Date: Wed, 28 Dec 2005 08:41:54 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Nicolas Pitre <nico@cam.org>
Cc: lkml <linux-kernel@vger.kernel.org>,
       Arjan van de Ven <arjan@infradead.org>,
       Russell King <rmk+lkml@arm.linux.org.uk>
Subject: Re: [patch 2/3] mutex subsystem: fastpath inlining
Message-ID: <20051228074154.GA4442@elte.hu>
References: <20051223161649.GA26830@elte.hu> <Pine.LNX.4.64.0512261414300.1496@localhost.localdomain> <20051227115525.GC23587@elte.hu> <Pine.LNX.4.64.0512271548030.3309@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0512271548030.3309@localhost.localdomain>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=AWL autolearn=no SpamAssassin version=3.0.3
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Nicolas Pitre <nico@cam.org> wrote:

> > * Nicolas Pitre <nico@cam.org> wrote:
> > 
> > > Some architectures, notably ARM for instance, might benefit from 
> > > inlining the mutex fast paths. [...]
> > 
> > what is the effect on text size? Could you post the before- and 
> > after-patch vmlinux 'size kernel/test.o' output in the nondebug case, 
> > with Arjan's latest 'convert a couple of semaphore users to mutexes' 
> > patch applied? [make sure you've got enough of those users compiled in, 
> > so that the inlining cost is truly measured. Perhaps also do 
> > before/after 'size' output of a few affected .o files, without mixing 
> > kernel/mutex.o into it, like vmlinux does.]
> 
> Theory should be convincing enough. [...]

please provide actual measurements (just a simple pre-patch and 
post-patch 'size' output of vmlinux is enough), so that we can see the 
inlining cost. Note that x86 went to a non-inlined fastpath _despite_ 
having a compact CISC semaphore fastpath.

	Ingo
