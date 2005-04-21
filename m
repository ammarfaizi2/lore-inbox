Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261503AbVDUQXG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261503AbVDUQXG (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Apr 2005 12:23:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261502AbVDUQXG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Apr 2005 12:23:06 -0400
Received: from w241.dkm.cz ([62.24.88.241]:53378 "HELO machine.sinus.cz")
	by vger.kernel.org with SMTP id S261503AbVDUQWX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Apr 2005 12:22:23 -0400
Date: Thu, 21 Apr 2005 18:22:20 +0200
From: Petr Baudis <pasky@ucw.cz>
To: Pavel Machek <pavel@ucw.cz>
Cc: Linus Torvalds <torvalds@osdl.org>,
       kernel list <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.6.12-rc3
Message-ID: <20050421162220.GD30991@pasky.ji.cz>
References: <Pine.LNX.4.58.0504201728110.2344@ppc970.osdl.org> <20050421112022.GB2160@elf.ucw.cz> <20050421120327.GA13834@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050421120327.GA13834@elf.ucw.cz>
User-Agent: Mutt/1.4i
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dear diary, on Thu, Apr 21, 2005 at 02:03:27PM CEST, I got a letter
where Pavel Machek <pavel@ucw.cz> told me that...
> > You should put this into .git/remotes
> > 
> > linus	rsync://www.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git

(git addremote is preferred for that :-)

> > Then
> > 
> > RSYNC_FLAGS=-zavP git pull linus

-v is passed to rsync by default. I'll gladly add other reasonable rsync
flags (I don't call printing each considered file reasonable; fsck or
wget-like progressbar would be ideal).

> Well, not sure.
> 
> I did 
> 
> git track linus
> git cancel
> 
> but Makefile still contains -rc2. (Is "git cancel" right way to check
> out the tree?)

No. git cancel does what it says - cancels your local changes to the
working tree. git track will only set that next time you pull from
linus, the changes will be automatically merged. (Note that this will
change with the big UI change.)

Either do

	git track linus
	git pull

or

	git merge linus

to get Linus' changes if you didn't pull yet.

> and git diff -r linus: still contains some changes. [I did some
> experimental pull of scsi changes long time ago, is it that problem?]

If you don't have your HEAD on Linus' branch, it will do a tree merge
instead of fast-forward; that is, it will not just move your HEAD on
to match Linus' HEAD, but it will make a regular merge and then ask you
to do a merge commit.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
C++: an octopus made by nailing extra legs onto a dog. -- Steve Taylor
