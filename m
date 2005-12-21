Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932493AbVLUTs3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932493AbVLUTs3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Dec 2005 14:48:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932494AbVLUTs3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Dec 2005 14:48:29 -0500
Received: from mx3.mail.elte.hu ([157.181.1.138]:63944 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S932493AbVLUTs3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Dec 2005 14:48:29 -0500
Date: Wed, 21 Dec 2005 20:47:40 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Linus Torvalds <torvalds@osdl.org>
Cc: lkml <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       Arjan van de Ven <arjanv@infradead.org>,
       Jes Sorensen <jes@trained-monkey.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       Oleg Nesterov <oleg@tv-sign.ru>, David Howells <dhowells@redhat.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Benjamin LaHaise <bcrl@kvack.org>,
       Steven Rostedt <rostedt@goodmis.org>,
       Christoph Hellwig <hch@infradead.org>, Andi Kleen <ak@suse.de>,
       Russell King <rmk+lkml@arm.linux.org.uk>, Nicolas Pitre <nico@cam.org>
Subject: Re: [patch 3/8] mutex subsystem, add atomic_*_call_if_*() to i386
Message-ID: <20051221194740.GA18177@elte.hu>
References: <20051221155442.GD7243@elte.hu> <Pine.LNX.4.64.0512211044240.4827@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0512211044240.4827@g5.osdl.org>
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


* Linus Torvalds <torvalds@osdl.org> wrote:

> 
> On Wed, 21 Dec 2005, Ingo Molnar wrote:
> >
> > add two new atomic ops to i386: atomic_dec_call_if_negative() and
> > atomic_inc_call_if_nonpositive(), which are conditional-call-if
> > atomic operations. Needed by the new mutex code.
> 
> Umm. This asm is broken. It doesn't mark %eax as changed, [...]

hm, i thought gcc treats all explicitly used register in the asm as 
clobbered - and i'm using %%eax explicitly for that reason. Or is that 
only the case if that's an input/output register as well?

	Ingo
