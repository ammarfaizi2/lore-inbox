Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265222AbUF1VtY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265222AbUF1VtY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Jun 2004 17:49:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265229AbUF1VtY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Jun 2004 17:49:24 -0400
Received: from fw.osdl.org ([65.172.181.6]:40091 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265222AbUF1VtW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Jun 2004 17:49:22 -0400
Date: Mon, 28 Jun 2004 14:49:18 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Andrew Morton <akpm@osdl.org>
cc: Davide Libenzi <davidel@xmailserver.org>, linux-kernel@vger.kernel.org
Subject: Re: [patch] signal handler defaulting fix ...
In-Reply-To: <20040628144003.40c151ff.akpm@osdl.org>
Message-ID: <Pine.LNX.4.58.0406281446460.28764@ppc970.osdl.org>
References: <Pine.LNX.4.58.0406281430470.18879@bigblue.dev.mdolabs.com>
 <20040628144003.40c151ff.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 28 Jun 2004, Andrew Morton wrote:
>
> Davide Libenzi <davidel@xmailserver.org> wrote:
> >
> > 
> > Following up from the other thread (2.6.x signal handler bug) this bring 
> > 2.4 behaviour in 2.6.
> > 
> 
> Pity the poor person who tries to understand this change in a year's time. 
> Could we have a real changelog please?

Also, do we really care? The 2.6.x behaviour is nicer in that it tends to
kill programs more abruptly, while 2.4.x will just let a blocked signal
through - possibly letting the program continue, but causing "impossible"  
bugs in user space.

I don't think we've had any complaints about the 2.6.x behaviour apart
from the initial discussion a few months ago. I'd much rather have a
debuggable "kill a program that tries to block a synchronous interrupt",
than a potentially totally un-debuggable "let the signal through".

		Linus
