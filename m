Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282799AbRL1RO2>; Fri, 28 Dec 2001 12:14:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284020AbRL1ROT>; Fri, 28 Dec 2001 12:14:19 -0500
Received: from hog.ctrl-c.liu.se ([130.236.252.129]:56328 "HELO
	hog.ctrl-c.liu.se") by vger.kernel.org with SMTP id <S282799AbRL1ROF>;
	Fri, 28 Dec 2001 12:14:05 -0500
To: kaos@ocs.com.au
Cc: linux-kernel@vger.kernel.org
Subject: Re: State of the new config & build system 
Newsgroups: linux.kernel
In-Reply-To: <4481.1009549017@ocs3.intra.ocs.com.au>
In-Reply-To: <E16JxmP-0000Yo-00@the-village.bc.nu>
Organization: 
Message-Id: <20011228171403.58F6636DE6@hog.ctrl-c.liu.se>
Date: Fri, 28 Dec 2001 18:14:03 +0100 (CET)
From: wingel@hog.ctrl-c.liu.se (Christer Weinigel)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <4481.1009549017@ocs3.intra.ocs.com.au> you write:
>Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:
>>Personally I've always considered make dep good enough. Its trying to solve
>>the extra .5% that probably can be solved by careful use of make clean when
>>CML realises a critical rule changed (SMP etc)
>
>http://prdownloads.sourceforge.net/kbuild/kbuild-2.5-history.tar.bz2
>Especially makefile-2.5_make_dep.html, 9 reasons why make dep is broken
>as designed.  Some are fixable in the current system, others are
>inherently unfixable.  I skipped that page when I did my presentation
>at the 2.5 developer's conference.

* make dep is only run once

Personally, I don't see this as a big problem.  Just tell people to 
always run "make oldconfig && make dep" after patching the kernel 
and if they can't read, too bad.  I usually compile a kernel a lot 
more often than I add include files.  Since I'm quite impatient
I often do "make SUBDIRS=drivers/mtd/maps modules" just so that the
compile will go faster, so having to do dependency checking each time
I want to compile feels like an unfortunate tradeoff to me.

* The generated dependencies are absolute

That dependencies are absolute is also not a thing that has bothered me 
too much, it's always possible to run "make dep" after moving a tree, 
on the other hand, I don't use NFS a lot anymore, so I can see it being 
a problem in other environments.

    /Christer
-- 
"Just how much can I get away with and still go to heaven?"
