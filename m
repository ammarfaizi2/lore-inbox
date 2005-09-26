Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964772AbVIZXXL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964772AbVIZXXL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Sep 2005 19:23:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932525AbVIZXXK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Sep 2005 19:23:10 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:39380 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S932523AbVIZXXJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Sep 2005 19:23:09 -0400
Date: Tue, 27 Sep 2005 01:22:27 +0200
From: Pavel Machek <pavel@ucw.cz>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 3/3][Fix] swsusp: prevent swsusp from failing if there's too many pagedir pages
Message-ID: <20050926232227.GB8635@elf.ucw.cz>
References: <200509252018.36867.rjw@sisk.pl> <200509261454.09702.rjw@sisk.pl> <20050926142608.GA32249@elf.ucw.cz> <200509262119.27240.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200509262119.27240.rjw@sisk.pl>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

[Andrew killed from Cc, lets not flood his mailbox].

> > > Unfortunately it's not enough for what I'm cooking (think of resuming in 35 sec.
> > > to a fully responsive system - well, that's on my box).  A preliminary patch
> > > is at http://www.sisk.pl/kernel/patches/2.6.14-rc2-git3/swsusp-improve-freeing-memory.patch
> > 
> > Okay, I see, nice... We want to support that in future. (Actually it
> > is last piece of puzzle for swsusp3).
> 
> Well, it can be implemented within the current swsusp, IMO.  It actually
> works for me now. :-)

Agreed, and swsusp3 provides graphical progress bar, esc-to-escape,
and "are you sure you want to crash your machine" dialogs :-).

> > I plan to push "rework image freeing patch" for other reasons,
> > too. I'd like to run longer tests on it, but so far it looks okay.
> 
> I think it's fine.  Could you please point me to the current version?

Well, its a bit complicated. I have 3 related trees on kernel.org:

linux-good -- that are basically patches I either already sent
upstream or that I plan to send very soon. Unfortunately I did not yet
have time to apply all your stuff that you sent me for akpm; I'll need
to pull them from -mm and apply here.

linux -- that is my working tree. It contains some stuff you
probably do not want (like special keymap).

linux-sw3 -- and that's a tree to test suspending from userland, aka
swsusp3 (aka uswsusp). Currently stuck at 2.6.13 ("first make it work,
then port it to HEAD"), and it seems to work (but you should really
know what you are doing, and use ext2). usr/swsusp.c is the userland
program to do suspending.

								Pavel
-- 
if you have sharp zaurus hardware you don't need... you know my address
