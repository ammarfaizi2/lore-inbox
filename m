Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262172AbVDWXXJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262172AbVDWXXJ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Apr 2005 19:23:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262173AbVDWXXJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Apr 2005 19:23:09 -0400
Received: from w241.dkm.cz ([62.24.88.241]:13240 "HELO machine.sinus.cz")
	by vger.kernel.org with SMTP id S262172AbVDWXXE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Apr 2005 19:23:04 -0400
Date: Sun, 24 Apr 2005 01:23:03 +0200
From: Petr Baudis <pasky@ucw.cz>
To: Pavel Machek <pavel@ucw.cz>
Cc: Linus Torvalds <torvalds@osdl.org>,
       kernel list <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.6.12-rc3
Message-ID: <20050423232303.GK13222@pasky.ji.cz>
References: <Pine.LNX.4.58.0504201728110.2344@ppc970.osdl.org> <20050421112022.GB2160@elf.ucw.cz> <20050421120327.GA13834@elf.ucw.cz> <20050421162220.GD30991@pasky.ji.cz> <20050421232201.GD31207@elf.ucw.cz> <20050422002150.GY7443@pasky.ji.cz> <20050422231839.GC1789@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050422231839.GC1789@elf.ucw.cz>
User-Agent: Mutt/1.4i
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dear diary, on Sat, Apr 23, 2005 at 01:18:39AM CEST, I got a letter
where Pavel Machek <pavel@ucw.cz> told me that...
> git patch origin:
> 
> will list my patches, plus any merges I done... Is there any
> reasonable way to get only "my" changes? When I do not have to resolve
> anything during merge, it should be usable... but that is starting to
> look ugly.

I told you the semantics is peculiar.

We could add a flag to rev-tree to always follow only the first parent;
that would be useful even for a flag for git log to "flatten" the
history, if you aren't interested in what was going on in the trees you
just merged.

Another flag to avoid showing patches for merges might be possible, but
actually a little scary since you don't have consistency assured that
way; your post-merge patches might generate rejects when applied on top
of the pre-merge patches, or your pre-merge patches might not apply
cleanly on the tree you merged with.

So if you want to ignore merges, it sounds that you are probably
actually doing something wrong. We might still let you do it assuming
that you know what are you doing and you will test the patches for
applying to whatever you want to apply them on, but with a big
exclamation mark.

Patches welcome, if anyone wants to do it before I get to it. ;-)

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
C++: an octopus made by nailing extra legs onto a dog. -- Steve Taylor
