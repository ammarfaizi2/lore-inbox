Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932150AbVLLUIV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932150AbVLLUIV (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Dec 2005 15:08:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932197AbVLLUIV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Dec 2005 15:08:21 -0500
Received: from w241.dkm.cz ([62.24.88.241]:14048 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S932150AbVLLUIU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Dec 2005 15:08:20 -0500
Date: Mon, 12 Dec 2005 21:08:17 +0100
From: Petr Baudis <pasky@ucw.cz>
To: Sam Ravnborg <sam@ravnborg.org>
Cc: zippel@linux-m68k.org, linux-kernel@vger.kernel.org,
       kbuild-devel@lists.sourceforge.net
Subject: Re: [PATCH 0/3] Link lxdialog with mconf directly
Message-ID: <20051212200817.GM10680@pasky.or.cz>
References: <20051212004159.31263.89669.stgit@machine.or.cz> <20051212191422.GB7694@mars.ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051212191422.GB7694@mars.ravnborg.org>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dear diary, on Mon, Dec 12, 2005 at 08:14:22PM CET, I got a letter
where Sam Ravnborg <sam@ravnborg.org> said that...
> On Mon, Dec 12, 2005 at 01:41:59AM +0100, Petr Baudis wrote:
> >   The following series revives one three years old patch, turning lxdialog
> > to a library and linking it directly to mconf, making menuconfig nicer and
> > things in general quite simpler and cleaner.
> > 
> >   The first two patches make slight adjustements to kbuild in order to make
> > liblxdialog possible. The third patch does the libification itself and
> > appropriate modifications to mconf.c.
> 
> Why not just copy over relevant files to scripts/kconfig?
> Then no playing tricks with libaries etc. is needed, and everythings
> just works.
> 
> It is only 8 files and prefixing them with lx* would make them
> stand out compared to the rest. It is not like there is any user planned
> for the lxdialog functionality in the kernel, and kconfig users outside
> the kernel I beleive copy lxdialog with rest of kconfig files.

Ok. I didn't want to pollute scripts/kconfig/ too much, but if it's ok
by you, I can do it that way. I will submit another series later in the
evening.

> Btw. the work you are doing are clashing with a general cleanup effort
> of lxdialog I have in -mm at the moment.
> I received only very limited feedback = looks ok.
> Integrating principles from your old patch was on my TODO list.

Do you mean the series you posted at Nov 21? Should I just rebase my
patches on top of that?

FWIW, the changes there look fine to me. I actually wanted to change the
indentation of the menus as well; it looks horrible especially in the
singlemenu mode.

> I have something in the works that uses linked list instead of a
> preallocated array, to keep the dynamic behaviour. I will probarly make
> a version with the linked list approach but otherwise use your changes
> to mconf.c. But it will take a few days until I get to it.

I can do it and include it in the updated series.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
VI has two modes: the one in which it beeps and the one in which
it doesn't.
