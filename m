Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286918AbRL1OR2>; Fri, 28 Dec 2001 09:17:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286917AbRL1ORS>; Fri, 28 Dec 2001 09:17:18 -0500
Received: from mail.ocs.com.au ([203.34.97.2]:8461 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S286918AbRL1ORN>;
	Fri, 28 Dec 2001 09:17:13 -0500
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: lm@bitmover.com (Larry McVoy), esr@thyrsus.com (Eric S. Raymond),
        davej@suse.de (Dave Jones), esr@snark.thyrsus.com (Eric S. Raymond),
        torvalds@transmeta.com (Linus Torvalds),
        marcelo@conectiva.com.br (Marcelo Tosatti),
        linux-kernel@vger.kernel.org, kbuild-devel@lists.sourceforge.net
Subject: Re: State of the new config & build system 
In-Reply-To: Your message of "Fri, 28 Dec 2001 14:14:37 -0000."
             <E16JxmP-0000Yo-00@the-village.bc.nu> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sat, 29 Dec 2001 01:16:57 +1100
Message-ID: <4481.1009549017@ocs3.intra.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 28 Dec 2001 14:14:37 +0000 (GMT), 
Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:
>> Ah, OK, I get it.  Hey, would it help to have a dbm interface compat 
>> library which uses mmap instead of building the db in brk() space?
>
>mmap for db file seems to be slower. For basic db hash usage and raw speed
>nothing seems to touch tdb (Tridge's db hack). Its also portable code which
>is important since the tool has to be built on the compiling host.

lm sent me the bk mdbm code but I will look at tdb as well.  Four
acronyms in one sentance, I must be a phb :).

>Personally I've always considered make dep good enough. Its trying to solve
>the extra .5% that probably can be solved by careful use of make clean when
>CML realises a critical rule changed (SMP etc)

http://prdownloads.sourceforge.net/kbuild/kbuild-2.5-history.tar.bz2
Especially makefile-2.5_make_dep.html, 9 reasons why make dep is broken
as designed.  Some are fixable in the current system, others are
inherently unfixable.  I skipped that page when I did my presentation
at the 2.5 developer's conference.

