Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262243AbTJGL2Q (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Oct 2003 07:28:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262251AbTJGL2O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Oct 2003 07:28:14 -0400
Received: from astound-64-85-224-253.ca.astound.net ([64.85.224.253]:61202
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id S262243AbTJGL2J (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Oct 2003 07:28:09 -0400
Date: Tue, 7 Oct 2003 04:25:29 -0700 (PDT)
From: Andre Hedrick <andre@linux-ide.org>
To: Roman Zippel <zippel@linux-m68k.org>
cc: David Woodhouse <dwmw2@infradead.org>, Larry McVoy <lm@bitmover.com>,
       Pascal Schmidt <der.eremit@email.de>, linux-kernel@vger.kernel.org
Subject: Re: freed_symbols [Re: People, not GPL [was: Re: Driver Model]]
In-Reply-To: <Pine.LNX.4.44.0310071240530.17548-100000@serv>
Message-ID: <Pine.LNX.4.10.10310070412500.2266-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


"EXPORT_SYMBOL_GPL" is a license enforcement tool, period.

Any driver using a caller wrappered by "EXPORT_SYMBOL_GPL" will have the
function fail quietly and restrict functionality.  Restricting
functionality is a means to disable drivers period.  These very same
functions in question are required for any other driver to operate.

That makes them part of the API for operational compatibility.
The API is described exclusively by the snapshot version of a given
kernel.

So under copyright case law, where GPL has never been, there are rulings
and history describing what an API is, how it can not be protected, and
determinations of fair use based on legal rulings.

Now if one is forced to disable EXPORT_SYMBOL_GPL and redistribute the
modified kernel source as a single object, there is nothing anybody can do
to stop that process.

A simple solution is to publish an EXPORT_SYMBOL shim so one would not
be subject to the issues of distribution clauses.  The SHIM is
GPL-compatable and it provides clear exports of the API snapshot.

Separtion of the logical .c shim module driver and the decoupled .h is
making the boundary clear.

However this is a was of time because neither you (best guess) and the
majority here have ever paid to have the license explained and how it is
subject to actual copyright laws.  In the past I was one of the folks
shouting opinions not facts.  The facts are rude eye openers.

Well David Miller is going to stomp the thread so lets do it for him?

Cheers,


Andre Hedrick
LAD Storage Consulting Group

On Tue, 7 Oct 2003, Roman Zippel wrote:

> Hi,
> 
> On Tue, 7 Oct 2003, Andre Hedrick wrote:
> 
> > You got my point exactly, keep the issue of license to GPL and not muddy
> > the waters with a license other than GPL as an example.
> 
> Fine, but you didn't answer my questions at all and you're the one 
> complaining about EXPORT_SYMBOL_GPL in first place, so here are the 
> questions again, in case you deleted the original mail already:
> 
> Could you please explain about what "added restrictions" you're talking 
> about? Let's actually look at the GPL, which states "You may not impose 
> any further restrictions on the recipients' exercise of the rights granted 
> herein.", a bit earlier we find "Activities other than copying, 
> distribution and modification are not covered by this License".
> So how exactly does EXPORT_SYMBOL_GPL restrict you in these activities?
> 
> bye, Roman
> 

