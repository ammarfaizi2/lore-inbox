Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261797AbVDUTKU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261797AbVDUTKU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Apr 2005 15:10:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261800AbVDUTKT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Apr 2005 15:10:19 -0400
Received: from w241.dkm.cz ([62.24.88.241]:60805 "HELO machine.sinus.cz")
	by vger.kernel.org with SMTP id S261797AbVDUTKI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Apr 2005 15:10:08 -0400
Date: Thu, 21 Apr 2005 21:09:56 +0200
From: Petr Baudis <pasky@ucw.cz>
To: Pavel Machek <pavel@ucw.cz>
Cc: Linus Torvalds <torvalds@osdl.org>,
       kernel list <linux-kernel@vger.kernel.org>, git@vger.kernel.org
Subject: Re: Linux 2.6.12-rc3
Message-ID: <20050421190956.GA7443@pasky.ji.cz>
References: <Pine.LNX.4.58.0504201728110.2344@ppc970.osdl.org> <20050421112022.GB2160@elf.ucw.cz> <20050421120327.GA13834@elf.ucw.cz> <20050421162220.GD30991@pasky.ji.cz> <20050421190009.GC475@openzaurus.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050421190009.GC475@openzaurus.ucw.cz>
User-Agent: Mutt/1.4i
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dear diary, on Thu, Apr 21, 2005 at 09:00:09PM CEST, I got a letter
where Pavel Machek <pavel@ucw.cz> told me that...
> Hi!

Hi,

> > > Well, not sure.
> > > 
> > > I did 
> > > 
> > > git track linus
> > > git cancel
> > > 
> > > but Makefile still contains -rc2. (Is "git cancel" right way to check
> > > out the tree?)
> > 
> > No. git cancel does what it says - cancels your local changes to the
> > working tree. git track will only set that next time you pull from
> > linus, the changes will be automatically merged. (Note that this will
> > change with the big UI change.)
> 
> Is there way to say "forget those changes in my repository, I want
> just plain vanilla" without rm -rf?

git cancel will give you "plain last commit". If you need plain vanilla,
the "hard way" now is to just do

	commit-id >.git/HEAD

but your current HEAD will be lost forever. Or do

	git fork vanilla ~/vanilla linus

and you will have the vanilla tree tracking linus in ~/vanilla.

I'm not yet sure if we should have some Cogito interface for doing this
and what its semantics should be.

> I see quite a lot of problems with fsck-tree. Is that normal?
> (I ran out of disk space few times during different operations...)

Actually, in case your tree is older than about two days, I hope you did
the convert-cache magic or fetched a fresh tree?

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
C++: an octopus made by nailing extra legs onto a dog. -- Steve Taylor
