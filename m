Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261355AbVAGRYS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261355AbVAGRYS (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Jan 2005 12:24:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261356AbVAGRYR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Jan 2005 12:24:17 -0500
Received: from fw.osdl.org ([65.172.181.6]:40877 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261355AbVAGRYP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Jan 2005 12:24:15 -0500
Date: Fri, 7 Jan 2005 09:23:39 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Oleg Nesterov <oleg@tv-sign.ru>,
       William Lee Irwin III <wli@holomorphy.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Make pipe data structure be a circular list of pages, rather
 than
In-Reply-To: <1105110401.17166.346.camel@localhost.localdomain>
Message-ID: <Pine.LNX.4.58.0501070910000.2272@ppc970.osdl.org>
References: <41DE9D10.B33ED5E4@tv-sign.ru> <1105110401.17166.346.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 7 Jan 2005, Alan Cox wrote:
> 
> That would break stuff, but holding the last page until it fills 4K
> would work, or just basic sg coalescing when possible. The pipe
> behaviour - particularly size and size of atomic writes is defined by
> SuS and there are people who use pipes two ways between apps and use the
> guarantees to avoid deadlocks

Hmm.. Are there really any other guarantees than the atomicity guarantee 
for a PIPE_BUF transfer? I don't see any in SuS..

That said, existing practice obviously always trumps paper standards, and 
yes, coalescing is possible.

		Linus
