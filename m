Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965138AbWH2Q5u@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965138AbWH2Q5u (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Aug 2006 12:57:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965123AbWH2Q5t
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Aug 2006 12:57:49 -0400
Received: from mx1.redhat.com ([66.187.233.31]:25000 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S965138AbWH2Q5s (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Aug 2006 12:57:48 -0400
From: David Howells <dhowells@redhat.com>
In-Reply-To: <Pine.LNX.4.64.0608290926230.18503@schroedinger.engr.sgi.com> 
References: <Pine.LNX.4.64.0608290926230.18503@schroedinger.engr.sgi.com>  <20060829162055.GA31159@linux-mips.org> <44F395DE.10804@yahoo.com.au> <a2ebde260608271222x2b51693fnaa600965fcfaa6d2@mail.gmail.com> <1156750249.3034.155.camel@laptopd505.fenrus.org> <11861.1156845927@warthog.cambridge.redhat.com> <Pine.LNX.4.64.0608290855510.18031@schroedinger.engr.sgi.com> <5878.1156868702@warthog.cambridge.redhat.com> 
To: Christoph Lameter <clameter@sgi.com>
Cc: David Howells <dhowells@redhat.com>, Ralf Baechle <ralf@linux-mips.org>,
       Nick Piggin <nickpiggin@yahoo.com.au>,
       Arjan van de Ven <arjan@infradead.org>,
       Dong Feng <middle.fengdong@gmail.com>, ak@suse.de,
       Paul Mackerras <paulus@samba.org>, linux-kernel@vger.kernel.org,
       linux-arch@vger.kernel.org
Subject: Re: Why Semaphore Hardware-Dependent? 
X-Mailer: MH-E 8.0; nmh 1.1; GNU Emacs 22.0.50
Date: Tue, 29 Aug 2006 17:57:36 +0100
Message-ID: <21013.1156870656@warthog.cambridge.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Lameter <clameter@sgi.com> wrote:

> > Some of these have LL/SC or equivalent instead, but ARM5 and before, FRV,
> > M68K before 68020 to name but a few.
> 
> This is all pretty ancient hardware, right? And they are mostly single 
> processor so no need to worry about concurrency. Just disable interrupts.

No, they're not all ancient h/w, and "just disabling interrupts" can be really
expensive.

> > And anything that implements CMPXCHG with spinlocks is a really bad
> > candidate for CMPXCHG-based rwsems.
> 
> Those will optimize out if it is a single processor configuration.

Not necessarily.  Consider preemption.

David
