Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261425AbRGENoo>; Thu, 5 Jul 2001 09:44:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263862AbRGENoe>; Thu, 5 Jul 2001 09:44:34 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:48258 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S261425AbRGENo1>;
	Thu, 5 Jul 2001 09:44:27 -0400
Date: Thu, 5 Jul 2001 09:42:55 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Helge Hafting <helgehaf@idb.hist.no>
cc: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: Re: [Acpi] Re: ACPI fundamental locking problems
In-Reply-To: <3B442354.BCA61010@idb.hist.no>
Message-ID: <Pine.GSO.4.21.0107050932340.17575-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 5 Jul 2001, Helge Hafting wrote:

> Linus Torvalds wrote:
> [...]
> > We migth want to just make initrd a built-in thing in the kernel,
> > something that you simply cannot avoid. A lot of these things (ie dhcp for
> > NFS root etc) are right now done in kernel space, simply because we don't
> > want to depend on initrd, and people want to use old loaders.
> > 
> > I don't like the current initrd very much myself, I have to admit. I'm not
> > going to accept a "you have to have a ramdisk" approach - I think the
> > ramdisks are really broken.
> > 
> > But I've seen a "populate ramfs from a tar-file built into 'bzImage'"
> > patch somewhere, and that would be a whole lot more palatable to me.
> > 
> > If anybody were to send me a patch that just unconditionally does this, I
> > would probably not be adverse to putting it into 2.5.x. We have all the
> > infrastructure to make all this a lot cleaner than it used to be (ie the
> > "pivot_root()" stuff etc means that we can _truly_ do things from user
> > mode, with no magic kernel flags).

Open 2.5 and I'm starting to feed that stuff in pieces...

> I am fine with "You have to use initrd (or similiar) _if_ you want this
> feature."

"Similar" == ramfs.

> But please don't make initrd mandatory for those of us who don't
> need ACPI, don't need dhcp before mounting disks and so on.

How about "don't want to keep special-case code for mounting root in your
kernel"? It's more than ramfs, BTW, and rm(1) on ramfs frees memory just
fine.

