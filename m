Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316667AbSIEDyB>; Wed, 4 Sep 2002 23:54:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316674AbSIEDyB>; Wed, 4 Sep 2002 23:54:01 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:27889 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S316667AbSIEDyA>;
	Wed, 4 Sep 2002 23:54:00 -0400
Date: Wed, 4 Sep 2002 23:58:30 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Edgar Toernig <froese@gmx.de>
cc: ptb@it.uc3m.es, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: (fwd) Re: [RFC] mount flag "direct"
In-Reply-To: <3D76D142.AFD9E991@gmx.de>
Message-ID: <Pine.GSO.4.21.0209042342420.12135-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 5 Sep 2002, Edgar Toernig wrote:

> "Peter T. Breuer" wrote:
> > 
> > The point is not to choose a file system, but to be able to use
> > whichever one is preferable _at the time_. This is important.
> 
> Heck, then take regular nfs.  It works with any/most filesystems
> and does all you want.  This discussion has become so silly...

	Indeed.

	BTW, speaking of NFS...  Peter, you _do_ realize that stuff done in
generic layers must make sense for that animal, not only for ext2/FAT/etc.?
Now check how many things you were talking about do make sense for network
filesystems.  That's right, none.

	You want to modify filesystem code - go ahead and do it.  You want
to make filesystem-independent modifications - VFS is the right place, but
they'd better _be_ filesystem-independent.

	Making VFS aware of clustering (i.e. allowing filesystems to
notice when we are trying to grab parent for some operation) _DOES_ make
sense and at some point we will have to go through existing filesystems
that attempt something of that kind and see what kind of interface would
make sense.  Wanking about grand half-arsed schemes and plugging holes
pointed to you with duct-tape and lots of handwaving, OTOH...

