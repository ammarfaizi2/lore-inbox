Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965133AbVLVIYv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965133AbVLVIYv (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Dec 2005 03:24:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965134AbVLVIYv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Dec 2005 03:24:51 -0500
Received: from mx3.mail.elte.hu ([157.181.1.138]:22459 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S965133AbVLVIYv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Dec 2005 03:24:51 -0500
Date: Thu, 22 Dec 2005 09:24:06 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: Jes Sorensen <jes@trained-monkey.org>, Linus Torvalds <torvalds@osdl.org>,
       lkml <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       Arjan van de Ven <arjanv@infradead.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       Oleg Nesterov <oleg@tv-sign.ru>, David Howells <dhowells@redhat.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Benjamin LaHaise <bcrl@kvack.org>,
       Steven Rostedt <rostedt@goodmis.org>,
       Christoph Hellwig <hch@infradead.org>, Andi Kleen <ak@suse.de>,
       Russell King <rmk+lkml@arm.linux.org.uk>, Nicolas Pitre <nico@cam.org>
Subject: Re: [patch 0/8] mutex subsystem, ANNOUNCE
Message-ID: <20051222082406.GA32052@elte.hu>
References: <20051221155411.GA7243@elte.hu> <yq0irtiuxvv.fsf@jaguar.mkp.net> <43AA1134.7090704@yahoo.com.au> <20051222071940.GA16804@elte.hu> <43AA5C15.8060907@yahoo.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43AA5C15.8060907@yahoo.com.au>
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


* Nick Piggin <nickpiggin@yahoo.com.au> wrote:

> At the very least, the head waiter should not put itself on the end of 
> the FIFO when it finds the lock contended and waits again.

It's on my list. I had this implemented a couple of days ago, but then 
profiled it and it turns out that the scenario isnt actually happening 
in any significant way, not even on the most extreme 512-task workloads.  
So i just removed the extra bloat. But i'll look at this again today, 
together with some 'max delay' statistics.

	Ingo
