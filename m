Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932337AbVKKBNG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932337AbVKKBNG (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Nov 2005 20:13:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932338AbVKKBNG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Nov 2005 20:13:06 -0500
Received: from fed1rmmtao06.cox.net ([68.230.241.33]:57082 "EHLO
	fed1rmmtao06.cox.net") by vger.kernel.org with ESMTP
	id S932337AbVKKBNE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Nov 2005 20:13:04 -0500
Date: Thu, 10 Nov 2005 18:13:03 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Paul Mackerras <paulus@samba.org>
Cc: Andrew Morton <akpm@osdl.org>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH,RFC 2.6.14 11/15] KGDB: ppc64-specific changes
Message-ID: <20051111011303.GO3839@smtp.west.cox.net>
References: <20051110163906.20950.45704.sendpatchset@localhost.localdomain> <20051110164409.20950.43161.sendpatchset@localhost.localdomain> <17267.60410.120520.63951@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <17267.60410.120520.63951@cargo.ozlabs.ibm.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 11, 2005 at 11:55:22AM +1100, Paul Mackerras wrote:
> Tom Rini writes:
> 
> > This adds basic KGDB support to ppc64, and support for kgdb8250 on the 'Maple'
> > board.  All of this was done by Frank Rowand (who is on vacation right now,
> > but I'll try and answer for him).  This should work on any ppc64 board via
> > kgdboe, so long as there is an eth driver that supports netpoll.  At the
> > moment this is mutually exclusive with XMON.  It is probably possible to allow
> > them to be chained, but that sounds dangerous to me.  This is similar to
> > ppc32, but ppc32 does not explicitly test.
> 
> We already have infrastructure to allow either xmon or kdb to be used,
> and in fact both can be built in and you can select at runtime which
> you prefer.  See the __debugger stuff in system.h.  You should just be
> able to hook kgdb into that same infrastructure.  We're also planning
> to move to using the die_notify stuff for getting all the significant
> events to the debugger.

The notify_die stuff is wonderful.  If I had a ppc64 board, I'd give
that a whirl myself.  This does, unless there was something I missed,
tie into the existing debugger pointer stuff (thats similar but
different from ppc32).  Assuming it hasn't started already, if I can
find time I might give it a wack on arch/powerpc, since I assume my
AlBook works (if not, I see my LongTrail might ;))

-- 
Tom Rini
http://gate.crashing.org/~trini/
