Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262664AbSJ0VxJ>; Sun, 27 Oct 2002 16:53:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262667AbSJ0VxJ>; Sun, 27 Oct 2002 16:53:09 -0500
Received: from smtpout.mac.com ([204.179.120.85]:9431 "EHLO smtpout.mac.com")
	by vger.kernel.org with ESMTP id <S262664AbSJ0VxI>;
	Sun, 27 Oct 2002 16:53:08 -0500
Message-ID: <3DBC625C.2EBA36D6@mac.com>
Date: Sun, 27 Oct 2002 23:02:04 +0100
From: Peter Waechtler <pwaechtler@mac.com>
X-Mailer: Mozilla 4.8 [de] (X11; U; Linux 2.4.18-4GB-SMP i686)
X-Accept-Language: de, en
MIME-Version: 1.0
To: Alexander Viro <viro@math.psu.edu>
CC: linux-kernel@vger.kernel.org, jakub@redhat.com, torvalds@transmeta.com
Subject: Re: [PATCH] unified SysV and Posix mqueues as FS
References: <Pine.GSO.4.21.0210271052170.1416-100000@steklov.math.psu.edu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alexander Viro schrieb:
> 
> On Sun, 27 Oct 2002, Peter Waechtler wrote:
> 
> > I applied the patch from Jakub against 2.5.44
> > There are still open issues but it's important to get this in before
> > feature freeze.
> >
> > While you can implement Posix mqueues in userland (Irix is doing this
> > with fcntl(fd,F_SETLKW,) and shmem) a kernel implementation has some advantages:
> 
> *thud*
> 
> ioctls on _directories_, of all things?

Parden? Where are directories used?
create a file, give it a size, mmap it and serialize access to it with locks.
That's all.
