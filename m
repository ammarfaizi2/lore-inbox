Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263249AbSJ1Kff>; Mon, 28 Oct 2002 05:35:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263256AbSJ1Kff>; Mon, 28 Oct 2002 05:35:35 -0500
Received: from smtpout.mac.com ([204.179.120.89]:51660 "EHLO smtpout.mac.com")
	by vger.kernel.org with ESMTP id <S263249AbSJ1Kfd>;
	Mon, 28 Oct 2002 05:35:33 -0500
Message-ID: <3DBD1527.17B4B502@mac.com>
Date: Mon, 28 Oct 2002 11:44:55 +0100
From: Peter Waechtler <pwaechtler@mac.com>
X-Mailer: Mozilla 4.8 [de] (X11; U; Linux 2.4.18-4GB-SMP i686)
X-Accept-Language: de, en
MIME-Version: 1.0
To: Alexander Viro <viro@math.psu.edu>
CC: linux-kernel@vger.kernel.org, jakub@redhat.com, torvalds@transmeta.com
Subject: Re: [PATCH] unified SysV and Posix mqueues as FS
References: <Pine.GSO.4.21.0210272053240.3884-100000@steklov.math.psu.edu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alexander Viro schrieb:
> 
> On Sun, 27 Oct 2002, Peter Waechtler wrote:
> 
> > Alexander Viro schrieb:
> > >
> > > On Sun, 27 Oct 2002, Peter Waechtler wrote:
> > >
> > > > I applied the patch from Jakub against 2.5.44
> > > > There are still open issues but it's important to get this in before
> > > > feature freeze.
> > > >
> > > > While you can implement Posix mqueues in userland (Irix is doing this
> > > > with fcntl(fd,F_SETLKW,) and shmem) a kernel implementation has some advantages:
> > >
> > > *thud*
> > >
> > > ioctls on _directories_, of all things?
> >
> > Parden? Where are directories used?
> > create a file, give it a size, mmap it and serialize access to it with locks.
> > That's all.
> 
> Check your file_operations for root directory.

Umh, misunderstanding: I thought you commented on the Irix part.
And it's not my patch, it's Jakub Jelineks patch I applied against current 2.5

I don't even see an advantage on having them as filesystem - I just think
that the SysV and Posix mqueues should share most of the code.
