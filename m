Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286191AbRLJIUQ>; Mon, 10 Dec 2001 03:20:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286192AbRLJIUH>; Mon, 10 Dec 2001 03:20:07 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:8454 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S286191AbRLJIT5>; Mon, 10 Dec 2001 03:19:57 -0500
Subject: Re: Linux 2.4.17-pre5
To: rusty@rustcorp.com.au (Rusty Russell)
Date: Mon, 10 Dec 2001 08:28:57 +0000 (GMT)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), anton@samba.org, davej@suse.de,
        marcelo@conectiva.com.br, linux-kernel@vger.kernel.org,
        torvalds@transmeta.com
In-Reply-To: <E16DJ2T-0002Af-00@wagner> from "Rusty Russell" at Dec 10, 2001 04:31:41 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16DLo2-0001CL-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Agreed, but does the current x86 code does map them like this or not?
> If it does, I'm curious as to why they saw a problem which this fixed.

The current x86 code maps the logical cpus as with the physical ones. In
other words its how they come off the mainboard. Which for HT seems to
be with each HT as (n, n+1)

> understand what is happening.  I posted my findings, and I'd really
> like to get some feedback from others doing the same thing.

I never saw your stuff. 

> BUT I CAN'T DO THAT WHEN THERE'S NO DISCUSSION ABOUT PATCHES FROM
> ANONYMOUS SOURCES WHICH GET MERGED!  FUCK ARGHH FUCK FUCK FUCK.

A mailing list doesn't scale to that. I do have a cunning-plan (tm) but
that requires some work and while its doable for 2.2 or 2.4 I know that
making Linus do or change any tiny bit of his behaviour isn't going to
happen which rather limits the behaviour.

Think about

	mail patch to linus-patches@...

	linus-patches@ is a script that does

		find the diff
		find the paths in the diff
		regexp them against the list of notifications
			email each matching notification a copy
		
with the regexps including

	*	torvalds@transmeta.com

so its like mailing Linus but anyone who cares can web add/remove themselves
from the cc list, and its invisible to Linus too.

> BTW: Alchemy, Voodoo, Zen and Cards.  Maybe you should start hacking
> on something more deterministic? 8)

Well actually Alchemy is MIPS and nothing to do with me. Trying to turn a
Voodoo card into a video4linux overlay is, Zen is ftp.linux.org.uk and I
hack card drivers. So 3 out of 4.

Alan
