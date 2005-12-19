Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964965AbVLSU61@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964965AbVLSU61 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Dec 2005 15:58:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964967AbVLSU61
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Dec 2005 15:58:27 -0500
Received: from mx3.mail.elte.hu ([157.181.1.138]:31112 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S964965AbVLSU60 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Dec 2005 15:58:26 -0500
Date: Mon, 19 Dec 2005 21:57:41 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Benjamin LaHaise <bcrl@kvack.org>, Linus Torvalds <torvalds@osdl.org>,
       Andi Kleen <ak@suse.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Arjan van de Ven <arjanv@infradead.org>,
       Steven Rostedt <rostedt@goodmis.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Christoph Hellwig <hch@infradead.org>,
       David Howells <dhowells@redhat.com>,
       Alexander Viro <viro@ftp.linux.org.uk>, Oleg Nesterov <oleg@tv-sign.ru>
Subject: Re: [patch 00/15] Generic Mutex Subsystem
Message-ID: <20051219205741.GA24004@elte.hu>
References: <20051219013415.GA27658@elte.hu> <20051219042248.GG23384@wotan.suse.de> <Pine.LNX.4.64.0512182214400.4827@g5.osdl.org> <20051219155010.GA7790@elte.hu> <Pine.LNX.4.64.0512191053400.4827@g5.osdl.org> <20051219192537.GC15277@kvack.org> <20051219201118.GA22198@elte.hu> <20051219203206.GC20824@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051219203206.GC20824@flint.arm.linux.org.uk>
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


* Russell King <rmk+lkml@arm.linux.org.uk> wrote:

> However, the argument _against_ making things generic is that they 
> become less optimised for specific architectures.  I'm still not 
> convinced that the genirq stuff is as optimal for ARM as the existing 
> code is, so I've little motivation to move to the genirq stuff. 
> (Though I will try to make things easier for those who would like to.)

i'm quite convinced that the final phase of the genirq conversion will 
work out fine: because it mostly meant the conceptual adoption of your 
ARM IRQ layer (the irqchips approach), with compatibility mechanisms for 
all the other arches, with some minor SMP improvements ontop of it. So 
i'd be surprised if you found _that_ one inadequate :-) If there's any 
detail that ARM doesnt need, i'm sure we can find a non-runtime solution 
for it. But i think i digress.

	Ingo
