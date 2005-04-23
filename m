Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261986AbVDWVeO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261986AbVDWVeO (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Apr 2005 17:34:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262044AbVDWVeO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Apr 2005 17:34:14 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:7809 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S261986AbVDWVeG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Apr 2005 17:34:06 -0400
Date: Sat, 23 Apr 2005 23:31:43 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Petr Baudis <pasky@ucw.cz>
Cc: Linus Torvalds <torvalds@osdl.org>,
       kernel list <linux-kernel@vger.kernel.org>, git@vger.kernel.org
Subject: Re: Linux 2.6.12-rc3
Message-ID: <20050423213143.GA4978@elf.ucw.cz>
References: <Pine.LNX.4.58.0504201728110.2344@ppc970.osdl.org> <20050421112022.GB2160@elf.ucw.cz> <20050421120327.GA13834@elf.ucw.cz> <20050421162220.GD30991@pasky.ji.cz> <20050421190009.GC475@openzaurus.ucw.cz> <20050421190956.GA7443@pasky.ji.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050421190956.GA7443@pasky.ji.cz>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > > Well, not sure.
> > > > 
> > > > I did 
> > > > 
> > > > git track linus
> > > > git cancel
> > > > 
> > > > but Makefile still contains -rc2. (Is "git cancel" right way to check
> > > > out the tree?)
> > > 
> > > No. git cancel does what it says - cancels your local changes to the
> > > working tree. git track will only set that next time you pull from
> > > linus, the changes will be automatically merged. (Note that this will
> > > change with the big UI change.)
> > 
> > Is there way to say "forget those changes in my repository, I want
> > just plain vanilla" without rm -rf?
> 
> git cancel will give you "plain last commit". If you need plain vanilla,
> the "hard way" now is to just do
> 
> 	commit-id >.git/HEAD
> 
> but your current HEAD will be lost forever. Or do
> 
> 	git fork vanilla ~/vanilla linus
> 
> and you will have the vanilla tree tracking linus in ~/vanilla.

Yep, symlinked in nice way. Good trap; it cought me ;-). (I of course
deleted the original directory).

> I'm not yet sure if we should have some Cogito interface for doing this
> and what its semantics should be.

Perhaps "git init" is right command for this? Running it in non-empty
directory for faster restart after bad problem....
								Pavel
-- 
Boycott Kodak -- for their patent abuse against Java.
