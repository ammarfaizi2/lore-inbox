Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315415AbSGOPJf>; Mon, 15 Jul 2002 11:09:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316786AbSGOPJe>; Mon, 15 Jul 2002 11:09:34 -0400
Received: from [195.223.140.120] ([195.223.140.120]:36168 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S315415AbSGOPJc>; Mon, 15 Jul 2002 11:09:32 -0400
Date: Mon, 15 Jul 2002 17:12:07 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Sam Vilain <sam@vilain.net>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, dax@gurulabs.com,
       linux-kernel@vger.kernel.org, Jeff Dike <jdike@karaya.com>
Subject: Re: [ANNOUNCE] Ext3 vs Reiserfs benchmarks
Message-ID: <20020715151207.GA7146@dualathlon.random>
References: <1026490866.5316.41.camel@thud> <1026679245.15054.9.camel@thud> <E17U1BD-0000m0-00@hofmann> <1026736251.13885.108.camel@irongate.swansea.linux.org.uk> <E17U4YE-0000TL-00@hofmann>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E17U4YE-0000TL-00@hofmann>
User-Agent: Mutt/1.3.27i
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 15, 2002 at 01:02:01PM +0100, Sam Vilain wrote:
> Hey, while I've got your attention, how do you go about debugging your
> kernel?  I'm trying to add fair scheduling to the new O(1) scheduler,
> something of a token bucket filter counting jiffies used by a
> process/user/s_context (in scheduler_tick()) and tweaking their
> priority accordingly (in effective_prio()).  It'd be really nice if I
> could run it under UML or something like that so I can trace through
> it with gdb, but I couldn't get the UML patch to apply to your tree.
> Any hints?

-aa ships with both uml and o1 scheduler. I need uml for everything non
hardware related so expect it to be always uptodate there. However since
I merged the O(1) scheduler there is the annoyance that sometime wakeup
events don't arrive at least until kupdate reschedule or something
like that (of course only with uml, not with real hardware).  Also
pressing keys is enough to unblock it. I didn't debugged it hard yet.
Accoring to Jeff it's a problem with cli that masks signals.

Andrea
