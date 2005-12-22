Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965128AbVLVIVZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965128AbVLVIVZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Dec 2005 03:21:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965129AbVLVIVZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Dec 2005 03:21:25 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:713 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S965128AbVLVIVY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Dec 2005 03:21:24 -0500
Subject: Re: [patch 0/8] mutex subsystem, ANNOUNCE
From: Arjan van de Ven <arjan@infradead.org>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: Ingo Molnar <mingo@elte.hu>, Jes Sorensen <jes@trained-monkey.org>,
       Linus Torvalds <torvalds@osdl.org>, lkml <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Arjan van de Ven <arjanv@infradead.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       Oleg Nesterov <oleg@tv-sign.ru>, David Howells <dhowells@redhat.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Benjamin LaHaise <bcrl@kvack.org>,
       Steven Rostedt <rostedt@goodmis.org>,
       Christoph Hellwig <hch@infradead.org>, Andi Kleen <ak@suse.de>,
       Russell King <rmk+lkml@arm.linux.org.uk>, Nicolas Pitre <nico@cam.org>
In-Reply-To: <43AA5F7B.7010407@yahoo.com.au>
References: <20051221155411.GA7243@elte.hu> <yq0irtiuxvv.fsf@jaguar.mkp.net>
	 <43AA1134.7090704@yahoo.com.au> <20051222071940.GA16804@elte.hu>
	 <43AA5C15.8060907@yahoo.com.au>
	 <1135238423.2940.1.camel@laptopd505.fenrus.org>
	 <43AA5F7B.7010407@yahoo.com.au>
Content-Type: text/plain
Date: Thu, 22 Dec 2005 09:21:11 +0100
Message-Id: <1135239672.2940.7.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-Spam-Score: -2.8 (--)
X-Spam-Report: SpamAssassin version 3.0.4 on pentafluge.infradead.org summary:
	Content analysis details:   (-2.8 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	-2.8 ALL_TRUSTED            Did not pass through any untrusted hosts
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> I'd probably just call "bastard": it is probably _unlucky_ when _doesn't_
> get to retake the lock, judging by the factor-of-4 speedup that Jes
> demonstrated.

I suspect that's more avoiding the double wakeup that semaphores have
(semaphores aren't quite fair either)

> 
> Which might be the right thing to do, but having the front waiter go to
> the back of the queue I think is not.

afaik that isn't happening though.


