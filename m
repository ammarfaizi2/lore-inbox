Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283288AbRLWDwu>; Sat, 22 Dec 2001 22:52:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283311AbRLWDwk>; Sat, 22 Dec 2001 22:52:40 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:28891 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S283288AbRLWDwZ>;
	Sat, 22 Dec 2001 22:52:25 -0500
Date: Sat, 22 Dec 2001 22:52:24 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: Dave Cinege <dcinege@psychosis.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: Booting a modular kernel through a multiple streams file
In-Reply-To: <E16Hysa-0002kc-00@schizo.psychosis.com>
Message-ID: <Pine.GSO.4.21.0112222240530.21702-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 22 Dec 2001, Dave Cinege wrote:

> On Saturday 22 December 2001 21:10, Alexander Viro wrote:
> 
> > > cpio is trivial.  tar is a bit more painful, but not too bad.  gzip is
> > > unacceptable, but should not be required.
> >
> > tar is ugly as hell and not going to be supported on the kernel side.
> 
> Excellent! You've settled on using using an archiver format nobody uses,
> instead of the defacto standard that's already been implemented by
> atleast two people.
> 			G-E-N-I-U-S!

OK, back into the killfile you go.

Hint: instead of wanking in public try to _think_ for a while.  Requirements
to archive format:
	* can be generated with minimum of code
	* can be parsed <ditto>
	* can be handled by standard utilities
That's it.  Both cpio(1) and tar(1) (or pax(1) that can do both) fit the last
one.  And tar loses on the first two - it's messier.  Not much, but enough
to make the choice obvious.  "Popular" is completely irrelevant here - as long
as it's handled by standard UNIX utilities it's OK.

