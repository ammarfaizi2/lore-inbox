Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266271AbRGGRUq>; Sat, 7 Jul 2001 13:20:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266483AbRGGRUg>; Sat, 7 Jul 2001 13:20:36 -0400
Received: from humbolt.nl.linux.org ([131.211.28.48]:23819 "EHLO
	humbolt.nl.linux.org") by vger.kernel.org with ESMTP
	id <S266271AbRGGRUZ>; Sat, 7 Jul 2001 13:20:25 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: Jeff Garzik <jgarzik@mandrakesoft.com>,
        Eugene Crosser <crosser@average.org>
Subject: Re: [Acpi] Re: ACPI fundamental locking problems
Date: Sat, 7 Jul 2001 19:24:11 +0200
X-Mailer: KMail [version 1.2]
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.GSO.4.21.0107070727030.24836-100000@weyl.math.psu.edu> <9i73bg$psv$1@pccross.average.org> <3B471399.1D6BBED6@mandrakesoft.com>
In-Reply-To: <3B471399.1D6BBED6@mandrakesoft.com>
MIME-Version: 1.0
Message-Id: <01070719241107.22952@starship>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 07 July 2001 15:50, Jeff Garzik wrote:
> Eugene Crosser wrote:
> > In article
> > <Pine.GSO.4.21.0107070727030.24836-100000@weyl.math.psu.edu>,
> >
> >         Alexander Viro <viro@math.psu.edu> writes:
> > >> Doesn't the approach "treat a chunk of data built into bzImage
> > >> as populated ramfs" look cleaner?  No need to fiddle with tar
> > >> format, no copying data from place to place.
> > >
> > > What the hell _is_ "populated ramfs"? The thing doesn't live in
> > > array of blocks. Its directory structure consists of a bunch of
> > > dentries.
> >
> > I am stupid.  But the point still stays: having an image of
> > pre-populated filesystem (some other than ramfs) that you only need
> > to load into RAM seems more sutable than parsing tar format.  Maybe
> > (probably) I am missing something.
>
> Yeah -- we build all this stuff dynamically.  struct file, struct
> inode, etc.  You could store them on disk as they would be
> represented in memory, but this would be incredibly inefficient
> because of all the runtime structures unnecessary on disk, and
> because of all the fixups and checks you would have to perform on the
> data in the images after they magically appear in memory.

Not to mention internal fragmentation.

> Reading a tarball is the distillation of what you describe into
> efficient form :)

/me downloads tar file definition

Um, gnu tar or posix tar? or some new, improved tar?

--
Daniel
