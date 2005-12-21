Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964855AbVLUWls@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964855AbVLUWls (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Dec 2005 17:41:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964917AbVLUWls
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Dec 2005 17:41:48 -0500
Received: from smtp.osdl.org ([65.172.181.4]:23207 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S964855AbVLUWlq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Dec 2005 17:41:46 -0500
Date: Wed, 21 Dec 2005 14:40:57 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Ingo Molnar <mingo@elte.hu>
cc: lkml <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       Arjan van de Ven <arjanv@infradead.org>,
       Jes Sorensen <jes@trained-monkey.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       Oleg Nesterov <oleg@tv-sign.ru>, David Howells <dhowells@redhat.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Benjamin LaHaise <bcrl@kvack.org>,
       Steven Rostedt <rostedt@goodmis.org>,
       Christoph Hellwig <hch@infradead.org>, Andi Kleen <ak@suse.de>,
       Russell King <rmk+lkml@arm.linux.org.uk>, Nicolas Pitre <nico@cam.org>
Subject: Re: [patch 3/8] mutex subsystem, add atomic_*_call_if_*() to i386
In-Reply-To: <20051221194740.GA18177@elte.hu>
Message-ID: <Pine.LNX.4.64.0512211440100.4827@g5.osdl.org>
References: <20051221155442.GD7243@elte.hu> <Pine.LNX.4.64.0512211044240.4827@g5.osdl.org>
 <20051221194740.GA18177@elte.hu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 21 Dec 2005, Ingo Molnar wrote:
> 
> hm, i thought gcc treats all explicitly used register in the asm as 
> clobbered - and i'm using %%eax explicitly for that reason.

Nope, they are totally invisible to gcc afaik. It just sees "%%" and 
changes it into "%", and ignores the rest.

		Linus
