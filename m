Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317181AbSEXQWU>; Fri, 24 May 2002 12:22:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317186AbSEXQWT>; Fri, 24 May 2002 12:22:19 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:43965 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S317181AbSEXQWR>;
	Fri, 24 May 2002 12:22:17 -0400
Date: Fri, 24 May 2002 12:22:17 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Linus Torvalds <torvalds@transmeta.com>
cc: Andrea Arcangeli <andrea@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: negative dentries wasting ram
In-Reply-To: <Pine.LNX.4.44.0205240737400.26171-100000@home.transmeta.com>
Message-ID: <Pine.GSO.4.21.0205241215340.9792-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 24 May 2002, Linus Torvalds wrote:

> However, you're right that it probably doesn't help to do this after
> "unlink()" - it's probably only worth doing when actually doing a
> "lookup()" that fails.

Depends on many things, including the amount of userland code that does
	unlink(name);
	open(name, O_CREAT|O_EXCL..., ...);

