Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261920AbSJEAph>; Fri, 4 Oct 2002 20:45:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261922AbSJEAph>; Fri, 4 Oct 2002 20:45:37 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:27792 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S261920AbSJEApg>;
	Fri, 4 Oct 2002 20:45:36 -0400
Date: Fri, 4 Oct 2002 20:51:10 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Linus Torvalds <torvalds@transmeta.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: oops in bk pull (oct 03)
In-Reply-To: <Pine.LNX.4.44.0210041737500.2993-100000@home.transmeta.com>
Message-ID: <Pine.GSO.4.21.0210042045010.21250-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 4 Oct 2002, Linus Torvalds wrote:

> 
> On Fri, 4 Oct 2002, Alexander Viro wrote:
> > 
> > It is repeatable, it does happen with current BK (well, as of couple
> > of hours ago) and reverting pci/probe.c change apparently cures it.
> 
> Really? That probe.c diff is _really_ small, and looks truly obvious. In 
> particular, I don't see how it could possibly cause that kind of 
> behaviour. What am I missing?

Hell knows.  The only explanation I see (and that's not worth much) is that
we somehow confuse the chipset and get crapped on something like next cache
miss.

I'm out of ideas on that one - if you have any suggestions / questions on
details of behaviour I'll be glad to try and see what I can do, but for
now I'm reverting the probe.c patch in my tree so that I could return to
initramfs work.  Originally I thought it was a bug in my own code, but oops
is present in 2.5.40-BK and disappears in 2.5.40-BK minus probe.c changeset...

