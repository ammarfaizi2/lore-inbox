Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030336AbVLVVxh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030336AbVLVVxh (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Dec 2005 16:53:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030333AbVLVVxh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Dec 2005 16:53:37 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:59557 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1030329AbVLVVxf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Dec 2005 16:53:35 -0500
Date: Thu, 22 Dec 2005 21:53:31 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Nicolas Pitre <nico@cam.org>
Cc: Ingo Molnar <mingo@elte.hu>, Christoph Hellwig <hch@infradead.org>,
       lkml <linux-kernel@vger.kernel.org>, Linus Torvalds <torvalds@osdl.org>,
       Andrew Morton <akpm@osdl.org>, Arjan van de Ven <arjanv@infradead.org>,
       Jes Sorensen <jes@trained-monkey.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       Oleg Nesterov <oleg@tv-sign.ru>, David Howells <dhowells@redhat.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Benjamin LaHaise <bcrl@kvack.org>,
       Steven Rostedt <rostedt@goodmis.org>, Andi Kleen <ak@suse.de>
Subject: Re: [patch 1/2] mutex subsystem: basic per arch fast path primitives
Message-ID: <20051222215331.GA11707@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Nicolas Pitre <nico@cam.org>, Ingo Molnar <mingo@elte.hu>,
	lkml <linux-kernel@vger.kernel.org>,
	Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
	Arjan van de Ven <arjanv@infradead.org>,
	Jes Sorensen <jes@trained-monkey.org>,
	Zwane Mwaikambo <zwane@arm.linux.org.uk>,
	Oleg Nesterov <oleg@tv-sign.ru>,
	David Howells <dhowells@redhat.com>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Benjamin LaHaise <bcrl@kvack.org>,
	Steven Rostedt <rostedt@goodmis.org>, Andi Kleen <ak@suse.de>
References: <20051222114147.GA18878@elte.hu> <20051222115329.GA30964@infradead.org> <Pine.LNX.4.64.0512221025070.26663@localhost.localdomain> <20051222154012.GA6284@elte.hu> <Pine.LNX.4.64.0512221113560.26663@localhost.localdomain> <20051222164415.GA10628@elte.hu> <20051222165828.GA5268@flint.arm.linux.org.uk> <20051222210446.GA16092@elte.hu> <Pine.LNX.4.64.0512221613010.26663@localhost.localdomain> <Pine.LNX.4.64.0512221630430.26663@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0512221630430.26663@localhost.localdomain>
User-Agent: Mutt/1.4.2.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> OK, let's look at actual code please.  Do you have anything against this 
> and the following patches?
> 
> This patch adds fast path mutex primitives for all architectures.  It 
> replaces your atomic_*_call_if_* patches that didn't seem to please 
> everybody, mutex usage notwithstanding.

Thanks Nico, this is exactly what I wanted to see.

One question about the naming of the arch helpers, do we really need the
fastpath in there?  Or just __mutex_* ?

