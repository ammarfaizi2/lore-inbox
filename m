Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262807AbSJ1BsC>; Sun, 27 Oct 2002 20:48:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262808AbSJ1BsC>; Sun, 27 Oct 2002 20:48:02 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:30964 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S262807AbSJ1BsB>;
	Sun, 27 Oct 2002 20:48:01 -0500
Date: Sun, 27 Oct 2002 20:54:00 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: Peter Waechtler <pwaechtler@mac.com>
cc: linux-kernel@vger.kernel.org, jakub@redhat.com, torvalds@transmeta.com
Subject: Re: [PATCH] unified SysV and Posix mqueues as FS
In-Reply-To: <3DBC625C.2EBA36D6@mac.com>
Message-ID: <Pine.GSO.4.21.0210272053240.3884-100000@steklov.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 27 Oct 2002, Peter Waechtler wrote:

> Alexander Viro schrieb:
> > 
> > On Sun, 27 Oct 2002, Peter Waechtler wrote:
> > 
> > > I applied the patch from Jakub against 2.5.44
> > > There are still open issues but it's important to get this in before
> > > feature freeze.
> > >
> > > While you can implement Posix mqueues in userland (Irix is doing this
> > > with fcntl(fd,F_SETLKW,) and shmem) a kernel implementation has some advantages:
> > 
> > *thud*
> > 
> > ioctls on _directories_, of all things?
> 
> Parden? Where are directories used?
> create a file, give it a size, mmap it and serialize access to it with locks.
> That's all.

Check your file_operations for root directory.

