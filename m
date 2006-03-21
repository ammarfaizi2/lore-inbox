Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751377AbWCURnX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751377AbWCURnX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Mar 2006 12:43:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751458AbWCURnX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Mar 2006 12:43:23 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:27544 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1751377AbWCURnW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Mar 2006 12:43:22 -0500
Subject: Re: [PATCH 000/141] V4L/DVB updates part 1
From: Mauro Carvalho Chehab <mchehab@infradead.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: linux-kernel@vger.kernel.org, linux-dvb-maintainer@linuxtv.org,
       video4linux-list@redhat.com, akpm@osdl.org
In-Reply-To: <Pine.LNX.4.64.0603210748340.3622@g5.osdl.org>
References: <20060320150819.PS760228000000@infradead.org>
	 <Pine.LNX.4.64.0603210741120.3622@g5.osdl.org>
	 <Pine.LNX.4.64.0603210748340.3622@g5.osdl.org>
Content-Type: text/plain; charset=ISO-8859-1
Date: Tue, 21 Mar 2006 14:43:15 -0300
Message-Id: <1142962995.4749.39.camel@praia>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.2.1-3mdk 
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <mchehab@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Em Ter, 2006-03-21 às 08:26 -0800, Linus Torvalds escreveu:
> > In particular, commit e338b736f1aee59b757130ffdc778538b7db18d6 is crap, 
> > crap, CRAP.
Sorry for the troubles. I didn't noticed anything here indicating
troubles, otherwise I would never asked you to pull it.

> Looking closer, the commit after that is a _real_ merge, and it looks like 
> you did something strange when that at first conflicted in saa7134-dvb.c 
> or something. I just don't even see _how_ you created that bogus non-merge 
> commit. Are you using cogito? It has some problems with conflict 
> resolution, I think. Real git should not even have allowed you to commit 
> something that hadn't been resolved.

I'm using stgit. It allows me to export the patches from V4L/DVB
Mercurial tree, removing backward compatible code and correcting the
patches. Is it broken?

Maybe I'm using a bad procedure to keep my -git tree.

My current procedure is:
branch origin - Your tree replica
branch work - my stgit main tree
branch work-fixes - my stgit tree for bug fixes
branch master - patches to current kernel
branch devel - patches to next kernel

All patches are generated against work branch, with stgit.
Branch work-fixes receives patches by using:

	stg pick <sha>@work

Before commiting to kernel.org, I do:
at origin:
	git pull linus_tree

at master:
	git pull . origin
	git pull . work-fixes

at devel:
	git pull . origin
	git pull . work

> 
> Anyway, if you want to fix this up without re-doing _everything_, the way 
> to do so is to just start a new branch, and cherry-pick the non-crap 
> commits. So you can fix it up, largely automatedly, with git.
> 
> I'm actually trying to do that right now, to see if I can re-create your 
> tree without the errors.
I'll retrieve from your tree and I'll do a double check if something
were misapplied.

> 
> 		Linus
Cheers, 
Mauro.

