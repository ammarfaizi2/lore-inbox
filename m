Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286909AbRL1OFz>; Fri, 28 Dec 2001 09:05:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286910AbRL1OFq>; Fri, 28 Dec 2001 09:05:46 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:35592 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S286909AbRL1OFd>; Fri, 28 Dec 2001 09:05:33 -0500
Subject: Re: State of the new config & build system
To: lm@bitmover.com (Larry McVoy)
Date: Fri, 28 Dec 2001 14:14:37 +0000 (GMT)
Cc: kaos@ocs.com.au (Keith Owens), lm@bitmover.com (Larry McVoy),
        esr@thyrsus.com (Eric S. Raymond), davej@suse.de (Dave Jones),
        esr@snark.thyrsus.com (Eric S. Raymond),
        torvalds@transmeta.com (Linus Torvalds),
        marcelo@conectiva.com.br (Marcelo Tosatti),
        linux-kernel@vger.kernel.org, kbuild-devel@lists.sourceforge.net
In-Reply-To: <20011227180148.A3727@work.bitmover.com> from "Larry McVoy" at Dec 27, 2001 06:01:48 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16JxmP-0000Yo-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Ah, OK, I get it.  Hey, would it help to have a dbm interface compat 
> library which uses mmap instead of building the db in brk() space?

mmap for db file seems to be slower. For basic db hash usage and raw speed
nothing seems to touch tdb (Tridge's db hack). Its also portable code which
is important since the tool has to be built on the compiling host.

Personally I've always considered make dep good enough. Its trying to solve
the extra .5% that probably can be solved by careful use of make clean when
CML realises a critical rule changed (SMP etc)

Alan
