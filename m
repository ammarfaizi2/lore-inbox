Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288342AbSA3IhN>; Wed, 30 Jan 2002 03:37:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288579AbSA3IhD>; Wed, 30 Jan 2002 03:37:03 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:27084 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S288342AbSA3Igv>;
	Wed, 30 Jan 2002 03:36:51 -0500
Date: Wed, 30 Jan 2002 03:36:45 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: Linus Torvalds <torvalds@transmeta.com>
cc: Daniel Phillips <phillips@bonn-fries.net>, mingo@elte.hu,
        Rob Landley <landley@trommello.org>, linux-kernel@vger.kernel.org
Subject: Re: A modest proposal -- We need a patch penguin
In-Reply-To: <Pine.LNX.4.33.0201300002170.1542-100000@penguin.transmeta.com>
Message-ID: <Pine.GSO.4.21.0201300310330.11157-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 30 Jan 2002, Linus Torvalds wrote:

> Now, that obviously does imply a certain control over low-level
> filesystems, but it really mainly implies a control over the _interfaces_
> used to talk the the filesystem, not the filesystem itself.
> 
> I personally really wouldn't mind seeing most filesystem patches coming
> through Al (and, in fact, in the inode trimming patches that is partly

I would, though.  Inode-trimming is a separate story - it's a massive series of
interface-changing patches (55 chunks already merged, more to follow) and
any help is certainly welcome - it's a friggin' lot of work (and there was
quite a help - from Jeff, Urban, Christoph...)

	However, I really don't want to be in position when patches to fs
internals are fed through me.  I can give comments.  I can do code review.
I can look through the code and discuss VFS/VM/etc. changes that might be
useful.  I can actually decide to do these changes myself.  That's all nice
and dandy, but let's face it - most of filesystem internals patches are pretty
local and fs maintainers _MUST_ be the first recepients of such patches.

	I don't have Alan's patience.  And I don't believe that I can run
a clearinghouse tree for *all* fs patches - it's pretty much guaranteed to end
up with burnout in a month or so.  BTW, IIRC Jeff Garzik had been doing
something similar unofficially, but I've no idea how he feels about giving
it official status.

	Frankly, the only real issue in that thread was that we _do_ need
a tree specifically for small fixes.  Preferably - quickly getting merged
into the main tree.  And that's a hard work - davej seems to be doing that
and I admire the efforts he's able and willing to put into that stuff.
I know that I couldn't pull that off.

