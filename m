Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262425AbSKHV3Z>; Fri, 8 Nov 2002 16:29:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262430AbSKHV3Z>; Fri, 8 Nov 2002 16:29:25 -0500
Received: from [195.39.17.254] ([195.39.17.254]:8452 "EHLO Elf.ucw.cz")
	by vger.kernel.org with ESMTP id <S262425AbSKHV3Y>;
	Fri, 8 Nov 2002 16:29:24 -0500
Date: Mon, 4 Nov 2002 14:02:34 +0100
From: Pavel Machek <pavel@suse.cz>
To: Alexander Viro <viro@math.psu.edu>
Cc: Linus Torvalds <torvalds@transmeta.com>,
       Rik van Riel <riel@conectiva.com.br>, "Theodore Ts'o" <tytso@mit.edu>,
       Dax Kelson <dax@gurulabs.com>, Rusty Russell <rusty@rustcorp.com.au>,
       linux-kernel@vger.kernel.org, davej@suse.de
Subject: Re: Filesystem Capabilities in 2.6?
Message-ID: <20021104130225.GA5482@zaurus>
References: <Pine.LNX.4.44.0211021619580.2221-100000@home.transmeta.com> <Pine.GSO.4.21.0211021926540.25010-100000@steklov.math.psu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.GSO.4.21.0211021926540.25010-100000@steklov.math.psu.edu>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > And pathnames are a _hell_ of a lot better and straightforward interface
> > than inode numbers are. It's confusing when you change the permission on
> > one path to notice that another path magically changed too.
> 
> It's equally confusing to find out that link(2) doesn't preserve
> file properties.
> 
> Frankly, I'm less than sure that ability to raise capabilities is
> a good thing - being able to drop them is certainly nice, but I doubt
> that partial suid-root will be better than full suid-root and it
> certainly makes security model even more complex.  And incomplete

I dont think its good idea to add capabilities
this way: make fs capabilities drop only, and
if you want to raise, make it setuid root.

Kernel will see its suid, will raise capabilities, and
then drop them according to the fs fields.

Thats okay, and old apps will see its suid root
and treat it with care.

The only bad thing about this is how to make
something suid games, addcap hw access.
			PavelEnd_of_mail_magic_5574
