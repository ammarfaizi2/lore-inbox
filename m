Return-Path: <linux-kernel-owner+willy=40w.ods.org-S935791AbWLCK4J@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935791AbWLCK4J (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Dec 2006 05:56:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S935788AbWLCK4J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Dec 2006 05:56:09 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:41650 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S935784AbWLCK4I (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Dec 2006 05:56:08 -0500
Date: Sun, 3 Dec 2006 11:21:09 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: Al Viro <viro@ftp.linux.org.uk>, Thomas Gleixner <tglx@linutronix.de>,
       Matthew Wilcox <matthew@wil.cx>, Linus Torvalds <torvalds@osdl.org>,
       linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC] timers, pointers to functions and type safety
Message-ID: <20061203102108.GA1724@elf.ucw.cz>
References: <20061201172149.GC3078@ftp.linux.org.uk> <1165084076.24604.56.camel@localhost.localdomain> <20061202184035.GL3078@ftp.linux.org.uk> <200612022243.58348.zippel@linux-m68k.org> <20061202215941.GN3078@ftp.linux.org.uk> <Pine.LNX.4.64.0612022306360.1867@scrub.home> <20061202224018.GO3078@ftp.linux.org.uk> <Pine.LNX.4.64.0612022345520.1867@scrub.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0612022345520.1867@scrub.home>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > The other alternative has real _practical_ value in almost every case, 
> > > which I very much prefer. What's wrong with that?
> > 
> > Lack of any type safety whatsoever, magic boilerplates in callback instances,
> > rules more complex than "your callback should take a pointer, don't cast
> > anything, it's just a way to arrange for a delayed call, nothing magical
> > needed"?
> 
> I admit the compile check in SETUP_TIMER() is clever, but this way all the
> magic is in this place and is it really worth it? You're only adding _one_ 
> extra typecheck for mostly simple cases anyway.

Well, there are so many of these simple changes, that SETUP_TIMER()
with its clever trick looks very useful.
									Pavel

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
