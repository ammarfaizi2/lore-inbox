Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261528AbSKCAiN>; Sat, 2 Nov 2002 19:38:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261524AbSKCAhl>; Sat, 2 Nov 2002 19:37:41 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:30396 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S261528AbSKCAhb>;
	Sat, 2 Nov 2002 19:37:31 -0500
Date: Sat, 2 Nov 2002 19:43:59 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: Linus Torvalds <torvalds@transmeta.com>
cc: Rik van Riel <riel@conectiva.com.br>, "Theodore Ts'o" <tytso@mit.edu>,
       Dax Kelson <dax@gurulabs.com>, Rusty Russell <rusty@rustcorp.com.au>,
       linux-kernel@vger.kernel.org, davej@suse.de
Subject: Re: Filesystem Capabilities in 2.6?
In-Reply-To: <Pine.LNX.4.44.0211021619580.2221-100000@home.transmeta.com>
Message-ID: <Pine.GSO.4.21.0211021926540.25010-100000@steklov.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 2 Nov 2002, Linus Torvalds wrote:

> 
> On Sat, 2 Nov 2002, Rik van Riel wrote:
> > 
> > Sure it's more flexible, but I wonder how many userland
> > programs will be broken if we change the permission model
> > and how well users can protect their data this way.
> 
> This is not a "change". Existing behaviour clearly cannot change. We're 
> talking about new interfaces to export capabilities in the filesystem.
> 
> And pathnames are a _hell_ of a lot better and straightforward interface
> than inode numbers are. It's confusing when you change the permission on
> one path to notice that another path magically changed too.

It's equally confusing to find out that link(2) doesn't preserve
file properties.

Frankly, I'm less than sure that ability to raise capabilities is
a good thing - being able to drop them is certainly nice, but I doubt
that partial suid-root will be better than full suid-root and it
certainly makes security model even more complex.  And incomplete
understanding of security model is a great recipe for PITA - demonstrated
way too many times already...

Folks, seriously - it might be very tempting to add features in that
area, but more features actually increase overall security.  Just look
at the track record of systems with baroque security models and ask
yourself whether we want to go there.

