Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751190AbVLUUyq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751190AbVLUUyq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Dec 2005 15:54:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751193AbVLUUyq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Dec 2005 15:54:46 -0500
Received: from relais.videotron.ca ([24.201.245.36]:25320 "EHLO
	relais.videotron.ca") by vger.kernel.org with ESMTP
	id S1751190AbVLUUyp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Dec 2005 15:54:45 -0500
Date: Wed, 21 Dec 2005 15:54:13 -0500 (EST)
From: Nicolas Pitre <nico@cam.org>
Subject: Re: [patch 3/8] mutex subsystem, add atomic_*_call_if_*() to i386
In-reply-to: <20051221203243.GA19082@nevyn.them.org>
X-X-Sender: nico@localhost.localdomain
To: Daniel Jacobowitz <dan@debian.org>
Cc: Linus Torvalds <torvalds@osdl.org>, Ingo Molnar <mingo@elte.hu>,
       lkml <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       Arjan van de Ven <arjanv@infradead.org>,
       Jes Sorensen <jes@trained-monkey.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       Oleg Nesterov <oleg@tv-sign.ru>, David Howells <dhowells@redhat.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Benjamin LaHaise <bcrl@kvack.org>,
       Steven Rostedt <rostedt@goodmis.org>,
       Christoph Hellwig <hch@infradead.org>, Andi Kleen <ak@suse.de>,
       Russell King <rmk+lkml@arm.linux.org.uk>
Message-id: <Pine.LNX.4.64.0512211552080.26663@localhost.localdomain>
MIME-version: 1.0
Content-type: TEXT/PLAIN; charset=US-ASCII
Content-transfer-encoding: 7BIT
References: <20051221155442.GD7243@elte.hu>
 <Pine.LNX.4.64.0512211044240.4827@g5.osdl.org>
 <Pine.LNX.4.64.0512211054450.4827@g5.osdl.org>
 <20051221203243.GA19082@nevyn.them.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 21 Dec 2005, Daniel Jacobowitz wrote:

> This new macro is only going to be used in x86-specific files, right? 
> There's no practical way to implement this on lots of other
> architectures.

The default implementation does the call in C.

> Embedding a call in asm("") can break other things too - for instance,
> unwind tables could become inaccurate.

I doubt unwind tables are used at all for the kernel, are they?


Nicolas
