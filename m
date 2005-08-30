Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932430AbVH3Txn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932430AbVH3Txn (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Aug 2005 15:53:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932431AbVH3Txn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Aug 2005 15:53:43 -0400
Received: from fed1rmmtao04.cox.net ([68.230.241.35]:55286 "EHLO
	fed1rmmtao04.cox.net") by vger.kernel.org with ESMTP
	id S932430AbVH3Txm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Aug 2005 15:53:42 -0400
Date: Tue, 30 Aug 2005 12:53:41 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: George Anzinger <george@mvista.com>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [patch 1/3] x86_64: Add a notify_die() call to the "no context" part of do_page_fault()
Message-ID: <20050830195341.GE3966@smtp.west.cox.net>
References: <resend.1.2982005.trini@kernel.crashing.org> <43140BC5.1090804@mvista.com> <20050830140603.GB3966@smtp.west.cox.net> <43147237.5030108@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43147237.5030108@mvista.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 30, 2005 at 07:50:31AM -0700, George Anzinger wrote:
> Tom Rini wrote:
[snip]
> >"no context" is the label we're in, in the code.  What it's actually
> >used for is "hey, we (== kgdb) tried to read/write a very very bogus
> >addr, time to longjmp".  If it's not true that kgdb is at fault then we
> >drop to the debugger anyhow, and the user can see where they came from.
> >
> No.  What the user sees is the offending code (i.e. prior to the trap to 
> page_fault), NOT how kgdb happend to be called.  The "no_context" is IN 
> the _context_ of page_fault, but that is lost by the time you get to 
> kgdb and ask to see _why_ (via, hint, hint: "p kgdb_info").

So you're suggesting changing what we pass in so that if we also modify
kgdb_info to contain the 'where' thing you talked about before, it would
be more useful, yes?  If so, I think that can wait just a bit. :)

-- 
Tom Rini
http://gate.crashing.org/~trini/
