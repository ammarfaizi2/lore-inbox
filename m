Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261761AbVDKKWp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261761AbVDKKWp (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Apr 2005 06:22:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261764AbVDKKUX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Apr 2005 06:20:23 -0400
Received: from w241.dkm.cz ([62.24.88.241]:34794 "HELO machine.sinus.cz")
	by vger.kernel.org with SMTP id S261761AbVDKKQM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Apr 2005 06:16:12 -0400
Date: Mon, 11 Apr 2005 12:16:11 +0200
From: Petr Baudis <pasky@ucw.cz>
To: Ingo Molnar <mingo@elte.hu>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>, "Randy.Dunlap" <rddunlap@osdl.org>,
       Ross Vandegrift <ross@jose.lug.udel.edu>
Subject: Re: Re: [ANNOUNCE] git-pasky-0.2
Message-ID: <20050411101611.GA25538@pasky.ji.cz>
References: <Pine.LNX.4.58.0504091208470.6947@ppc970.osdl.org> <20050409200709.GC3451@pasky.ji.cz> <Pine.LNX.4.58.0504091320490.1267@ppc970.osdl.org> <Pine.LNX.4.58.0504091404350.1267@ppc970.osdl.org> <Pine.LNX.4.58.0504091617000.1267@ppc970.osdl.org> <20050410024157.GE3451@pasky.ji.cz> <20050410162723.GC26537@pasky.ji.cz> <20050411015852.GI5902@pasky.ji.cz> <20050411085051.GA8893@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050411085051.GA8893@elte.hu>
User-Agent: Mutt/1.4i
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dear diary, on Mon, Apr 11, 2005 at 10:50:51AM CEST, I got a letter
where Ingo Molnar <mingo@elte.hu> told me that...
> 
> * Petr Baudis <pasky@ucw.cz> wrote:
> 
> >   Hello,
> > 
> >   here goes git-pasky-0.2, my set of patches and scripts upon Linus' 
> > git, aimed at human usability and to an extent a SCM-like usage.
> 
> works fine on FC4, i only minor issues: 'git' in the tarball didnt have 
> the x permission.

Sorry, fixed in the tarball. It is in the diffs but I have no git patch
yet to apply the mode changes.

> Also, your scripts assume they are in $PATH.  When 
> trying out a tarball one doesnt usually do a 'make install' but tries
> stuff locally.

Hmm, I think I will need to make something like

	exedir=$(dirname $0)

on the top of each script and then do all the git calls with ${exedit}
prepended. That should fix the issue, right?

> Also, 'make install' doesnt seem to install the git script itself, is
> that intentional?

Oops, I actually didn't even notice that there _is_ any install target
in the Makefile already. ;-) I will add the relevant stuff to it.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
98% of the time I am right. Why worry about the other 3%.
